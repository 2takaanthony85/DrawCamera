//
//  DetailView.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/19.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    //全消去
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    //色変更
    private var colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1.5
        button.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    //１段階前に戻る
    private var preDeleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(preDeleteButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    //コメントボタン
    private var commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(commentButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    //現状の描画の色
    private var currentColor: UIColor = UIColor.red
    var getColor: UIColor {
        get {
            return currentColor
        }
    }
    
    //赤色変更ボタン
    private var redButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    //赤を返す
    private var red: UIColor {
        return UIColor.red
    }
    
    //青色変更ボタン
    private var blueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    //青を返す
    private var blue: UIColor {
        return UIColor.blue
    }
    
    //緑色変更ボタン
    private var greenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    //緑を返す
    private var green: UIColor {
        return UIColor.green
    }
    
    //黄色変更ボタン
    private var yellowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    //黄色を返す
    private var yellow: UIColor {
        return UIColor.yellow
    }
    
    //白色変更ボタン
    private var whiteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    //白を返す
    private var white: UIColor {
        return UIColor.white
    }
    
    //黒色変更ボタン
    private var blackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    //黒を返す
    private var black: UIColor {
        return UIColor.black
    }
    
    //描画されたパスを一時的に保存するようの配列
    var layers: [CAShapeLayer] = []
    
    //描画パス用のlayer
    private var drawLayer: CAShapeLayer!
    
    //描画するパスを作成する際、起点になる位置
    private var beforePoint: CGPoint!
    
    //描画用のパス
    private var linePath: CGMutablePath!
    
    //色変更ボタンが変更モードかどうか判断
    private enum BehaviorMode {
        //表示されている
        case Animated
        //表示されていない
        case Stop
    }
    //色変更モードの現在の状態
    private var behaviorMode = BehaviorMode.Stop
    
    //タップ時、コメントかそれ以外かをタップしたかを判断
    private enum TapPoint {
        //label
        case Label
        //sharplayer
        case SharpLayer
    }
    
    //タップの状態
    private var tapPoint: TapPoint!
    
    //写真のビュー
    private var imageView: UIImageView!
    
    //編集モードがどうか
    var editMode = false
    
    //コメントラベル
    private var commentLabel: UILabel!
    //コメントラベルを一時的に保存しておく配列
    var commentLabels: [String: UILabel] = [:]
    //移動用のラベル
    private var moveLabel: UILabel!
    
    weak var delegate: DetailViewDelegate?

    init(frame: CGRect, _ data: PhotoData) {
        super.init(frame: frame)
        
        imageView = UIImageView(image: UIImage(data: data.photo))
        imageView.frame = self.frame
        self.addSubview(imageView)
        
        data.process.layers.forEach({ (layer) -> Void in
            imageView.layer.addSublayer(layer)
        })
        data.process.labels.forEach({ (label) -> Void in
            imageView.addSubview(label.value)
        })
        
        self.addSubview(deleteButton)
        deleteButtonSetting(deleteButton)
        
        self.addSubview(preDeleteButton)
        preDeleteButtonSetting(self.preDeleteButton)
        
        self.addSubview(redButton)
        redButton.backgroundColor = red
        colorButtonSetting(button: redButton)
        
        self.addSubview(blueButton)
        blueButton.backgroundColor = blue
        colorButtonSetting(button: blueButton)
        
        self.addSubview(greenButton)
        greenButton.backgroundColor = green
        colorButtonSetting(button: greenButton)
        
        self.addSubview(yellowButton)
        yellowButton.backgroundColor = yellow
        colorButtonSetting(button: yellowButton)
        
        self.addSubview(whiteButton)
        whiteButton.backgroundColor = white
        colorButtonSetting(button: whiteButton)
        
        self.addSubview(blackButton)
        blackButton.backgroundColor = black
        colorButtonSetting(button: blackButton)
        
        self.addSubview(colorButton)
        colorButton.backgroundColor = getColor
        colorButton.layer.borderColor = white.cgColor
        colorButtonSetting(button: colorButton)
        
        self.addSubview(commentButton)
        commentButtonSetting(self.commentButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(buttonsHidden), name: NSNotification.Name("endEdit"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(buttonsDisplay), name: NSNotification.Name("edit"), object: nil)
    }
    
    @objc
    private func buttonsHidden() {
        buttonsHiddenSetting()
    }
    
    @objc
    private func buttonsDisplay() {
        imageView.subviews.forEach {
            $0.removeFromSuperview()
        }
        imageView.layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
        buttonsDisplaySetting()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func colorChangeButtonTapped(_ sender: UIButton) {
        colorButton.backgroundColor = sender.backgroundColor
        currentColor = sender.backgroundColor!
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
        layers.removeLast()
        print("layers.count: \(layers.count)")
    }
    
    @objc private func commentButtonTapped(_ sender: UIButton) {
        self.delegate?.addComment()
    }
    
    //コメントを追加する
    func addCommentLabel(text: String) {
        commentLabel = UILabel()
        commentLabel.center = self.center
        commentLabel.text = text
        commentLabel.textColor = UIColor.black
        commentLabel.backgroundColor = UIColor.white
        commentLabel.textAlignment = .center
        commentLabel.sizeToFit()
        commentLabel.isUserInteractionEnabled = true
        self.addSubview(commentLabel)
        commentLabels[text] = commentLabel
    }
    
    //タップ時の位置によって線の描画か、コメントの移動か判断する
    private func modeChange(_ location: CGPoint) {
        tapPoint = .SharpLayer
        guard commentLabel != nil else {
            makePathLayer()
            return
        }
        commentLabels.forEach {
            print("$0 : \($0.value.frame)")
            if location.x < $0.value.frame.maxX && location.x > $0.value.frame.origin.x && location.y < $0.value.frame.maxY && location.y > $0.value.frame.origin.y {
                tapPoint = .Label
                print("tap point label")
                moveLabel = $0.value
            }
        }
        switch tapPoint {
        case .SharpLayer:
            makePathLayer()
        default:
            break
        }
    }
    
    //線を描画するためのlayerとpathを作成する
    private func makePathLayer() {
        drawLayer = CAShapeLayer()
        layers.append(drawLayer)
        drawLayer.lineWidth = 3.0
        drawLayer.strokeColor = getColor.cgColor
        self.imageView.layer.addSublayer(drawLayer)
        
        linePath = CGMutablePath()
    }
    
    //線を描画する
    private func drawLine(_ location: CGPoint) {
        linePath.move(to: beforePoint)
        linePath.addLine(to: location)
        drawLayer.path = linePath
    }
    
    //移動時の境界判定（縦画面の場合）
    private func judgePortraitFrame(_ label: UILabel) {
        label.frame.origin.x = label.frame.origin.x < self.frame.origin.x ? self.frame.origin.x : label.frame.origin.x
        label.frame.origin.y = label.frame.origin.y < self.frame.origin.y ? self.frame.origin.y : label.frame.origin.y
        label.frame.origin.x = self.frame.maxX < label.frame.maxX ? (self.frame.maxX - label.frame.width) : label.frame.origin.x
        label.frame.origin.y = self.frame.maxY < label.frame.maxY ? (self.frame.maxY - label.frame.height) : label.frame.origin.y
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard editMode else {
            return
        }
        if let touch = touches.first {
            let location = touch.location(in: self)
            beforePoint = location
            
            modeChange(location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard editMode else {
            return
        }
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            defer { beforePoint = location }
            
            if tapPoint == .Label {
                moveLabel.frame = moveLabel.frame.offsetBy(dx: location.x - beforePoint.x, dy: location.y - beforePoint.y)
                judgePortraitFrame(moveLabel)
            } else {
                drawLine(location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard editMode else {
            return
        }
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            defer { beforePoint = location }
            
            if tapPoint == .Label {
                moveLabel.frame = moveLabel.frame.offsetBy(dx: location.x - beforePoint.x, dy: location.y - beforePoint.y)
                judgePortraitFrame(moveLabel)
            } else {
                drawLine(location)
            }
            
        }
    }
    
    //編集モードが終わったときのボタン非表示
    private func buttonsHiddenSetting() {
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
    
    //編集モードになったときのボタンの表示
    private func buttonsDisplaySetting() {
        preDeleteButton.isHidden    = false
        deleteButton.isHidden       = false
        colorButton.isHidden        = false
        redButton.isHidden          = false
        blueButton.isHidden         = false
        greenButton.isHidden        = false
        yellowButton.isHidden       = false
        whiteButton.isHidden        = false
        blackButton.isHidden        = false
        commentButton.isHidden      = false
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
    
    //色変更時のボタンのアニメーション
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
    
}

extension DetailView {
    
    //レイアウトなど見た目に関する部分
    
    //色変更に関するボタンはこれを使用しているので注意
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
    
    private func commentButtonSetting(_ commentButton: UIButton) {
        commentButton.setTitle("コメント", for: .normal)
        commentButton.setTitleColor(black, for: .normal)
        commentButton.titleLabel?.adjustsFontSizeToFitWidth = true
        commentButton.backgroundColor = white
        commentButton.layer.cornerRadius = 20
        commentButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        commentButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150).isActive = true
        commentButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
}
