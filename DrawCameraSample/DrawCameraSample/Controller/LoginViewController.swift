//
//  LoginViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/11.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var loginView: LoginView = {
       let logView = LoginView(frame: self.view.frame)
        logView.password.delegate = self
        logView.companyCode.delegate = self
        logView.userID.delegate = self
        logView.delegate = self
        return logView
    }()
    
    private lazy var loginViewSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        layouts.append(loginView.topAnchor.constraint(equalTo: self.view.topAnchor))
        layouts.append(loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        layouts.append(loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        layouts.append(loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        return layouts
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(loginView)
        NSLayoutConstraint.activate(loginViewSetup)
    }
    
    //return押された時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LoginViewController: LoginDelegate {
    
    func login(_ companyCode: String, _ userID: String, _ password: String) {
        print("companyCode : \(companyCode)")
        print("userID : \(password)")
        print("password : \(password)")
        let vc = PhotoListViewController()
        let navi = UINavigationController(rootViewController: vc)
        self.present(navi, animated: true, completion: nil)
    }
    
    func register() {
        print("register")
    }
    
}
