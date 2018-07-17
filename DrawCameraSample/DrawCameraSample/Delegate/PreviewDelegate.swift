//
//  PreviewDelegate.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/03.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

protocol PreviewDelegate: class {
    
    //写真の保存
    func savePhoto(_ labels:[String: UILabel], _ layers: [CAShapeLayer])
    
    //viewControllerを閉じる
    func closeViewController()
    
    //コメント追加
    func addComment()
}
