//
//  PhotoDetailViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/18.
//  Copyright © 2018年 atd. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var data: PhotoData!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(data: data.photo)
        self.view.addSubview(imageView)
        
        data.process.layers.forEach({ (layer) -> Void in
            imageView.layer.addSublayer(layer)
        })
        data.process.labels.forEach({ (label) -> Void in
            imageView.addSubview(label.value)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
