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
    
    @IBOutlet var PhotoheightConstraint: NSLayoutConstraint!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    
    var post: Posts? {
        didSet {
            guard let postImageUrl = post?.imageUrl else { return }
            
            homeCellPhotoImageView.loadImage(urlString: postImageUrl)
            usernameLabel.text = post?.user.username
            guard let profileImgUrl = post?.user.profileImageUrl else { return }
            
            userProfileImageView.loadImage(urlString: profileImgUrl)
            
            setAttributedCaption()
            
            
        }
    }
    
    fileprivate func setAttributedCaption()
    {
        guard let post = self.post  else { return }
        
        let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)])
        
        attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]))
        
        attributedText.append(NSAttributedString(string: " \n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        
        attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        captionLabel.attributedText = attributedText
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        userProfileImageView.layer.cornerRadius = 40 / 2
        
       homeCellPhotoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
    }
    
}
