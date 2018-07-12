//
//  Extension.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/12.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    open override var shouldAutorotate: Bool {
        return true
    }
    
}
