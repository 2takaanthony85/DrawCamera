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

protocol PhotoModelInterface: PhotoModelNotify {
    
    func saveData(_ originalData: Data, _ labels: [String: UILabel], _ layers: [CAShapeLayer], _ thumbnailData: Data)
}

class PhotoModel: PhotoModelInterface {
    
    init() {}
    
    func saveData(_ originalData: Data, _ labels: [String : UILabel], _ layers: [CAShapeLayer], _ thumbnailData: Data) {
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

extension PhotoModel: PhotoModelNotify {
    
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
        print("results count: \(results.count)")
        let _results = realm.objects(ShootingDate.self)
        print("_results count: \(_results.count)")
        results.forEach {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: $0.process_data) as! ProcessData
            print("process data labels : \(obj.labels)")
            print("process data layers : \(obj.layers)")
        }
    }
    
}
