//
//  ContainerViewPresenter.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/18.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

protocol ContainerViewPresentable: class {
    
    var view: ContainerViewType? { get }
    
    var sections: Int { get }
    
    func updateDatas()
    
    func itemSections(_ section: Int) -> Int
    
    func sectionText(_ indexPath: IndexPath) -> String
    
    func cellImage(_ section: Int ,_ indexPath: IndexPath) -> Data
}

class ContainerViewPresenter: ContainerViewPresentable {
    
    var sections: Int {
        return model.photoList.count
    }
    
    var view: ContainerViewType?
    
    private let model: PhotoModelInterface
    
    init(_ view: ContainerViewType) {
        self.view = view
        self.model = PhotoModel.init()
        self.model.addObserver(self, selector: #selector(refleshDatas))
    }
    
    func updateDatas() {
        model.resetData()
        model.getData()
    }
    
    
    //セクション毎のセル数を返す
    func itemSections(_ section: Int) -> Int {
         return model.photoList[section].photoDatas.count
    }
    
    //セクションに記載する日付を返す
    func sectionText(_ indexPath: IndexPath) -> String {
        let element = model.photoList[indexPath.row]
        let date = element.date
        return DateFormat.format.string(from: date)
    }
    
    //セルに貼り付けるサムネイルを返す
    func cellImage(_ section: Int ,_ indexPath: IndexPath) -> Data {
        let element = model.photoList[section]
        let data = element.photoDatas[indexPath.row]
        return data.thumbnail
    }
    
    @objc func refleshDatas() {
        view?.reloadData()
    }
    
}
