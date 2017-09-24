//
//  CameraController.swift
//  InstaFirebase
//
//  Created by Sagar Pahlajani on 24/09/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var captureView: UIView!
    
    @IBOutlet var captureCameraButton: UIButton!
    
    let output = AVCapturePhotoOutput()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCaptureSession()
    }

    
   
    
    @IBAction func captureCameraBtnPressed(_ sender: Any) {
        
        let settings = AVCapturePhotoSettings()

        guard let previewFormatType = settings.__availablePreviewPhotoPixelFormatTypes.first else {return}
    
       settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]

        output.capturePhoto(with: settings, delegate: self)
        
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
    
    
    
    @IBAction func dissmissButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
