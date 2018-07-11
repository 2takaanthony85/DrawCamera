//
//  ViewController.swift
//  DrawCameraSample
//
//  Created by 吉川昂広 on 2018/07/02.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton()
        button.center = self.view.center
        button.frame.size = CGSize(width: 70, height: 50)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let vc = PhotoListViewController()
        let navi = UINavigationController(rootViewController: vc)
        self.present(navi, animated: true, completion: nil)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



