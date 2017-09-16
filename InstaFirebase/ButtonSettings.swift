//
//  ButtonSettings.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 16/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class ButtonSettings: UIButton {
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    self.imageView?.image = self.imageView?.image?.withRenderingMode(.alwaysOriginal)
    }
    
    
    
}
