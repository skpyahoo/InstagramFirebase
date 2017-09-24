//
//  SharePhotoController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 13/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {

    @IBOutlet var SelectedPhotoImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var textView: UITextView!
    
    var selectedImage: UIImage?
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UINavigationBar.appearance().tintColor = .black
        UIApplication.shared.isStatusBarHidden = true
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        UINavigationBar.appearance().tintColor = .black
        UIApplication.shared.isStatusBarHidden = true
        if let img = selectedImage
        {
            self.SelectedPhotoImageView.image = img
        }
        
    }
    
    
    @IBAction func sharePhotoBtnPressed(_ sender: Any) {
        
        guard let image = selectedImage else { return }
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        guard let caption = textView.text, caption.characters.count > 0 else { return }
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        let fileName = NSUUID().uuidString
        Storage.storage().reference().child("Post-Images").child(fileName).putData(uploadData, metadata: nil) { (metaData, err) in
            
            if let err = err
            {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Falied to upload the image", err)
                return
            }
            
            guard let imageUrl = metaData?.downloadURL()?.absoluteString else { return }
            
            print("Successfully Uploaded post image", imageUrl)
            
            self.saveToDatabasewithImageUrl(imageUrl: imageUrl)
            
        }
    }
    
    fileprivate func saveToDatabasewithImageUrl(imageUrl: String)
    {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let caption = textView.text else { return }
        guard let postImage = selectedImage  else { return }
        
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        
        let values = ["imageUrl": imageUrl,
                      "caption": caption,
                      "imageWidth": postImage.size.width,
                      "imageHeight": postImage.size.height,
                      "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            
            if let err = err
            {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post on DB", err)
                return
            }
            
            print("Successfully uploaded post to DB")
            self.dismiss(animated: true, completion: nil)
            
            
            NotificationCenter.default.post(name: SharePhotoController.updateFeedNotificationName, object: nil)
            
        }
    }
}
