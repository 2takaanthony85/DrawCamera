//
//  RegisterViewController2.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/11.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class RegisterViewController2: UIViewController, UITextFieldDelegate {
    
    private lazy var register2: RegisterView2 = {
        let view2 = RegisterView2(frame: self.view.frame)
        //view2.delegate = self
        view2.password.delegate = self
        view2.userID.delegate = self
        return view2
    }()
    
    private lazy var register2Setup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        layouts.append(register2.topAnchor.constraint(equalTo: self.view.topAnchor))
        layouts.append(register2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        layouts.append(register2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        layouts.append(register2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        return layouts
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(register2)
        NSLayoutConstraint.activate(register2Setup)
    }
    
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
