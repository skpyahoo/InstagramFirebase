//
//  UserSearchController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 16/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchCell"

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var users = [User]()
    var filteredUser = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        createSearchBar()
        fetchAllUsers()
    

        
    }
    
    fileprivate func createSearchBar()
    {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter Username"
        searchBar.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        let navBar = navigationController?.navigationBar
        
        searchBar.topAnchor.constraint(equalTo: (navBar?.topAnchor)!, constant: 0).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: (navBar?.bottomAnchor)!, constant: 0).isActive = true
        searchBar.leftAnchor.constraint(equalTo: (navBar?.leftAnchor)!, constant: 8).isActive = true
        searchBar.rightAnchor.constraint(equalTo: (navBar?.rightAnchor)!, constant: 8).isActive = true
        
        
    }
    
    fileprivate func fetchAllUsers()
    {
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            
            guard let Dict = snapshot.value as? [String: Any] else { return }
            
            Dict.forEach({ (key, value) in
                
                if key == Auth.auth().currentUser?.uid
                {
                    return //avoid myself from all users list
                }
                
                guard let usersDict = value as? [String: Any] else { return }
                
                let user = User(uid: key, dictinary: usersDict)
                self.users.append(user)
                
            })
            
            //sort
            
            self.users.sort(by: { (u1, u2) -> Bool in
                
                return u1.username.compare(u2.username) == .orderedAscending
            })
            
            self.filteredUser = self.users
            self.collectionView?.reloadData()
            
        }) { (err) in
            
            print("Failed to get all teh users",err)
        }
    }






    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return filteredUser.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserSearchCell
    
        // Configure the cell
        cell.user = filteredUser[indexPath.item]
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 66)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let user = filteredUser[indexPath.item]
        performSegue(withIdentifier: "gotoUserProfile", sender: nil)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty
        {
            filteredUser = users
        }
        else
        {
            filteredUser = self.users.filter { (user) -> Bool in
                
                return user.username.lowercased().contains(searchText.lowercased())
            }
            
        }
        
        self.collectionView?.reloadData()
    }


}
