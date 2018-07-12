//
//  PhotoListViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/10.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController, CameraButtonDelegate {
    
    private lazy var cameraButton: CameraButton = {
        let button = CameraButton(frame: self.view.frame)
        button.delegate = self
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(leftBarButtonTapped(_:)))
        leftBarButton.title = "選択"
        let rightBarButton = UIBarButtonItem(title: "設定", style: .plain, target: self, action: #selector(rightBarButtonTapeed(_:)))
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let conVC = ContainerViewController()
        displayContainerView(conVC)
        
        self.view.addSubview(cameraButton)
        layout(cameraButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func showCamera() {
        let cameraVC = CameraViewController()
        self.present(cameraVC, animated: true, completion: nil)
    }
    
    private func displayContainerView(_ vc: UIViewController) {
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    @objc private func leftBarButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc private func rightBarButtonTapeed(_ sender: UIButton) {
        
    }
    
    private func layout(_ button: UIButton) {
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
