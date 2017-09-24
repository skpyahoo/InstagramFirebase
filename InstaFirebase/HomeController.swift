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
        

        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: SharePhotoController.updateFeedNotificationName, object: nil)
        
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        collectionView?.refreshControl = refreshControl
        
        fetchAllPosts()

    }
    
    @objc func handleUpdateFeed()
    {
        handleRefresh()
    }

    @objc func handleRefresh()
{
    posts.removeAll()
    fetchAllPosts()
    
}
    
    fileprivate func fetchAllPosts()
    {
        fetchPosts()
        fetchFollowingUserIds()
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
        height += 50
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    fileprivate func fetchPosts()
    {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            
            self.fetchPostsWithUser(user: user)
            
        }
        
    }
    
    fileprivate func fetchFollowingUserIds()
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
          
            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            
            userDictionary.forEach({ (key, value) in
                Database.fetchUserWithUID(uid: key, completion: { (user) in
                    
                    self.fetchPostsWithUser(user: user)
                })
            })
            
        }) { (err) in
            print("Faled to Fetch following users posts", err)
        }
        
    }
    
    fileprivate func fetchPostsWithUser(user: User)
    {
        
        let ref =  Database.database().reference().child("posts").child(user.uid)
        ref.observeSingleEvent(of: .value, with: { (sanpshot) in
            
           // print(sanpshot.value ?? "")
            
            self.collectionView?.refreshControl?.endRefreshing()
            
            guard let userPostsDict = sanpshot.value as? [String: Any] else { return }
            userPostsDict.forEach({ (key, value) in
                
                //print("Key \(key), Value:\(value)")
                
                guard let postValueDict = value as? [String: Any] else { return }
                
                let post = Posts(user: user, dict: postValueDict)
                
                //let post = Posts(dict: postValueDict)
                self.posts.append(post)
                
            })
            
            self.posts.sort(by: { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            })
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch Posts",err)
            return
        }
        
    }

}
