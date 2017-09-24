//
//  UserProfileHeader.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 10/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionReusableView {
    @IBOutlet var gridButton: UIButton!
    @IBOutlet var listButton: UIButton!
    @IBOutlet var ribbonButton: UIButton!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var profileImageView: CustomImageView!
    @IBOutlet var editProfileButton: BorderButton!
    
    
    
    var user: User? {
        didSet {
            guard let profileImgUrl = user?.profileImageUrl else { return }
            
            profileImageView.loadImage(urlString: profileImgUrl)
            
            userNameLabel.text = self.user?.username
            
            setupEditFollowButton()
        }
    }
        
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
       // self.isUserInteractionEnabled = true
        
        
    }
    
    
    
    
    @IBAction func gridBtnPressed(_ sender: Any) {
    }

    @IBAction func ribbonBtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func listButtonPressed(_ sender: Any) {
    }
    
    fileprivate func setupEditFollowButton()
    {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.uid else { return }
        
        if currentLoggedInUserId == userId
        {
            
        }
        else
        {
            // check if following
            
            Database.database().reference().child("following").child(currentLoggedInUserId).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let isFollowing = snapshot.value as? Int, isFollowing == 1
                {
                    self.editProfileButton.setTitle("Unfollow", for: .normal)
                }
                else
                {
                   self.setupFollowStyles()
                }
                
            }, withCancel: { (err) in
                print("Falied to check if following",err)
            })
            
            
        }
        
    }
    
    func followOrEditBtnPressed()
    {
        print("Following Btn Pressed")
    }
    
    @IBAction func handleEditProfileOrFollow(_ sender: Any) {
        
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }

        guard let userId = user?.uid else {return}

        if editProfileButton.titleLabel?.text == "Unfollow"
        {
            Database.database().reference().child("following").child(currentLoggedInUserId).child(userId).removeValue(completionBlock: { (err, ref) in

                if let err = err
                {
                    print("Failed to Unfollow user", err)
                }
                
                self.setupFollowStyles()
                
            })

        }
        else
        {
            //follow

            let ref = Database.database().reference().child("following").child(currentLoggedInUserId)

            let values = [userId: 1]

            ref.updateChildValues(values) { (err, ref) in

                if let err = err
                {
                    print("Failed to follow User", err)
                    return
                }

               // print("Successfully Followed the user", self.user?.username ?? "")
                
                self.editProfileButton.setTitle("Unfollow", for: .normal)
                self.editProfileButton.backgroundColor = .white
                self.editProfileButton.setTitleColor(.black, for: .normal)
            }

        }
        
        //print("Follow Btn Pressed")
        
        
    }
    
    fileprivate func setupFollowStyles()
    {
        self.editProfileButton.setTitle("Follow", for: .normal)
        self.editProfileButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1.0)
        self.editProfileButton.setTitleColor(.white, for: .normal)
        self.editProfileButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    }
    
    
}
