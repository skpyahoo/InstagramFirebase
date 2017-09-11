//
//  MainTabBarController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 09/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil
        {
            DispatchQueue.main.async {
                //let loginController = LoginController()
                //self.present(loginController, animated: true, completion: nil)
                self.performSegue(withIdentifier: "gotoLoginVC", sender: nil)
            }
            
            return
        }

        //UINavigationBar.appearance().barTintColor = UIColor(red: 35/255, green: 90/255, blue: 141/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = .lightContent
        tabBar.tintColor = .black
        
        
        
    }



}
