//
//  Posts.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 14/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

struct Posts {

    let imageUrl: String
    
    init(dict: [String: Any]) {
        self.imageUrl = dict["imageUrl"] as? String ?? ""
    }
}
