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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        collectionView?.backgroundColor = .white
        gearIcon.image = #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal)
        
        fetchUser()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

 

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 7
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = .purple
        
    
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
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull
            {
                print("Failed to fetch user")
            }
            else
            {
                print("Sanpshot value", snapshot.value ?? "")
                
                guard let currentUserProfile = snapshot.value as? [String: Any] else { return }
                
                self.user = User(dictinary: currentUserProfile)
        
                self.navigationItem.title = self.user?.username
                self.collectionView?.reloadData()
            }
        })
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

struct User {
    
    let username: String
    let profileImageUrl: String
    
    init(dictinary: [String: Any]) {
        
        self.username = dictinary["username"] as? String ?? ""
        self.profileImageUrl = dictinary["profileImageUrl"] as? String ?? ""
    }
    
}