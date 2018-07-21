//
//  PhotoListViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/10.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController {
    
    private lazy var cameraButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(startCamera))
        return button
    }()
    
    private lazy var trashButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: viewController.self, action: #selector(viewController.deleteNotification))
        button.isEnabled = false
        return button
    }()
    
    private lazy var flexibleSpace: UIBarButtonItem = {
       let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        return space
    }()
    
    private lazy var uploadButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: nil, action: nil)
        return button
    }()
    
    private lazy var toolBar: UIToolbar = {
       let bar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.height - 45, width: self.view.frame.width, height: 45))
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.items = [uploadButton, flexibleSpace, cameraButton, flexibleSpace, accountEdit, flexibleSpace, trashButton]
        return bar
    }()
    
    private lazy var toolBarSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        layouts.append(toolBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor))
        layouts.append(toolBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        layouts.append(toolBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        layouts.append(toolBar.heightAnchor.constraint(equalToConstant: 45))
        return layouts
    }()
    
    private lazy var accountEdit: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(showAccountEdit))
        return button
    }()
    
    private var viewController: ContainerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "CollectionView", bundle: nil)
        viewController = storyboard.instantiateInitialViewController() as! ContainerViewController
        displayContainerView(viewController)
        
        let selectButton = UIBarButtonItem(title: "選択", style: .plain, target: viewController.self, action: #selector(viewController.rightBarButtonTapped))
        self.navigationItem.rightBarButtonItem = selectButton
        
        self.view.addSubview(toolBar)
        NSLayoutConstraint.activate(toolBarSetup)
        
        NotificationCenter.default.addObserver(self, selector: #selector(editingMode), name: NSNotification.Name("editing"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endEditingMode), name: NSNotification.Name("endEditing"), object: nil)
    }
    
    @objc
    private func endEditingMode() {
        trashButton.isEnabled = false
        let selectButton = UIBarButtonItem(title: "選択", style: .plain, target: viewController.self, action: #selector(viewController.rightBarButtonTapped))
        self.navigationItem.rightBarButtonItem = selectButton
    }
    
    @objc
    private func startCamera() {
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
    
    @objc
    private func editingMode() {
        let cancelButton = UIBarButtonItem(title: "cancel", style: .done, target: viewController.self, action: #selector(viewController.cancelButtonTapped))
        self.navigationItem.rightBarButtonItem = cancelButton
        trashButton.isEnabled = true
    }
    
    @objc
    private func showAccountEdit() {
        let storyboard = UIStoryboard(name: "AccountEdit", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! AccountEditViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
