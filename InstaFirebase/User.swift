//
//  User.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 16/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import Foundation

struct User {
    
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid:String, dictinary: [String: Any]) {
        
        self.username = dictinary["username"] as? String ?? ""
        self.profileImageUrl = dictinary["profileImageUrl"] as? String ?? ""
        self.uid = uid
    }
    
}

