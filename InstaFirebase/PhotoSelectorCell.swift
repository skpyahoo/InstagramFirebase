//
//  PhotoSelectorCell.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 11/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    
    
    @IBOutlet var photoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
    }
    
}
