//
//  UserCell.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 10/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class PhotoSelectorHeader: UICollectionViewCell {
    
    @IBOutlet var photoHeaderImageView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        photoHeaderImageView.contentMode = .scaleAspectFill
        photoHeaderImageView.clipsToBounds = true
        photoHeaderImageView.backgroundColor = .cyan
    }

    
}
