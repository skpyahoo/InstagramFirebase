//
//  BorderButton.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 10/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class BorderButton: UIButton
{
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 3
    }

}
