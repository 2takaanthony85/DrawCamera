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

extension UICollectionView {
    
    public func cameraRollGrid(numberOfGridPerRow: Int, gridLineSpace space: CGFloat) {
        let inset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        cameraRollGrid(numberOfGridPerRow: numberOfGridPerRow, gridLineSpace: space, sectionInset: inset)
    }
    
    private func cameraRollGrid(numberOfGridPerRow: Int, gridLineSpace space: CGFloat, sectionInset inset: UIEdgeInsets) {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        guard numberOfGridPerRow > 0 else {
            return
        }
        var length = self.frame.width
        length -= space * CGFloat(numberOfGridPerRow - 1)
        length -= (inset.left + inset.right)
        let side = length / CGFloat(numberOfGridPerRow)
        guard side > 0 else {
            return
        }
        layout.itemSize = CGSize(width: side, height: side)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = inset
        layout.invalidateLayout()
    }
}

extension UIImage {
    
    func makeThumbnail() -> UIImage {
        let thumbnailSize = CGSize(width: 100, height: 100)
        
        defer { UIGraphicsEndImageContext() }
        
        //コンテキスト開始
        UIGraphicsBeginImageContextWithOptions(thumbnailSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: thumbnailSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
        
    }
    
}
