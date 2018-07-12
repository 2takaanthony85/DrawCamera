//
//  CameraViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/10.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    var captureSession = AVCaptureSession()
    var output: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var captureButton: CaptureButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspect
        previewLayer.frame = self.view.frame
        previewLayer.connection?.videoOrientation = .portrait
        self.view.layer.addSublayer(previewLayer)
        
        captureButton = CaptureButton()
        captureButton.delegate = self
        self.view.addSubview(captureButton)
        layout()
        
        sessionConfigure()
        
        
    }
    
    @objc private func endCamera() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func sessionConfigure() {
        output = AVCapturePhotoOutput()
        
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        if let device = AVCaptureDevice.default(for: .video) {
            
            do {
                let input = try AVCaptureDeviceInput(device: device)
                
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                    
                    if captureSession.canAddOutput(output) {
                        output.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
                        captureSession.addOutput(output)
                        
                        captureSession.startRunning()
                    }
                }
            } catch {
                print("session settings error")
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate, CaptureButtonDelegate {
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        if output.supportedFlashModes.contains(AVCaptureDevice.FlashMode.on) {
            settings.flashMode = .auto
        }
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            
            let vc = PreviewController()
            vc.photoData = imageData
            self.present(vc, animated: false, completion: nil)
        }
    }
}

/*
 レイアウト
 */

extension CameraViewController {
    
    private func layout() {
        captureButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        captureButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        captureButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        captureButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
}
