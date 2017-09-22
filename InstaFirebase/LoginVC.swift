//
//  LoginVC.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 11/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loginPasswordField: UITextField!
    @IBOutlet var loginEmailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UINavigationBar.appearance().isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 0.6)
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "gotoSignUpVC", sender: nil)
       // let signUpController = SignUpController()
        //navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        guard let email = loginEmailField.text else  { return }
        guard let password = loginPasswordField.text  else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            
            if let err = err
            {
                print("Failed to Sign in with email", err)
                return
            }
            
            print("Successfully logged back in with user", user?.uid ?? "")
            
           self.performSegue(withIdentifier: "loginToTabBarVC", sender: nil)

        }
    }
    
    @IBAction func isLoginFormValid(_ sender: Any) {
        
        let isFormValid = loginEmailField.text?.characters.count ?? 0 > 0 &&
            loginPasswordField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1.0)
        }
        else
        {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 0.6)
            
        }
    }
    
}
