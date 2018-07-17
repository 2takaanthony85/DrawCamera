//
//  PreviewPresenter.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

protocol PreviewPresentable: class {
    
    var view: PreviewType? { get }
    
    func savePhoto(_ data: Data)

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
    
    func savePhoto(_ data: Data) {
        model.saveData(data)
    }
    
    @objc func saveResult() {
        view?.saveNotification()
    }
}
