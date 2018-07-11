//
//  CameraButton.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/10.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class CameraButton: UIButton {
    
    weak var delegate: CameraButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.blue
        self.layer.cornerRadius = 30
        self.addTarget(self, action: #selector(cameraButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func cameraButtonTapped(_ sender: UIButton) {
        self.delegate?.showCamera()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
