//
//  PhotoSelectorController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 11/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "photoCell"
private let headerId = "photoHeaderId"

class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var images = [UIImage]()
    var assets = [PHAsset]()
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        UINavigationBar.appearance().tintColor = .black
        UIApplication.shared.isStatusBarHidden = true
        
        //collectionView?.backgroundColor = .yellow
        
        fetchPhotos()

        // Do any additional setup after loading the view.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func assestFetchOptions() -> PHFetchOptions
    {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 20
        
        let sortDescriptors = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptors]
        
        return fetchOptions
        
    }
    
    fileprivate func fetchPhotos()
    {
        DispatchQueue.global(qos: .background).async {
            
            let allPhotos = PHAsset.fetchAssets(with: .image, options: self.assestFetchOptions())
            
            allPhotos.enumerateObjects({ (asset, count, stop) in
                
                print(count)
                
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let image = image
                    {
                        self.images.append(image)
                        self.assets.append(asset)
                        
                        if self.selectedImage == nil
                        {
                            self.selectedImage = image
                        }
                    }
                    
                    if count == allPhotos.count - 1
                    {
                        DispatchQueue.main.async {
                            
                            self.collectionView?.reloadData()
                            
                        }
                        
                    }
                    
                })
                
            })
            
        }
        
        
    }

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoSelectorCell
    
        // Configure the cell
        cell.photoImageView.image = images[indexPath.item]
            
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedImage = images[indexPath.item]
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeader
        
        header.photoHeaderImageView.image = selectedImage
        
        
        if let selectedImage = selectedImage
        {
           if let index = self.images.index(of: selectedImage)
           {
            let selectedAsset = self.assets[index]
            
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 600, height: 600)

            imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil, resultHandler: { (image, info) in
                
                header.photoHeaderImageView.image = image
            })
            
            }
        }
        
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = view.frame.width
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    
    
    

    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    
    
}
