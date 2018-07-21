//
//  Preview.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/03.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit


class Preview: UIView {
    
    //戻る、保存
    private lazy var returnButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        self.returnButtonSetting(button)
        return button
    }()
    
    //コメントボタン
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(commentButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        commentButtonSetting(button)
        return button
    }()
    
    //全消去ボタン
    private lazy var deleteButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        self.commentDeleteButtonSetting(button)
        return button
    }()
    
    //1つだけ消去ボタン
    private lazy var preDeleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(preDeleteButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        self.commentPreDeleteButtonSetting(button)
        return button
    }()
    
    //コメントモードボタン
    private lazy var commentModeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(commnetModeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        self.commentModeButtonSetting(button)
        return button
    }()
    
    //描画モードボタン
    private lazy var drawModeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(drawModeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        self.drawModeButtonSetting(button)
        return button
    }()
    
    //編集モード
    private enum EditMode {
        //なし
        case None
        //コメントモード
        case Comment
        //描画モード
        case Draw

    }
    
    //編集モードのステータス
    private var currentEditMode: EditMode = .None
    
    private var drawModeButtons: [UIButton]!
    private var commentModeButtons: [UIButton]!
    
    //現状の描画の色
    private var currentColor: UIColor = UIColor.red
    var getColor: UIColor {
        get {
            return currentColor
        }
    }
    
    //赤色変更ボタン
    private lazy var redButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.backgroundColor = red
        self.colorButtonSetting(button: button)
        return button
    }()
    //赤を返す
    private var red: UIColor {
        return UIColor.red
    }
    
    //青色変更ボタン
    private lazy var blueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.backgroundColor = blue
        colorButtonSetting(button: button)
        return button
    }()
    //青を返す
    private var blue: UIColor {
        return UIColor.blue
    }
    
    //緑色変更ボタン
    private lazy var greenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.backgroundColor = green
        colorButtonSetting(button: button)
        return button
    }()
    //緑を返す
    private var green: UIColor {
        return UIColor.green
    }
    
    //黄色変更ボタン
    private lazy var yellowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.backgroundColor = yellow
        colorButtonSetting(button: button)
        return button
    }()
    //黄色を返す
    private var yellow: UIColor {
        return UIColor.yellow
    }
    
    //白色変更ボタン
    private lazy var whiteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.backgroundColor = white
        colorButtonSetting(button: button)
        return button
    }()
    //白を返す
    private var white: UIColor {
        return UIColor.white
    }
    
    //黒色変更ボタン
    private lazy var blackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(colorChangeButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.backgroundColor = black
        colorButtonSetting(button: button)
        return button
    }()
    //黒を返す
    private var black: UIColor {
        return UIColor.black
    }
    
    //色変更
    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1.5
        button.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.backgroundColor = self.getColor
        button.layer.borderColor = white.cgColor
        colorButtonSetting(button: button)
        return button
    }()
    
    //描画されたパスを一時的に保存するようの配列
    private var layers: [CAShapeLayer] = []
    
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
    
    //写真のビュー
    private var imageView: UIImageView!
    
    weak var delegate: PreviewDelegate?
    
    //コメントラベル
    private var commentLabel: UILabel!
    //コメントラベルを一時的に保存しておく配列
    private var commentLabels: [String: UILabel] = [:]
    //移動用のラベル
    private var moveLabel: UILabel!
    
    //コメント配置用のダミーのview
    private var dummy: UIView!
    
    init(frame: CGRect, image: Data) {
        super.init(frame: frame)
        
        imageView = UIImageView(image: UIImage(data: image))
        imageView.frame = self.frame
        self.addSubview(imageView)
        
        //コメント配置用のダミーのview
        dummy = UIView(frame: self.frame)
        dummy.backgroundColor = UIColor.clear
        self.addSubview(dummy)
        
        returnButton.isHidden       = false
        commentModeButton.isHidden  = false
        drawModeButton.isHidden     = false
        
        drawModeButtons = [redButton, blueButton, greenButton, yellowButton, whiteButton, blackButton, colorButton]
        drawModeButtons.forEach { $0.isHidden = true }
        commentModeButtons = [commentButton ]
        commentModeButtons.forEach { $0.isHidden = true }
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
        switch currentEditMode {
        case .Comment:
            guard commentLabels.count != 0 else { return }
            commentLabels = [:]
            dummy.subviews.forEach { $0.removeFromSuperview() }
        case .Draw:
            guard layers.count != 0 else { return }
            imageView.layer.sublayers?.removeAll()
            layers.removeAll()
        default:
            break
        }
    }
    
    @objc private func preDeleteButtonTapped(_ sender: UIButton) {
        switch currentEditMode {
        case .Comment:
            guard commentLabels.count != 0 else { return }
            let last = dummy.subviews.last as! UILabel
            dummy.subviews.last?.removeFromSuperview()
            commentLabels.removeValue(forKey: last.text!)
            //確認
            print("comment labels : \(commentLabels)")
        case .Draw:
            guard layers.count != 0 else { return }
            imageView.layer.sublayers?.last?.removeFromSuperlayer()
            layers.removeLast()
        default:
            break
        }
    }
    
    @objc private func commentButtonTapped(_ sender: UIButton) {
        self.delegate?.addComment()
    }
    
    //コメントモードボタン
    @objc private func commnetModeButtonTapped(_ sender: UIButton) {
        currentEditMode = .Comment
        buttonModeChange()
        deleteButton.isHidden = false
        preDeleteButton.isHidden = false
    }
    
    //描画モードボタン
    @objc private func drawModeButtonTapped(_ sender: UIButton) {
        currentEditMode = .Draw
        buttonModeChange()
        deleteButton.isHidden = false
        preDeleteButton.isHidden = false
    }
    
    private func buttonModeChange() {
        switch currentEditMode {
        case .Comment:
            drawModeButtons.forEach { $0.isHidden = true }
            commentModeButtons.forEach { $0.isHidden = false }
        case .Draw:
            drawModeButtons.forEach { $0.isHidden = false }
            commentModeButtons.forEach { $0.isHidden = true }
        default:
            break
        }
    }
    
    @objc private func returnButtonTapped(_ sender: UIButton) {
        //キャプチャ前にボタンを隠す
        buttonsHidden()
        print("layers.count2: \(layers.count)")
        //保存
        self.delegate?.savePhoto(commentLabels, layers)
        //閉じる
        self.delegate?.closeViewController()
    }
    
    //保存時に写真に写り込まないようにボタンを隠す
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
        commentModeButton.isHidden  = true
        drawModeButton.isHidden     = true
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
        //self.addSubview(commentLabel)
        self.dummy.addSubview(commentLabel)
        commentLabels[text] = commentLabel
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
    
    //移動させるコメントの特定
    private func moveLabelSpecified(_ location: CGPoint) {
        guard commentLabel != nil else { return }
        commentLabels.forEach {
            print("$0 : \($0.value.frame)")
            if location.x < $0.value.frame.maxX && location.x > $0.value.frame.origin.x && location.y < $0.value.frame.maxY && location.y > $0.value.frame.origin.y {
                print("tap point label")
                moveLabel = $0.value
            }
        }
    }
    
    //タップした位置がmovelabelかどうか判定
    private func tapPointJudgeOnMoveLabel(_ location: CGPoint) {
        if location.x <= moveLabel.frame.maxX && location.x >= moveLabel.frame.origin.x && location.y <= moveLabel.frame.maxY && location.y >= moveLabel.frame.origin.y {
            moveLabel.frame = moveLabel.frame.offsetBy(dx: location.x - beforePoint.x, dy: location.y - beforePoint.y)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard currentEditMode != .None else { return }
        if let touch = touches.first {
            let location = touch.location(in: self)
            beforePoint = location
            
            if currentEditMode == .Comment {
                moveLabelSpecified(location)
            } else if currentEditMode == .Draw {
                makePathLayer()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard currentEditMode != .None else { return }
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            defer { beforePoint = location }
            
            if currentEditMode == .Comment {
                guard moveLabel != nil else { return }
                tapPointJudgeOnMoveLabel(location)
                judgePortraitFrame(moveLabel)
            } else if currentEditMode == .Draw {
                drawLine(location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard currentEditMode != .None else { return }
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            defer { beforePoint = location }
            
            if currentEditMode == .Comment {
                guard moveLabel != nil else { return }
                tapPointJudgeOnMoveLabel(location)
                judgePortraitFrame(moveLabel)
            } else if currentEditMode == .Draw {
                drawLine(location)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Preview {
    
    //レイアウトなど見た目に関する部分
    
    //色変更に関するボタンはこれを使用しているので注意
    private func colorButtonSetting(button: UIButton) {
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
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
        commentButton.setTitle("追加", for: .normal)
        commentButton.setTitleColor(black, for: .normal)
        commentButton.titleLabel?.adjustsFontSizeToFitWidth = true
        commentButton.backgroundColor = white
        commentButton.layer.cornerRadius = 20
        commentButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        commentButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        commentButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    private func commentDeleteButtonSetting(_ commentDeleteButton: UIButton) {
        commentDeleteButton.setTitle("全消去", for: .normal)
        commentDeleteButton.setTitleColor(black, for: .normal)
        commentDeleteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        commentDeleteButton.backgroundColor = white
        commentDeleteButton.layer.cornerRadius = 20
        commentDeleteButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        commentDeleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        commentDeleteButton.trailingAnchor.constraint(equalTo: self.commentButton.leadingAnchor, constant: -10).isActive = true
        commentDeleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    private func commentPreDeleteButtonSetting(_ button: UIButton) {
        button.setTitle("1つ消す", for: .normal)
        button.setTitleColor(black, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = white
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: self.deleteButton.leadingAnchor, constant: -10).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    private func commentModeButtonSetting(_ sender: UIButton) {
        sender.setTitle("コメント", for: .normal)
        sender.setTitleColor(black, for: .normal)
        sender.titleLabel?.adjustsFontSizeToFitWidth = true
        sender.backgroundColor = white
        sender.layer.cornerRadius = 20
        sender.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sender.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sender.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        sender.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
    
    private func drawModeButtonSetting(_ sender: UIButton) {
        sender.setTitle("描画", for: .normal)
        sender.setTitleColor(black, for: .normal)
        sender.titleLabel?.adjustsFontSizeToFitWidth = true
        sender.backgroundColor = white
        sender.layer.cornerRadius = 20
        sender.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sender.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sender.trailingAnchor.constraint(equalTo: self.commentModeButton.leadingAnchor, constant: -10).isActive = true
        sender.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
}
