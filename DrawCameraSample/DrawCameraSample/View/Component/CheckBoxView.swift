//
//  CheckBoxView.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/18.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class CheckBoxView: UIView {

    var selected = false
    init(frame: CGRect,selected: Bool) {
        super.init(frame:frame)
        self.selected = selected
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let ovalColor:UIColor
        let ovalFrameColor:UIColor
        let checkColor:UIColor
        
        let rectCheck = CGRect(x: 5, y: 5, width: rect.width - 10, height: rect.height - 10)
        
        if self.selected {
            ovalColor = UIColor(red: 85/255, green: 185/255, blue: 1/255, alpha: 1)
            ovalFrameColor = UIColor.black
            checkColor = UIColor.white
        }else{
            ovalColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.2)
            ovalFrameColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.3)
            checkColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        }
        
        // 円 -------------------------------------
        let oval = UIBezierPath(ovalIn: rectCheck)
        
        // 塗りつぶし色の設定
        ovalColor.setFill()
        // 内側の塗りつぶし
        oval.fill()
        //枠の色
        ovalFrameColor.setStroke()
        //枠の太さ
        oval.lineWidth = 2
        // 描画
        oval.stroke()
        
        let xx = rectCheck.origin.x
        let yy = rectCheck.origin.y
        let width = rectCheck.width
        let height = rectCheck.height
        
        // チェックマークの描画 ----------------------
        let checkmark = UIBezierPath()
        //起点
        checkmark.move(to: CGPoint(x: xx + width / 6, y: yy + height / 2))
        //帰着点
        checkmark.addLine(to: CGPoint(x: xx + width / 3, y: yy + height * 7 / 10))
        checkmark.addLine(to: CGPoint(x: xx + width * 5 / 6, y: yy + height * 1 / 3))

        // 色の設定
        checkColor.setStroke()
        // ライン幅
        checkmark.lineWidth = 6
        // 描画
        checkmark.stroke()
    }

}
