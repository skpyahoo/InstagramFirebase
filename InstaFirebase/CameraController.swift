//
//  CameraController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 24/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet var previewImageView: UIImageView!
    
    @IBOutlet var captureView: UIView!
    
    
    @IBOutlet var captureCameraButton: UIButton!
    @IBOutlet var containerView: PreviewPhotoControllerView!
    
    let output = AVCapturePhotoOutput()
    let customAnimationPresentor = CustomAnimationPresentor()
    let customAnimationDismisser = CustomAnimationDismisser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        
      containerView.isHidden = true

        setupCaptureSession()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return customAnimationPresentor
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return customAnimationDismisser
    }
    

    
    
    @IBAction func captureCameraBtnPressed(_ sender: Any) {
        
        let settings = AVCapturePhotoSettings()

        guard let previewFormatType = settings.__availablePreviewPhotoPixelFormatTypes.first else {return}
    
       settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]

        output.capturePhoto(with: settings, delegate: self)
         containerView.isHidden = false
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {

        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer!)

        let previewImage = UIImage(data: imageData!)
        previewImageView.image = previewImage
    }
    
    

    fileprivate func setupCaptureSession()
    {
        let captureSession = AVCaptureSession()
        
        
        //1. Setup Inputs
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        do {
            let input =  try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input)
            {
                captureSession.addInput(input)
            }
            
        } catch let err {
            print("Could not setup Camera Imputs",err)
        }
        
        //2. Setup Output
        
        
        if captureSession.canAddOutput(output)
        {
            captureSession.addOutput(output)
        }
        
        //3. Setup Output Preview
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        previewLayer.frame = captureView.frame
        captureView.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let previewImage = previewImageView.image else {return}
        
        let library = PHPhotoLibrary.shared()
        
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
        }) { (success, err) in
            
            if let err = err
            {
                print("Failed to save image into libray",err)
                return
            }
            
            print("Successfully saved image to library")
            
            DispatchQueue.main.async {
                let savedLabel = UILabel()
                savedLabel.text = "Saved Successfully"
                savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
                savedLabel.textColor = .white
                savedLabel.textAlignment = .center
                savedLabel.numberOfLines = 0
                savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
                savedLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
                savedLabel.center = self.view.center
                
                self.view.addSubview(savedLabel)
                
                savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0 )
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    
                    savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: { (completed) in
                    
                    UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        
                        savedLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                        savedLabel.alpha = 0
                        
                    }, completion: { (_) in
                        
                        savedLabel.removeFromSuperview()
                        
                    })
                    
                })
               
                
                
                
            }
            
            
            
        }
        
    }
    
    
    
    @IBAction func dissmissButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
