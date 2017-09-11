//
//  UserProfileHeader.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 10/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    @IBOutlet var gridButton: UIButton!
    @IBOutlet var listButton: UIButton!
    @IBOutlet var ribbonButton: UIButton!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var profileImageView: CircleImage!
    
    
    var user: User? {
        didSet {
            setupProfileImage()
            userNameLabel.text = self.user?.username
        }
    }
        
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    @IBAction func gridBtnPressed(_ sender: Any) {
    }

    @IBAction func ribbonBtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func listButtonPressed(_ sender: Any) {
    }
    
    fileprivate func setupProfileImage()
    {
        guard let profileImageUrl = user?.profileImageUrl else { return }
        //print("Profile Image got",profileImageUrl)
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            // print(data)
            if let err = err
            {
                print("Falied to fetch error", err)
                return
            }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                
                self.profileImageView.image = image
            }
            
            }.resume()
        
    }
    
    
}
