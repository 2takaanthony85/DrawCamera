//
//  Photo.swift
//  DrawCameraSample
//
//  Created by 吉川昂広 on 2018/07/16.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object {
    
    @objc dynamic var photo_id: Int = 0
    
    //オリジナルの写真データ
    @objc dynamic var photo_data: Data = Data()
    
    //加工データ
    @objc dynamic var process_data: Data = Data()
    
    //撮影日時
    @objc dynamic var create_date: Date = Date()
    
    //サムネイル画像データ
    @objc dynamic var thumbnail_data: Data = Data()
    
    override static func primaryKey() -> String? {
        return "photo_id"
    }
    
    static func create() -> Photo {
        let object = Photo()
        object.photo_id = lastID()
        return object
    }
    
    private static func lastID() -> Int {
        let realm = try! Realm()
        var maxID = 0
        let results = realm.objects(Photo.self)
        results.forEach {
            if maxID < $0.photo_id {
                maxID = $0.photo_id
            }
        }
        return maxID + 1
    }
}
