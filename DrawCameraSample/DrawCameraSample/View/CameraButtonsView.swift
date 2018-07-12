//
//  CameraButtonsView.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/12.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class CameraButtonsView: UIView {
    
    lazy var cameraButton: CameraButton = {
       let button = CameraButton(frame: self.frame)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.gray
        //self.alpha = 0.5
        
        self.addSubview(cameraButton)
        NSLayoutConstraint.activate(cameraButtonSetup)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private lazy var cameraButtonSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        layouts.append(cameraButton.widthAnchor.constraint(equalToConstant: 70))
        layouts.append(cameraButton.heightAnchor.constraint(equalToConstant: 70))
        layouts.append(cameraButton.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        layouts.append(cameraButton.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        return layouts
    }()
}

