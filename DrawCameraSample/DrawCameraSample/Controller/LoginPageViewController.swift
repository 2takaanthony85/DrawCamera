//
//  LoginPageViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/11.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class LoginPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.view.frame.width)
        
        self.view.backgroundColor = UIColor.white
        self.setViewControllers([getLogin()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }

    private func getLogin() -> UIViewController {
        return LoginViewController()
    }
    
    private func getRegister1() -> UIViewController {
        return RegisterViewController1()
    }
    
    private func getRegister2() -> UIViewController {
        return RegisterViewController2()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: LoginViewController.self)
        {
            return nil
        } else if viewController.isKind(of: RegisterViewController1.self) {
            return getLogin()
            
        } else {
            return getRegister1()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: LoginViewController.self)
        {
            return getRegister1()
        } else if viewController.isKind(of: RegisterViewController1.self) {
            return getRegister2()
        } else {
            return nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
