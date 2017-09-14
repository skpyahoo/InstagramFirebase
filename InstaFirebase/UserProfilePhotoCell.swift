//
//  UserProfilePhotoCell.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 14/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    @IBOutlet var postImageView: UIImageView!
    
    var post: Posts? {
        didSet {
            
            guard let imageUrl = post?.imageUrl else { return }
            
            guard let url = URL(string: imageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                if let err = err
                {
                    print("Failed to fecth Post Image", err)
                    return
                }
                guard let imageData = data else {return}
                
                let photoImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                 self.postImageView.image = photoImage
                    
                }
                
            }.resume()
            
        }
        
        
        
    }
}
