//
//  HomeCell.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 14/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    
    @IBOutlet var homeCellPhotoImageView: CustomImageView!
    @IBOutlet var userProfileImageView: CustomImageView!
    var post: Posts? {
        didSet {
            guard let postImageUrl = post?.imageUrl else { return }
            
            homeCellPhotoImageView.loadImage(urlString: postImageUrl)
            
            
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        userProfileImageView.layer.cornerRadius = 40 / 2
        self.backgroundColor = .gray
    }
    
}
