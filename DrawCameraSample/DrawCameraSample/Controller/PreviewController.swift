//
//  PreviewController.swift
//  DrawCameraSample
//
//  Created by 吉川昂広 on 2018/07/02.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

protocol PreviewType: class {
    var presenter: PreviewPresentable { get }
    func saveNotification()
}

class PreviewController: UIViewController, PreviewDelegate, PreviewType {
    
    //撮影写真のデータ
    var photoData: Data!
    
    private var preview: Preview!
    
    private(set) lazy var presenter: PreviewPresentable = PreviewPresenter(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preview = Preview(frame: self.view.frame, image: photoData)
        preview.delegate = self
        self.view.addSubview(preview)
        
        _ = presenter
    }
    
    func savePhoto(_ labels: [String : UILabel], _ layers: [CAShapeLayer]) {
        let photo = processPhoto()
        let thumbnail = photo.makeThumbnail()
        let thumbnailData = UIImageJPEGRepresentation(thumbnail, 1.0)
        presenter.savePhoto(originalData: photoData, labels, layers, thumbnailData: thumbnailData!)
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
    
    func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addComment() {
        let alert = UIAlertController(title: "コメント", message: "コメントを入力してください", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        let ok_action = UIAlertAction(title: "OK", style: .default, handler: { action in
            let textfields = alert.textFields
            if textfields != nil {
                for textfield in textfields! {
                    print(textfield.text!)
                    self.preview.addCommentLabel(text: textfield.text!)
                }
            }
        })
        alert.addAction(ok_action)
        let cancel_action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel_action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func saveNotification() {
        print("save notifications")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
