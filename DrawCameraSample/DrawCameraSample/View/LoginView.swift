//
//  LoginView.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/11.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    /*
     initialization closure
     */
    
    private let companyCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "企業コード"
        label.sizeToFit()
        return label
    }()

    let companyCode: UITextField = {
       let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.placeholder = "企業コード"
        field.keyboardType = .URL
        return field
    }()
    
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
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ログイン", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("新規登録はこちらから", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: LoginDelegate?
    
    /*
     init
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(companyCodeLabel)
        self.addSubview(companyCode)
        self.addSubview(userIDLabel)
        self.addSubview(userID)
        self.addSubview(passwordLabel)
        self.addSubview(password)
        self.addSubview(loginButton)
        self.addSubview(registerButton)
        
        let layouts = companyCodeLabelSetup + companyCodeSetup + userIDLableSetup + userIDSetup + passwordLabelSetup + passwordSetup + loginButtonSetup + registerButtonSetup
        NSLayoutConstraint.activate(layouts)
    }
    
    /*
     ボタンアクション
     */
    @objc
    private func loginButtonTapped(_ sender: UIButton) {
        print("login button tapped")
        self.delegate?.login(self.companyCode.text!, self.userID.text!, self.password.text!)
    }
    
    @objc
    private func registerButtonTapped(_ sender: UIButton) {
        print("register button tapped")
        self.delegate?.register()
    }
    
    
    /*
     レイアウト
     */
    
    private lazy var companyCodeLabelSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.companyCodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.companyCodeLabel.widthAnchor.constraint(equalToConstant: 100))
        layouts.append(self.companyCodeLabel.heightAnchor.constraint(equalToConstant: 50))
        layouts.append(self.companyCodeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50))
        return layouts
    }()
    
    private lazy var companyCodeSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.companyCode.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.companyCode.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20))
        layouts.append(self.companyCode.heightAnchor.constraint(equalToConstant: 45))
        layouts.append(self.companyCode.topAnchor.constraint(equalTo: companyCodeLabel.bottomAnchor, constant: -10))
        return layouts
    }()
    
    private lazy var userIDLableSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.userIDLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.userIDLabel.widthAnchor.constraint(equalToConstant: 100))
        layouts.append(self.userIDLabel.heightAnchor.constraint(equalToConstant: 50))
        layouts.append(self.userIDLabel.topAnchor.constraint(equalTo: companyCode.bottomAnchor, constant: 5))
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
    
    private lazy var loginButtonSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        layouts.append(self.loginButton.widthAnchor.constraint(equalToConstant: 200))
        layouts.append(self.loginButton.heightAnchor.constraint(equalToConstant: 45))
        layouts.append(self.loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20))
        return layouts
    }()
    
    private lazy var registerButtonSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        layouts.append(self.registerButton.widthAnchor.constraint(equalToConstant: 200))
        layouts.append(self.registerButton.heightAnchor.constraint(equalToConstant: 45))
        layouts.append(self.registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10))
        return layouts
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
