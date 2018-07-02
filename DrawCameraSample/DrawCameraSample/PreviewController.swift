//
//  PreviewController.swift
//  DrawCameraSample
//
//  Created by 吉川昂広 on 2018/07/02.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class PreviewController: UIViewController {

    var photoData: Data!
    //戻る、保存
    private var returnButton: UIButton!
    //全消去
    private var deleteButton: UIButton!
    //色変更
    private var colorButton: UIButton!
    //１段階前に戻る
    private var preDeleteButton: UIButton!
    //
    private var currentColor: UIColor = UIColor.red
    
    var getColor: UIColor {
        get {
            return currentColor
        }
    }
    
    private var redButton: UIButton!
    private var red: UIColor {
        return UIColor.red
    }
    
    private var blueButton: UIButton!
    private var blue: UIColor {
        return UIColor.blue
    }
    
    private var greenButton: UIButton!
    private var green: UIColor {
        return UIColor.green
    }
    
    private var yellowButton: UIButton!
    private var yellow: UIColor {
        return UIColor.yellow
    }
    
    private var whiteButton: UIButton!
    private var white: UIColor {
        return UIColor.white
    }
    
    private var blackButton: UIButton!
    private var black: UIColor {
        return UIColor.black
    }
    
    private var layers: [CAShapeLayer] = []
    
    private var drawLayer: CAShapeLayer!
    
    private var beforePoint: CGPoint!
    
    private var linePath: CGMutablePath!
    
    enum BehaviorMode {
        case Animated
        case Stop
    }
    
    private var behaviorMode = BehaviorMode.Stop
    
    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(image: UIImage(data: photoData))
        imageView.frame = self.view.frame
        self.view.addSubview(imageView)
        
        returnButton = UIButton()
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(returnButton)
        returnButtonSetting(self.returnButton)
        returnButton.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(deleteButton)
        deleteButtonSetting(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        preDeleteButton = UIButton()
        preDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(preDeleteButton)
        preDeleteButtonSetting(self.preDeleteButton)
        preDeleteButton.addTarget(self, action: #selector(preDeleteButtonTapped(_:)), for: .touchUpInside)
        
        redButton = UIButton()
        redButton.translatesAutoresizingMaskIntoConstraints = false
        redButton.backgroundColor = red
        self.view.addSubview(redButton)
        colorButtonSetting(button: redButton)
        redButton.addTarget(self, action: #selector(redButtonTapped(_:)), for: .touchUpInside)
        
        blueButton = UIButton()
        blueButton.translatesAutoresizingMaskIntoConstraints = false
        blueButton.backgroundColor = blue
        self.view.addSubview(blueButton)
        colorButtonSetting(button: blueButton)
        blueButton.addTarget(self, action: #selector(blueButtonTapped(_:)), for: .touchUpInside)
        
        greenButton = UIButton()
        greenButton.translatesAutoresizingMaskIntoConstraints = false
        greenButton.backgroundColor = green
        self.view.addSubview(greenButton)
        colorButtonSetting(button: greenButton)
        greenButton.addTarget(self, action: #selector(greenButtonTapped(_:)), for: .touchUpInside)
        
        yellowButton = UIButton()
        yellowButton.translatesAutoresizingMaskIntoConstraints = false
        yellowButton.backgroundColor = yellow
        self.view.addSubview(yellowButton)
        colorButtonSetting(button: yellowButton)
        yellowButton.addTarget(self, action: #selector(yellowButtonTapped(_:)), for: .touchUpInside)
        
        whiteButton = UIButton()
        whiteButton.translatesAutoresizingMaskIntoConstraints = false
        whiteButton.backgroundColor = white
        self.view.addSubview(whiteButton)
        colorButtonSetting(button: whiteButton)
        whiteButton.addTarget(self, action: #selector(whiteButtonTapped(_:)), for: .touchUpInside)
        
        blackButton = UIButton()
        blackButton.translatesAutoresizingMaskIntoConstraints = false
        blackButton.backgroundColor = black
        self.view.addSubview(blackButton)
        colorButtonSetting(button: blackButton)
        blackButton.addTarget(self, action: #selector(blackButtonTapped(_:)), for: .touchUpInside)
        
        colorButton = UIButton()
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.backgroundColor = getColor
        colorButton.layer.borderWidth = 1.5
        colorButton.layer.borderColor = white.cgColor
        self.view.addSubview(colorButton)
        colorButtonSetting(button: colorButton)
        colorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    private func colorChange(color: UIColor) {
        colorButton.backgroundColor = color
        currentColor = color
    }
    
    @objc private func redButtonTapped(_ sender: UIButton) {
        colorChange(color: sender.backgroundColor!)
    }
    
    @objc private func blueButtonTapped(_ sender: UIButton) {
        colorChange(color: sender.backgroundColor!)
    }
    
    @objc private func greenButtonTapped(_ sender: UIButton) {
        colorChange(color: sender.backgroundColor!)
    }
    
    @objc private func yellowButtonTapped(_ sender: UIButton) {
        colorChange(color: sender.backgroundColor!)
    }
    
    @objc private func whiteButtonTapped(_ sender: UIButton) {
        colorChange(color: sender.backgroundColor!)
    }
    
    @objc private func blackButtonTapped(_ sender: UIButton) {
        colorChange(color: sender.backgroundColor!)
    }
    
    @objc private func colorButtonTapped(_ sender: UIButton) {
        print("tapped")
        switch behaviorMode {
        case .Stop:
            colorButtonsAnimation()
        default:
            returnColorButtonsAnimation()
        }
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        guard layers.count != 0 else {
            return
        }
        imageView.layer.sublayers?.removeAll()
        layers.removeAll()
    }
    
    @objc private func preDeleteButtonTapped(_ sender: UIButton) {
        guard layers.count != 0 else {
            return
        }
        imageView.layer.sublayers?.last?.removeFromSuperlayer()
        layers.last?.removeFromSuperlayer()
    }
    
    @objc private func returnButtonTapped(_ sender: UIButton) {
        //キャプチャ前にボタンを隠す
        buttonsHidden()
        //保存
        savePhoto()
        //閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    private func buttonsHidden() {
        returnButton.isHidden       = true
        preDeleteButton.isHidden    = true
        deleteButton.isHidden       = true
        colorButton.isHidden        = true
        redButton.isHidden          = true
        blueButton.isHidden         = true
        greenButton.isHidden        = true
        yellowButton.isHidden       = true
        whiteButton.isHidden        = true
        blackButton.isHidden        = true
    }
    
    private func savePhoto() {
        //コンテキスト開始
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, 0.0)
        //viewを書き出す
        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        // imageにコンテキストの内容を書き出す
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        //コンテキストを閉じる
        UIGraphicsEndImageContext()
        // imageをカメラロールに保存
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            beforePoint = location
            
            drawLayer = CAShapeLayer()
            layers.append(drawLayer)
            drawLayer.lineWidth = 3.0
            drawLayer.strokeColor = getColor.cgColor
            //self.view.layer.addSublayer(drawLayer)
            self.imageView.layer.addSublayer(drawLayer)
            
            linePath = CGMutablePath()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            
            linePath.move(to: beforePoint)
            linePath.addLine(to: location)
            drawLayer.path = linePath
            
            beforePoint = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            
            linePath.move(to: beforePoint)
            linePath.addLine(to: location)
            drawLayer.path = linePath
            
            beforePoint = location
        }
    }
    
    private func colorButtonsAnimation() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.redButton.frame.origin.y = self.colorButton.frame.origin.y - 60
                        self.blueButton.frame.origin.y = self.colorButton.frame.origin.y - 120
                        self.greenButton.frame.origin.y = self.colorButton.frame.origin.y - 180
                        self.yellowButton.frame.origin.y = self.colorButton.frame.origin.y - 240
                        self.whiteButton.frame.origin.y = self.colorButton.frame.origin.y - 300
                        self.blackButton.frame.origin.y = self.colorButton.frame.origin.y - 360
                        self.behaviorMode = .Animated
        }, completion: nil)
    }
    
    private func returnColorButtonsAnimation() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.redButton.frame.origin.y = self.colorButton.frame.origin.y
                        self.blueButton.frame.origin.y = self.colorButton.frame.origin.y
                        self.greenButton.frame.origin.y = self.colorButton.frame.origin.y
                        self.yellowButton.frame.origin.y = self.colorButton.frame.origin.y
                        self.whiteButton.frame.origin.y = self.colorButton.frame.origin.y
                        self.blackButton.frame.origin.y = self.colorButton.frame.origin.y
                        self.behaviorMode = .Stop
        }, completion: nil)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func colorButtonSetting(button: UIButton) {
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func deleteButtonSetting(_ deleteButton: UIButton) {
        deleteButton.setTitle("×", for: .normal)
        deleteButton.setTitleColor(white, for: .normal)
        deleteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        deleteButton.layer.borderColor = UIColor.darkGray.cgColor
        deleteButton.backgroundColor = UIColor.gray
        deleteButton.layer.borderWidth = 1.5
        deleteButton.layer.cornerRadius = 20
        deleteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func preDeleteButtonSetting(_ preDeleteButton: UIButton) {
        preDeleteButton.setTitle("1つ戻る", for: .normal)
        preDeleteButton.setTitleColor(white, for: .normal)
        preDeleteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        preDeleteButton.layer.borderColor = UIColor.darkGray.cgColor
        preDeleteButton.backgroundColor = UIColor.gray
        preDeleteButton.layer.borderWidth = 1.5
        preDeleteButton.layer.cornerRadius = 20
        preDeleteButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        preDeleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        preDeleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        preDeleteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60).isActive = true
    }
    
    private func returnButtonSetting(_ returnButton: UIButton) {
        returnButton.setTitle("戻る", for: .normal)
        returnButton.setTitleColor(white, for: .normal)
        returnButton.titleLabel?.adjustsFontSizeToFitWidth = true
        returnButton.backgroundColor = UIColor.clear
        returnButton.layer.borderWidth = 2.0
        returnButton.layer.borderColor = white.cgColor
        returnButton.layer.cornerRadius = 20
        returnButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        returnButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        returnButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        returnButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
    }

}
