//
//  AccountEditViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/19.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class AccountEditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextFileld: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    @IBOutlet weak var changeButton: UIButton!
    
    @IBOutlet weak var signoutButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var txtActiveField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
