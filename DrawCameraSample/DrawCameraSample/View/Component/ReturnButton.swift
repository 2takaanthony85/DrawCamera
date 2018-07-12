//
//  ReturnButton.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/12.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class ReturnButton: UIButton {
    
    weak var delegate: ReturnButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.setTitle("＜", for: .normal)
        self.setTitleColor(UIColor.cyan, for: .normal)
        self.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func returnButtonTapped(_ sender: UIButton) {
        self.delegate?.closeScreen()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
