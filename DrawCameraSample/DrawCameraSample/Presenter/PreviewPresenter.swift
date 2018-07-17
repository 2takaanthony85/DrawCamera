//
//  PreviewPresenter.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

protocol PreviewPresentable: class {
    
    var view: PreviewType? { get }
    
    func savePhoto(originalData data: Data, _ labels: [String: UILabel], _ layers: [CAShapeLayer], thumbnailData thumbnail: Data)

}

class PreviewPresenter: PreviewPresentable {
    
    private(set) weak var view: PreviewType?
    
    private let model: PhotoModelInterface
    
    init(_ view: PreviewType) {
        self.view = view
        self.model = PhotoModel.init()
        model.addObserver(self, selector: #selector(saveResult))
    }
    
    deinit {
        model.removeObserver(self)
    }
    
    func savePhoto(originalData data: Data, _ labels: [String : UILabel], _ layers: [CAShapeLayer], thumbnailData thumbnail: Data) {
        model.saveData(data, labels, layers, thumbnail)
    }
    
    @objc func saveResult() {
        view?.saveNotification()
    }
}
