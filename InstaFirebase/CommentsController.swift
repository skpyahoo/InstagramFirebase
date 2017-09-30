//
//  CommentsController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 28/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "CommentsCell"

class CommentsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        return textField
    }()
    
    var post: Posts?
    var comments = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //collectionView?.backgroundColor = .red
        navigationItem.title = "Comments"
        
        fetchComments()
        
    }
    
    
    fileprivate func fetchComments()
    {
        guard let postId = self.post?.id else { return }
        let ref = Database.database().reference().child("comments").child(postId)
        
        ref.observe(.childAdded, with: { (snapshot) in
            
            //print(snapshot.value)
            
            guard let commentDict = snapshot.value  as? [String: Any] else {return}
            
            guard let uid = commentDict["uid"] as? String  else {return}
            
            Database.fetchUserWithUID(uid: uid, completion: { (user) in
                
                let comment = Comment(user: user, dictionary: commentDict)
                self.comments.append(comment)
                self.collectionView?.reloadData()
                
            })
            
            
            
            
        }) { (err) in
            print("Failed to Observe Commnets")
        }
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override var inputAccessoryView: UIView?
    {
        get {

            let containerView = UITextView()
            containerView.backgroundColor = .white
            containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
            
            
            let submitButton = UIButton(type: .system)
            submitButton.setTitle("Submit", for: .normal)
            submitButton.setTitleColor(.black, for: .normal)
            submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            submitButton.frame = CGRect(x: view.frame.maxX-70, y: 0, width: 60, height: 50)
            submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
            containerView.addSubview(submitButton)
            
            submitButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
            submitButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
            submitButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 12).isActive = true

           
            commentTextField.frame = CGRect(x: 10, y: 0, width: view.frame.width-85, height: 50)
            
            containerView.addSubview(commentTextField)

           commentTextField.inputAccessoryView = containerView
           commentTextField.becomeFirstResponder()

            commentTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
            commentTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
            commentTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
            commentTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
            
            
//            let lineSeparator = UIView()
//            lineSeparator.backgroundColor = .red //UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
//            containerView.frame = CGRect(x: 0, y: 0, width: 10, height: 0.5)
//            containerView.addSubview(lineSeparator)
//
//            lineSeparator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
//            lineSeparator.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
//            lineSeparator.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
//            lineSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
            return containerView
        }
    }
    
    
    @objc func handleSubmit() {
      // print("Handling Submit...",commentTextField.text ?? "")
        //print("Post ID:", self.post?.id)
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let postId = self.post?.id ?? ""
        let values = ["text": commentTextField.text ?? "",
                      "creationDate": Date().timeIntervalSince1970,
                      "uid": uid
            ] as [String : Any]
        
        
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (err, ref) in
            
           if let err = err
           {
            print("Failed to insert comment",err)
            return
            }
            
            print("Successfully inserted comment")
        }
    }
    
    
    override var canBecomeFirstResponder: Bool
    {
        return true
    }

    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return comments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
    
        // Configure the cell
        cell.comment = self.comments[indexPath.item]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//        let dummyCell = CommentCell(frame: frame)
//        dummyCell.comment = comments[indexPath.item]
//        dummyCell.layoutIfNeeded()
//
//        let targetSize = CGSize(width: view.frame.width, height: 1000)
//        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
//        let height = max(40 + 8 + 8, estimatedSize.height)
        return CGSize(width: view.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
   

}
