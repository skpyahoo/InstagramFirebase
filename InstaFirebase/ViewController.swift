//
//  ViewController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 08/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var profileButton: RoundButton!
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 0.6)
        
        imagePickerController.delegate = self
    }


    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, email.characters.count > 0 else { return }
        guard let password = passwordTextField.text, password.characters.count > 0 else { return }
        guard let username = userNameTextField.text, username.characters.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion:  { (user, error) in
            
            if let err = error
            {
                print("Cannot create new user.\(err)")
                return
            }
            
            guard let image = self.profileButton.imageView?.image else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            let fileName = NSUUID().uuidString
            Storage.storage().reference().child("profile-images").child(fileName).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err
                {
                    print("Failed to upload the image", err)
                    return
                }
                
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                print("Successfully Uploaded the profile Image",profileImageUrl)
                
                let userData = ["email": email,
                               "username":username,
                               "profileImageUrl":profileImageUrl]
                
                guard let uid = user?.uid else { return }
                
                print("Successfully created new user", user?.uid ?? "")
                
                Database.database().reference().child("users").child(uid).updateChildValues(userData, withCompletionBlock: { (err, ref) in
                    
                    if let err = err
                    {
                        print("User info is not saved, error occured",err)
                        return
                    }
                    
                    print("Successfully entered user information into db")
                })

            })
            
            
        })
        
    }

    @IBAction func isFormValid(_ sender: Any) {
        
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 &&
                          userNameTextField.text?.characters.count ?? 0 > 0 &&
                          passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1.0)
        }
        else
        {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 0.6)
            
        }
    }
    
    @IBAction func profileBtnPressed(_ sender: Any) {
        
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
         {
            profileButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
         } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
         {
            profileButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
