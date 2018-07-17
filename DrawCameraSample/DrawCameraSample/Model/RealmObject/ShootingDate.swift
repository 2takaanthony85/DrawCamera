//
//  ShootingDate.swift
//  DrawCameraSample
//
//  Created by 吉川昂広 on 2018/07/16.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import RealmSwift

class ShootingDate: Object {
    
    @objc dynamic var snap_id: Int = 0
    
    @objc dynamic var snap_date: Date = Date()
    
    let photos = List<Photo>()
    
    override static func primaryKey() -> String? {
        return "snap_id"
    }
    
    static func create() -> ShootingDate {
        let object = ShootingDate()
        object.snap_id = lastID()
        return object
    }
    
    private static func lastID() -> Int {
        let realm = try! Realm()
        if let object = realm.objects(ShootingDate.self).last {
            return object.snap_id + 1
        } else {
            return 1
        }
    }
}

