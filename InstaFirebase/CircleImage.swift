//
//  CircleImage.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 10/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class CircleImage: UIImageView
{
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
    
}
