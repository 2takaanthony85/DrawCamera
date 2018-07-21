//
//  LoginViewController2.swift
//  DrawCameraSample
//
//  Created by 吉川昂広 on 2018/07/21.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class LoginViewController2: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var companyCodeTextField: UITextField!
    
    @IBOutlet weak var userIdTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var txtActiveField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigation controllerを隠す
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo else {
            fatalError("user info error")
        }
        guard let keyboardHeight = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else {
            fatalError("keyboard height error")
        }
        
        let myBoundsSize = UIScreen.main.bounds.size
        let txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 70
        let kbdLimit = myBoundsSize.height - keyboardHeight
        
        guard txtLimit >= kbdLimit else { return }
        scrollView.contentOffset.y = txtLimit - kbdLimit
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        txtActiveField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentOffset.y = 0
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("company code : \(companyCodeTextField.text!)")
        print("user id : \(userIdTextField.text!)")
        print("password : \(passwordTextField.text!)")
        
        let vc = PhotoListViewController()
        let navi = UINavigationController(rootViewController: vc)
        self.present(navi, animated: true, completion: nil)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let vc = RegisterViewController1()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
