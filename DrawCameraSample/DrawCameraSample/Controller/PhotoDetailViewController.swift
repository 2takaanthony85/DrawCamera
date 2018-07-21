//
//  PhotoDetailViewController.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/18.
//  Copyright © 2018年 atd. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var data: PhotoData!
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "新規編集", style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped(_:)))
        return button
    }()
    
    private lazy var editEndButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(editEndButtonTapped(_:)))
        button.isEnabled = false
        return button
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(backButtonTapped(_:)))
        return button
    }()

    private var detail: DetailView!
    
    private lazy var presenter: PhotoDetailPresentable = PhotoDetailPresenter.init(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItems = [editEndButton, editButton]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(data: data.photo)
        self.view.addSubview(imageView)
        
        
        detail = DetailView(frame: self.view.frame, data)
        detail.delegate = self
        self.view.addSubview(detail)
        
        _ = presenter
    }
    
    @objc private func editButtonTapped(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        self.editEndButton.isEnabled = true
        NotificationCenter.default.post(name: NSNotification.Name("edit"), object: nil)
        self.detail.editMode = true
    }
    
    private func save() {
        let photo = processPhoto()
        let thumbnail = photo.makeThumbnail()
        let thumbnailData = UIImageJPEGRepresentation(thumbnail, 1.0)
        presenter.updatePhoto(data.id, thumbnailData!, detail.commentLabels, detail.layers)
    }
    
    private func processPhoto() -> UIImage {
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
        
        return image
    }
    
    @objc private func editEndButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "元の加工データが削除され、今編集したデータを保存しますがよろしいですか？", preferredStyle: .alert)
        let ok_action = UIAlertAction(title: "OK", style: .default, handler: { action in
            sender.isEnabled = false
            self.editButton.isEnabled = true
            NotificationCenter.default.post(name: NSNotification.Name("endEdit"), object: nil)
            self.detail.editMode = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                self.save()
            })
        })
        alert.addAction(ok_action)
        let cancel_action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel_action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped(_ sender: UIBarButtonItem) {
        guard detail.editMode else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        let alert = UIAlertController(title: "", message: "編集中の加工データは保存されませんがよろしいですか？", preferredStyle: .alert)
        let ok_action = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(ok_action)
        let cancel_action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel_action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PhotoDetailViewController: DetailViewDelegate {
    
    func addComment() {
        let alert = UIAlertController(title: "コメント", message: "コメントを入力してください", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        let ok_action = UIAlertAction(title: "OK", style: .default, handler: { action in
            let textfields = alert.textFields
            if textfields != nil {
                for textfield in textfields! {
                    print(textfield.text!)
                    self.detail.addCommentLabel(text: textfield.text!)
                }
            }
        })
        alert.addAction(ok_action)
        let cancel_action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel_action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension PhotoDetailViewController: PhotoDetailViewType {
    
    func showUpdateResult() {
        let alert = UIAlertController(title: "", message: "編集したデータの保存が完了しました", preferredStyle: .alert)
        let ok_action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok_action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
