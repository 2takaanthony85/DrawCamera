//
//  PhotoModel.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import RealmSwift

protocol PhotoModelNotify: class {
    
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
    
}

protocol PhotoModelInterface: PhotoModelNotify {
    
    func saveData(_ imageData: Data)
}

class PhotoModel: PhotoModelInterface {
    
    init() {}
    
    func saveData(_ imageData: Data) {
        print("save photo")
        let realm = try! Realm()
        //取得
        let photo = makePhoto(imageData)
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
    
    func makePhoto(_ data: Data) -> Photo {
        let object = Photo.create()
        object.create_date = Date()
        print("Date: \(Date())")
        object.photo_data = data
        return object
    }
    
    func getShootingDate() -> Results<ShootingDate> {
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
        let realm = try! Realm()
        let results = realm.objects(Photo.self)
        print("results count: \(results.count)")
        let _results = realm.objects(ShootingDate.self)
        print("_results count: \(_results.count)")
        NotificationCenter.default.post(name: NSNotification.Name("saveResult"), object: nil)
    }
    
}
