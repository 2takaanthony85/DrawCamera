//
//  CollectionHeader.swift
//  DrawCameraSample
//
//  Created by 吉川昂広 on 2018/07/15.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class CollectionHeader: UICollectionReusableView {

    @IBOutlet weak var label: UILabel!
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    func setup() {
        self.backgroundColor = UIColor.white
        self.alpha = 0.75
    }
}
