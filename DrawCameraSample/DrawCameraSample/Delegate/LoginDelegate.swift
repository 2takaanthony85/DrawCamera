//
//  LoginDelegate.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/11.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

protocol LoginDelegate: class {
    
    //ログイン
    func login(_ companyCode: String, _ userID: String, _ password: String)
    
    //新規登録画面に遷移
    func registerViewTransition()

}

protocol Register1Delegate: class {
    
    //確認
    func confirm()
    
}


