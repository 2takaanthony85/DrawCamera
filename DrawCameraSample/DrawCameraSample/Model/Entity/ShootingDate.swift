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
    
    @objc dynamic var date_id: Int = 0
    
    @objc dynamic var snap_date: Date = Date()
    
    let photos = List<Photo>()
    
    override static func primaryKey() -> String? {
        return "date_id"
    }
}
