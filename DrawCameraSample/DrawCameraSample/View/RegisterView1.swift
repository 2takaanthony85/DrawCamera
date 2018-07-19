//
//  RegisterView1.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/11.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class RegisterView1: UIView {
    
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
    
    private let companyPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "パスワード"
        label.sizeToFit()
        return label
    }()
    
    let companyPassword: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.placeholder = "パスワード"
        field.keyboardType = .URL
        field.isSecureTextEntry = true
        field.tag = 1
        return field
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("照会", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(confirmButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: Register1Delegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        
        self.addSubview(companyCodeLabel)
        self.addSubview(companyCode)
        self.addSubview(companyPasswordLabel)
        self.addSubview(companyPassword)
        self.addSubview(confirmButton)
        
        var layouts = companyCodeLabelSetup
        layouts += companyCodeSetup
        layouts += companyPasswordLabelSetup
        layouts += companyPasswordSetup
        layouts += confirmButtonSetup
        NSLayoutConstraint.activate(layouts)
    }
    
    /*
     ボタンアクション
     */
    @objc
    private func confirmButtonTapped(_ sender: UIButton) {
        self.delegate?.confirm()
    }
    
    /*
     レイアウト
     */
    
    private lazy var companyCodeLabelSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.companyCodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.companyCodeLabel.widthAnchor.constraint(equalToConstant: 100))
        layouts.append(self.companyCodeLabel.heightAnchor.constraint(equalToConstant: 50))
        layouts.append(self.companyCodeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80))
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
    
    private lazy var companyPasswordLabelSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.companyPasswordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.companyPasswordLabel.widthAnchor.constraint(equalToConstant: 100))
        layouts.append(self.companyPasswordLabel.heightAnchor.constraint(equalToConstant: 50))
        layouts.append(self.companyPasswordLabel.topAnchor.constraint(equalTo: self.companyCode.bottomAnchor, constant: 5))
        return layouts
    }()
    
    private lazy var companyPasswordSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.companyPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        layouts.append(self.companyPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20))
        layouts.append(self.companyPassword.heightAnchor.constraint(equalToConstant: 45))
        layouts.append(self.companyPassword.topAnchor.constraint(equalTo: companyPasswordLabel.bottomAnchor, constant: -10))
        return layouts
    }()
    
    private lazy var confirmButtonSetup: [NSLayoutConstraint] = {
        var layouts: [NSLayoutConstraint] = []
        
        layouts.append(self.confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        layouts.append(self.confirmButton.widthAnchor.constraint(equalToConstant: 200))
        layouts.append(self.confirmButton.heightAnchor.constraint(equalToConstant: 45))
        layouts.append(self.confirmButton.topAnchor.constraint(equalTo: companyPassword.bottomAnchor, constant: 20))
        return layouts
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
