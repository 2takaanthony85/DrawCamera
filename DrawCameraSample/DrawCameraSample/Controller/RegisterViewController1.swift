//
//  RegisterViewController1.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/11.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class RegisterViewController1: UIViewController, UITextFieldDelegate {
    
    private lazy var register1: RegisterView1 = {
        let view1 = RegisterView1(frame: self.view.frame)
        view1.companyCode.delegate = self
        view1.companyPassword.delegate = self
        //view1.delegate = self
        return view1
    }()
    
    private lazy var register1Setup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        layouts.append(register1.topAnchor.constraint(equalTo: self.view.topAnchor))
        layouts.append(register1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        layouts.append(register1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        layouts.append(register1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        return layouts
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(register1)
        NSLayoutConstraint.activate(register1Setup)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
