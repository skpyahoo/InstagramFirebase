//
//  UserSearchCell.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 16/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class UserSearchCell: UICollectionViewCell {
    
    @IBOutlet var profileImageView: CustomImageView!
    @IBOutlet var usernameLabel: UILabel!
    
    var user: User? {
        
        didSet {
            usernameLabel.text = user?.username
            
            guard let profileImgUrl = user?.profileImageUrl  else { return }
            profileImageView.loadImage(urlString: profileImgUrl)
        }
    }
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        //backgroundColor = .yellow
        profileImageView.layer.cornerRadius = 50 / 2
    }
    
}
