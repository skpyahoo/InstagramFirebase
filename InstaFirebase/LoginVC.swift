//
//  LoginVC.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 11/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UINavigationBar.appearance().isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
     
        
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
}
