//
//  MainTabBarController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 09/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        if Auth.auth().currentUser == nil
        {
            DispatchQueue.main.async {
                //let loginController = LoginController()
                //self.present(loginController, animated: true, completion: nil)
                self.performSegue(withIdentifier: "gotoLoginVC", sender: nil)
            }
            
            return
        }
        

       UINavigationBar.appearance().isHidden = false
        //UINavigationBar.appearance().tintColor = UIColor.white

        UIApplication.shared.statusBarStyle = .default
        tabBar.tintColor = .black
        
        guard let items = tabBar.items else { return }
        
        for item in items
        {
            item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        }
     
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        
        if index == 2
        {
            
            self.performSegue(withIdentifier: "gotoPhotoVC", sender: nil)
            return false
            
            
        }
        
        return true
            
    }
    

}
