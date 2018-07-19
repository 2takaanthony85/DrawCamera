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
    
    private lazy var captureButton: CaptureButton = {
       let button = CaptureButton(frame: self.view.frame)
        button.delegate = self
        return button
    }()
    
//    private lazy var returnButton: ReturnButton = {
//       let button = ReturnButton(frame: self.view.frame)
//        button.delegate = self
//        return button
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspect
        previewLayer.frame = self.view.frame
        previewLayer.connection?.videoOrientation = .portrait
        self.view.layer.addSublayer(previewLayer)
        
        self.view.addSubview(captureButton)
        //self.view.addSubview(returnButton)
        layout()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(endCamera))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        sessionConfigure()
    
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
    
    @objc private func endCamera() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reflesh"), object: nil)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //ステータスバーの表示、非表示
    override var prefersStatusBarHidden: Bool {
        return false
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
    
//    private func setup() {
//        returnButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        returnButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
//        returnButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        returnButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
    
}
