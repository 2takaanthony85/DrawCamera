//
//  CommentLabel.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/03.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class CommentLabel: UILabel {

    private var locationInitialTouch: CGPoint!
    
    init(text: String) {
        super.init(frame: CGRect(x: 50, y: 100, width: 60, height: 40))
        self.text = text
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.white
        self.textAlignment = .center
        //self.sizeToFit()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            print(location.x)
            print(location.y)
            
            locationInitialTouch = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            print(location.x)
            print(location.y)
            
            frame = frame.offsetBy(dx: location.x - locationInitialTouch.x, dy: location.y - locationInitialTouch.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            print(location.x)
            print(location.y)
            
            frame = frame.offsetBy(dx: location.x - locationInitialTouch.x, dy: location.y - locationInitialTouch.y)
        }
    }
    
}
