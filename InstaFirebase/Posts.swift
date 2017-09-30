//
//  Posts.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 14/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

struct Posts {

    var id: String?
    
    let imageUrl: String
    let user: User
    let caption: String
    let creationDate: Date
    
    init(user: User, dict: [String: Any]) {
        self.imageUrl = dict["imageUrl"] as? String ?? ""
        self.user = user
        self.caption = dict["caption"] as? String ?? ""
        
        let secondsFrom1970 = dict["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
        
    }
}
