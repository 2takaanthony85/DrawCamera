//
//  Preview.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/03.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit


class Preview: UIView, PreviewVCPresenter {
    
    //戻る、保存
    private var returnButton: UIButton!
    //全消去
    private var deleteButton: UIButton!
    //色変更
    private var colorButton: UIButton!
    //１段階前に戻る
    private var preDeleteButton: UIButton!
    //コメントボタン
    private var commentButton: UIButton!
    //現状の描画の色
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
        //表示されている
        case Animated
        //表示されていない
        case Stop
    }
    
    private var behaviorMode = BehaviorMode.Stop
    
    private var imageView: UIImageView!
    
    weak var delegate: PreviewDelegate?
    
    private var commentLabel: UILabel!
    
    init(frame: CGRect, image: Data) {
        super.init(frame: frame)
        
        imageView = UIImageView(image: UIImage(data: image))
        imageView.frame = self.frame
        self.addSubview(imageView)
        
        returnButton = UIButton()
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(returnButton)
        returnButtonSetting(self.returnButton)
        returnButton.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deleteButton)
        deleteButtonSetting(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        preDeleteButton = UIButton()
        preDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(preDeleteButton)
        preDeleteButtonSetting(self.preDeleteButton)
        preDeleteButton.addTarget(self, action: #selector(preDeleteButtonTapped(_:)), for: .touchUpInside)
        
        redButton = UIButton()
        redButton.translatesAutoresizingMaskIntoConstraints = false
        redButton.backgroundColor = red
        self.addSubview(redButton)
        colorButtonSetting(button: redButton)
        redButton.addTarget(self, action: #selector(redButtonTapped(_:)), for: .touchUpInside)
        
        blueButton = UIButton()
        blueButton.translatesAutoresizingMaskIntoConstraints = false
        blueButton.backgroundColor = blue
        self.addSubview(blueButton)
        colorButtonSetting(button: blueButton)
        blueButton.addTarget(self, action: #selector(blueButtonTapped(_:)), for: .touchUpInside)
        
        greenButton = UIButton()
        greenButton.translatesAutoresizingMaskIntoConstraints = false
        greenButton.backgroundColor = green
        self.addSubview(greenButton)
        colorButtonSetting(button: greenButton)
        greenButton.addTarget(self, action: #selector(greenButtonTapped(_:)), for: .touchUpInside)
        
        yellowButton = UIButton()
        yellowButton.translatesAutoresizingMaskIntoConstraints = false
        yellowButton.backgroundColor = yellow
        self.addSubview(yellowButton)
        colorButtonSetting(button: yellowButton)
        yellowButton.addTarget(self, action: #selector(yellowButtonTapped(_:)), for: .touchUpInside)
        
        whiteButton = UIButton()
        whiteButton.translatesAutoresizingMaskIntoConstraints = false
        whiteButton.backgroundColor = white
        self.addSubview(whiteButton)
        colorButtonSetting(button: whiteButton)
        whiteButton.addTarget(self, action: #selector(whiteButtonTapped(_:)), for: .touchUpInside)
        
        blackButton = UIButton()
        blackButton.translatesAutoresizingMaskIntoConstraints = false
        blackButton.backgroundColor = black
        self.addSubview(blackButton)
        colorButtonSetting(button: blackButton)
        blackButton.addTarget(self, action: #selector(blackButtonTapped(_:)), for: .touchUpInside)
        
        colorButton = UIButton()
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.backgroundColor = getColor
        colorButton.layer.borderWidth = 1.5
        colorButton.layer.borderColor = white.cgColor
        self.addSubview(colorButton)
        colorButtonSetting(button: colorButton)
        colorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        
        commentButton = UIButton()
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(commentButton)
        commentButtonSetting(self.commentButton)
        commentButton.addTarget(self, action: #selector(commentButtonTapped(_:)), for: .touchUpInside)
    }
    
    func addCommentLabel(text: String) {
        //let commentLabel = CommentLabel(text: text)
        commentLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 60, height: 40))
        commentLabel.text = text
        commentLabel.textColor = UIColor.black
        commentLabel.backgroundColor = UIColor.white
        commentLabel.textAlignment = .center
        commentLabel.isUserInteractionEnabled = true
        self.imageView.addSubview(commentLabel)
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
    
    @objc private func commentButtonTapped(_ sender: UIButton) {
        
        self.delegate?.addComment()
    }
    
    @objc private func returnButtonTapped(_ sender: UIButton) {
        //キャプチャ前にボタンを隠す
        buttonsHidden()
        //保存
        self.delegate?.savePhoto()
        //閉じる
        self.delegate?.closeViewController()
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
        commentButton.isHidden      = true
    }
    
    //フォーカスの描画
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            beforePoint = location
            
            drawLayer = CAShapeLayer()
            layers.append(drawLayer)
            drawLayer.lineWidth = 3.0
            drawLayer.strokeColor = getColor.cgColor
            self.imageView.layer.addSublayer(drawLayer)
            
            linePath = CGMutablePath()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if commentLabel != nil {
                if location.x < commentLabel.frame.maxX && commentLabel.frame.origin.x < location.x && location.y < commentLabel.frame.maxY && commentLabel.frame.origin.y < location.y {
                    commentLabel.frame = commentLabel.frame.offsetBy(dx: location.x - beforePoint.x, dy: location.y - beforePoint.y)
                } else {
                    linePath.move(to: beforePoint)
                    linePath.addLine(to: location)
                    drawLayer.path = linePath
                    
                    beforePoint = location
                }
            } else {
                linePath.move(to: beforePoint)
                linePath.addLine(to: location)
                drawLayer.path = linePath
                
                beforePoint = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if commentLabel != nil {
                if location.x < commentLabel.frame.maxX && commentLabel.frame.origin.x < location.x && location.y < commentLabel.frame.maxY && commentLabel.frame.origin.y < location.y {
                    commentLabel.frame = commentLabel.frame.offsetBy(dx: location.x - beforePoint.x, dy: location.y - beforePoint.y)
                } else {
                    linePath.move(to: beforePoint)
                    linePath.addLine(to: location)
                    drawLayer.path = linePath
                    
                    beforePoint = location
                }
            } else {
                linePath.move(to: beforePoint)
                linePath.addLine(to: location)
                drawLayer.path = linePath
                
                beforePoint = location
            }
            
            
        }
    }
    
    //色変更時のボタンのアニメーション
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Preview {
    
    //レイアウトなど見た目に関する部分
    
    private func colorButtonSetting(button: UIButton) {
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
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
        deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
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
        preDeleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        preDeleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
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
        returnButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        returnButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
    
    private func commentButtonSetting(_ commentButton: UIButton) {
        commentButton.setTitle("コメント", for: .normal)
        commentButton.setTitleColor(black, for: .normal)
        commentButton.titleLabel?.adjustsFontSizeToFitWidth = true
        commentButton.backgroundColor = white
        commentButton.layer.cornerRadius = 20
        commentButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        commentButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        commentButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
}
