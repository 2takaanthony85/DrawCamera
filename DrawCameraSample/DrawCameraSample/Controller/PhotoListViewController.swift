//
//  PhotoListViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/10.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController, CameraButtonDelegate {
    
    private lazy var buttonsView: CameraButtonsView = {
       let buttonsView = CameraButtonsView(frame: self.view.frame)
        buttonsView.cameraButton.delegate = self
        return buttonsView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButton = UIBarButtonItem(title: "選択", style: .plain, target: self, action: #selector(rightBarButtonTapeed(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        //let conVC = ContainerViewController()
        let storyboard = UIStoryboard(name: "CollectionView", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ContainerViewController
        displayContainerView(vc)
        
        self.view.addSubview(buttonsView)
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func showCamera() {
        let cameraVC = CameraViewController()
        let navi = UINavigationController(rootViewController: cameraVC)
        self.present(navi, animated: true, completion: nil)
    }
    
    private func displayContainerView(_ vc: UIViewController) {
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    @objc private func rightBarButtonTapeed(_ sender: UIButton) {
        self.setEditing(true, animated: true)
    }
    
    private func setup() {
        buttonsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        buttonsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        buttonsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
