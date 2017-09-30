//
//  CommentCell.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 30/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    @IBOutlet var commentTextLabel: UITextView!
    @IBOutlet var profileImageView: CustomImageView!
    
    var comment: Comment? {
        
        didSet {
            
            guard let comment = comment  else {return}
          
            
            let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)])
            
            attributedText.append(NSAttributedString(string: " " + comment.text, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]))
            
            commentTextLabel.attributedText = attributedText
            
            profileImageView.loadImage(urlString: comment.user.profileImageUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 40 / 2
    }
}
