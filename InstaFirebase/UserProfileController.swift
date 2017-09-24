//
//  UserProfileController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 09/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase
private let reuseIdentifier = "Cell"

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet var gearIcon: UIBarButtonItem!

    var user: User?
    var posts = [Posts]()
    var userId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        
        
        collectionView?.backgroundColor = .white
        gearIcon.image = #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().tintColor = UIColor.black
        
        fetchUser()
        
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserProfilePhotoCell
    
        // Configure the cell
        
        cell.post = posts[indexPath.item]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }


    
    fileprivate func fetchUser()
    {
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            
            self.user = user
            if self.user?.uid == Auth.auth().currentUser?.uid
            {
                self.navigationItem.title = self.user?.username
            }
            
            
            self.collectionView?.reloadData()
            
            self.fetchOrderedPost()
        }
        
        
    }
    
    fileprivate func fetchOrderedPost()
    {
        guard let uid = self.user?.uid else { return }
        
        let ref = Database.database().reference().child("posts").child(uid)
        
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            
            //print(snapshot.key, snapshot.value ?? "")
            
            guard let dict = snapshot.value  as? [String: Any] else { return }
            
            guard let user = self.user else { return }
            let post = Posts(user: user, dict: dict)
           
            self.posts.insert(post, at: 0)
            //self.posts.append(post)
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            
            print("Failed to fetch Ordered Posts",err)
            
        }
        
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        //header.backgroundColor = .green
    
        header.user = self.user
        
        return header
    }
    
   
    
    @IBAction func gearIconBtnPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            print("perform Logging Out")
            
            do {
                try Auth.auth().signOut()
                
               self.performSegue(withIdentifier: "backToLoginVc", sender: nil)
                
                
            }
                catch let signOutErr {
                    
                print("Failed to signOut", signOutErr)
                    
                }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
}

