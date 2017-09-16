//
//  UserSearchController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 16/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SearchCell"

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        createSearchBar()

        
    }
    
    fileprivate func createSearchBar()
    {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter Username"
        searchBar.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        searchBar.delegate = self as? UISearchBarDelegate
        
        self.navigationItem.titleView = searchBar
        
        let navBar = navigationController?.navigationBar
        
        searchBar.topAnchor.constraint(equalTo: (navBar?.topAnchor)!, constant: 0).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: (navBar?.bottomAnchor)!, constant: 0).isActive = true
        searchBar.leftAnchor.constraint(equalTo: (navBar?.leftAnchor)!, constant: 8).isActive = true
        searchBar.rightAnchor.constraint(equalTo: (navBar?.rightAnchor)!, constant: 8).isActive = true
        
        
    }






    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 66)
    }


}
