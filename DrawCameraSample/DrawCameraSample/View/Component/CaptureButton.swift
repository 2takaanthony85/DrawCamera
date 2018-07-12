//
//  CaptureButton.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/10.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class CaptureButton: UIView {
    
    weak var delegate: CaptureButtonDelegate?
    
    private lazy var captureButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 65/2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(captureButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 40
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(captureButton)
        layout(captureButton)
    }
    
    @objc private func captureButtonTapped(_ sender: UIButton) {
        print("tapped")
        self.delegate?.takePhoto()
    }
    
    private func layout(_ button: UIButton) {
        button.widthAnchor.constraint(equalToConstant: 65).isActive = true
        button.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
