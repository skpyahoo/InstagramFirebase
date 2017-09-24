//
//  CustomImageView.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 14/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView
{
    var lastUrlUsedtoLoadImage: String?
    
    override func layoutSubviews() {
        
        if tag == 1
        {
        layer.cornerRadius = self.frame.width / 2
        contentMode = .scaleAspectFill
        clipsToBounds = true
        
        }
    }
    
    
    func loadImage(urlString: String)
    {
        lastUrlUsedtoLoadImage = urlString
        
        self.image = nil
        
        if let cachedImage = imageCache[urlString]
        {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err
            {
                print("Failed to fecth Post Image", err)
                return
            }
            
            if url.absoluteString != self.lastUrlUsedtoLoadImage
            {
                return
            }
            guard let imageData = data else {return}
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
                
            }
            
            }.resume()
        
        
    }
}
