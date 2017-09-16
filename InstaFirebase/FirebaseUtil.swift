//
//  FirebaseUtil.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 16/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ())
    {
        print("Fetching user with uid", uid)
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let UserDict = snapshot.value as? [String: Any] else { return }
            
            let user = User(uid: uid, dictinary: UserDict)
            
            completion(user)
            
            
        }) { (err) in
            
            print("Failed to fetch user for posts",err)
        }
    }
}
