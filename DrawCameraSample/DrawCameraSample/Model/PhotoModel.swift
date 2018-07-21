//
//  PhotoModel.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

protocol PhotoModelNotify: class {
    
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
    
}

protocol PhotoSaveModelInterface: PhotoModelNotify {
    
    func saveData(_ originalData: Data, _ labels: [String: UILabel], _ layers: [CAShapeLayer], _ thumbnailData: Data)
}

protocol PhotoModelInterface: PhotoModelNotify {
    
    var photoList: [PhotoList] { get }
    
    func resetData()
    
    func getData()
    
    func update()
    
    func delete(_ indexPaths: [(section: Int, row: Int)])
    
    func deleteObserver(_ observer: Any, selector: Selector)
    
    func removeDeleteObserver(_ observer: Any)
    
    func deleteNotify()
}

class PhotoSaveModel: PhotoSaveModelInterface {
    
    init() {}
    
    func saveData(_ originalData: Data, _ labels: [String : UILabel], _ layers: [CAShapeLayer], _ thumbnailData: Data) {
        //確認用
        getDB()
        
        let realm = try! Realm()

        //object
        let process = ProcessData.init(labels, layers)

        //取得
        let photo = makePhoto(originalData, thumbnailData)
        photo.process_data = NSKeyedArchiver.archivedData(withRootObject: process)
        let date = getShootingDate()

        //保存
        switch date {
        case let .There(result):
            try! realm.write {
                result.photos.append(photo)
            }
        case let .None(result):
            result.photos.append(photo)
            try! realm.write {
                realm.add(result)
            }
        }
        
        notify()
    }

    //オブジェクトを保存するファイルのパスを生成
    private func makeFilePath(_ date: Date, _ id: Int) -> String {
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dateStr = DateFormat.fileFormat.string(from: date)
        let fileName = dateStr + "_" + String(id) + ".dat"
        let archiveURL = URL(fileURLWithPath: documentDir).appendingPathComponent(fileName)
        return archiveURL.path
    }
    
    //realm objectのPhotoを生成
    private func makePhoto(_ data: Data, _ thumbnail: Data) -> Photo {
        let object = Photo.create()
        object.create_date = Date()
        print("Date: \(Date())")
        object.photo_data = data
        object.thumbnail_data = thumbnail
        return object
    }
    
    //realm objectのShootingDateを生成
    private func getShootingDate() -> Results<ShootingDate> {
        let realm = try! Realm()
        let results = realm.objects(ShootingDate.self)
        let today = DateFormat.format.string(from: Date())
        print("today: \(today)")
        var object: ShootingDate?
        results.forEach {
            print("shootingdate date: \(DateFormat.format.string(from: $0.snap_date))")
            if today == DateFormat.format.string(from: $0.snap_date) {
                object = $0
            }
        }
        if object != nil {
            print("object is not nil")
            return .There(object!)
        } else {
            print("object is nil")
            let newObject = ShootingDate.create()
            newObject.snap_date = Date()
            return .None(newObject)
        }
    }
    
}

extension PhotoSaveModel: PhotoModelNotify {
    
    func addObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name("saveResult"), object: nil)
    }
    
    func removeObserver(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func notify() {
        //保存できているか確認
        getDB()
        
        NotificationCenter.default.post(name: NSNotification.Name("saveResult"), object: nil)
    }
    
    //確認用
    func getDB() {
        let realm = try! Realm()
        let results = realm.objects(Photo.self)
        print("Photo count: \(results.count)")
        let _results = realm.objects(ShootingDate.self)
        print("ShootingDate count: \(_results.count)")
        results.forEach {
//            let obj = NSKeyedUnarchiver.unarchiveObject(with: $0.process_data) as! ProcessData
//            print("process data labels : \(obj.labels)")
//            print("process data layers : \(obj.layers)")
            print("id : \($0.photo_id)")
        }
    }
}

class PhotoModel: PhotoModelInterface {
    
    private(set) var photoList: [PhotoList] = []
    
    init() {}
    
    func resetData() {
        photoList = []
        notify()
    }
    
    func getData() {
        let realm = try! Realm()
        
        let dates = realm.objects(ShootingDate.self)
        dates.forEach({ (data) -> Void in
            var photoDatas: [PhotoData] = []
            data.photos.forEach({ (photo) -> Void in
                let process = NSKeyedUnarchiver.unarchiveObject(with: photo.process_data) as! ProcessData
                let photoData = PhotoData.init(photo.photo_id, photo.photo_data, photo.thumbnail_data, process)
                photoDatas.append(photoData)
            })
            let photoListElement = PhotoList.init(data.snap_date, photoDatas: photoDatas)
            photoList.append(photoListElement)
        })
        notify()
    }
    
    func update() {
        print("a")
    }
    
    func delete(_ indexPaths: [(section: Int, row: Int)]) {
        var ids: [Int] = []
        indexPaths.forEach {
            let id = photoList[$0.section].photoDatas[$0.row].id
            ids.append(id)
        }
        guard ids.count != 0 else {
            return
        }
        let realm = try! Realm()
        ids.forEach({ (id) -> Void in
            let results = realm.objects(Photo.self).filter("photo_id = \(id)")
            results.forEach { (result) -> Void in
                try! realm.write {
                    realm.delete(result)
                }
            }
        })
        deleteNotify()
    }
    
    func deleteObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name("delete"), object: nil)
    }
    
    func removeDeleteObserver(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func deleteNotify() {
        NotificationCenter.default.post(name: NSNotification.Name("delete"), object: nil)
    }
}

extension PhotoModel: PhotoModelNotify {
    
    func addObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name("get"), object: nil)
    }
    
    func removeObserver(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func notify() {
        NotificationCenter.default.post(name: NSNotification.Name("get"), object: nil)
    }
}
