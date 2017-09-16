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
    let user: User
    let caption: String
    
    init(user: User, dict: [String: Any]) {
        self.imageUrl = dict["imageUrl"] as? String ?? ""
        self.user = user
        self.caption = dict["caption"] as? String ?? ""
    }
}
