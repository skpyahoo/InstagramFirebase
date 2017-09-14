//
//  UserProfilePhotoCell.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 14/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    @IBOutlet var postImageView: CustomImageView!
    
    var post: Posts? {
        didSet {
            
            guard let imageUrl = post?.imageUrl else { return }
            
            postImageView.loadImage(urlString: imageUrl)
            
            
            
        }
        
        
        
    }
}
