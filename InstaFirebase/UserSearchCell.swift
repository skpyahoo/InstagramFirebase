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
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        //backgroundColor = .yellow
        profileImageView.layer.cornerRadius = 50 / 2
    }
    
}
