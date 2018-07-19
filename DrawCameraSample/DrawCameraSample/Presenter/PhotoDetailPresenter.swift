//
//  PhotoDetailPresenter.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/19.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

//interface (vcへの指示)
protocol PhotoDetailViewType: class {
    
    func showUpdateResult()
    
}

//vcからの指示　（モデルにしてもらいたいこと）
protocol PhotoDetailPresentable: class {
    
    var view: PhotoDetailViewType? { get }
    
    func updatePhoto(_ id: Int, _ thumbnail: Data, _ labels: [String: UILabel], _ layers: [CAShapeLayer])
    
}


class PhotoDetailPresenter: PhotoDetailPresentable {
    
    private(set) weak var view: PhotoDetailViewType?
    
    private let store: PhotoDataStore
    
    init(_ view: PhotoDetailViewType) {
        self.view = view
        self.store = PhotoDataStore()
    }
    
    func updatePhoto(_ id: Int, _ thumbnail: Data, _ labels: [String: UILabel], _ layers: [CAShapeLayer]) {
        let process = ProcessData.init(labels, layers)
        let processData = objectToData(process)
        store.update(id, thumbnail, processData, callback: {
            self.view?.showUpdateResult()
        })
    }
    
    private func objectToData(_ object: ProcessData) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: object)
    }
}
