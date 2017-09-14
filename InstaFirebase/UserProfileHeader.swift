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
    @IBOutlet var profileImageView: CustomImageView!
    
    
    
    var user: User? {
        didSet {
            guard let profileImgUrl = user?.profileImageUrl else { return }
            
            profileImageView.loadImage(urlString: profileImgUrl)
            
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
    
    
    
}
