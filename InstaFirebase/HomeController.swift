//
//  HomeController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 14/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "HomeCell"

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Posts]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        fetchPosts()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
        
        
        cell.post = posts[indexPath.item]
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        var height: CGFloat = 40 + 8 + 8
        height += view.frame.width
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    fileprivate func fetchPosts()
    {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("posts").child(uid)
        
        ref.observeSingleEvent(of: .value, with: { (sanpshot) in
            
            print(sanpshot.value ?? "")
            
            self.posts =  []
            
            guard let userPostsDict = sanpshot.value as? [String: Any] else { return }
            userPostsDict.forEach({ (key, value) in
                
                //print("Key \(key), Value:\(value)")
                
                guard let postValueDict = value as? [String: Any] else { return }
                
                let post = Posts(dict: postValueDict)
                self.posts.append(post)
                
            })
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch Posts",err)
        }
        
    }

}
