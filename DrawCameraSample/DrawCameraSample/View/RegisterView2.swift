//
//  RegisterView2.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/11.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class RegisterView2: UIView {

    /*
     initialization closure
     */
    
    private let userIDLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ユーザーID"
        label.sizeToFit()
        return label
    }()
    
    let userID: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.placeholder = "ユーザーID"
        field.keyboardType = .URL
        return field
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "パスワード"
        label.sizeToFit()
        return label
    }()
    
    let password: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.placeholder = "パスワード"
        field.keyboardType = .URL
        field.isSecureTextEntry = true
        field.tag = 1
        return field
    }()
    
    private let newRegisterButton: UIButton = {
        print("baka")
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("登録", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(newRegisterButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        
        self.addSubview(userIDLabel)
        self.addSubview(userID)
        self.addSubview(passwordLabel)
        self.addSubview(password)
        self.addSubview(newRegisterButton)
        
        let layouts = userIDLableSetup + userIDSetup + passwordLabelSetup + passwordSetup + newRegisterButtonSetup
        NSLayoutConstraint.activate(layouts)
    }
    
    /*
     ボタンアクション
     */
    @objc
    private func newRegisterButtonTapped(_ sender: UIButton) {
    
    }
    
    /*
     レイアウト
     */
    
    private lazy var userIDLableSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.userIDLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.userIDLabel.widthAnchor.constraint(equalToConstant: 100))
        layouts.append(self.userIDLabel.heightAnchor.constraint(equalToConstant: 50))
        layouts.append(self.userIDLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50))
        return layouts
    }()
    
    private lazy var userIDSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.userID.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.userID.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20))
        layouts.append(self.userID.heightAnchor.constraint(equalToConstant: 45))
        layouts.append(self.userID.topAnchor.constraint(equalTo: userIDLabel.bottomAnchor, constant: -10))
        return layouts
    }()
    
    private lazy var passwordLabelSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.passwordLabel.widthAnchor.constraint(equalToConstant: 100))
        layouts.append(self.passwordLabel.heightAnchor.constraint(equalToConstant: 50))
        layouts.append(self.passwordLabel.topAnchor.constraint(equalTo: userID.bottomAnchor, constant: 5))
        return layouts
    }()
    
    private lazy var passwordSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.password.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.password.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20))
        layouts.append(self.password.heightAnchor.constraint(equalToConstant: 45))
        layouts.append(self.password.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: -10))
        return layouts
    }()
    
    
    private lazy var newRegisterButtonSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.newRegisterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        layouts.append(self.newRegisterButton.widthAnchor.constraint(equalToConstant: 200))
        layouts.append(self.newRegisterButton.heightAnchor.constraint(equalToConstant: 45))
        layouts.append(self.newRegisterButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20))
        return layouts
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
