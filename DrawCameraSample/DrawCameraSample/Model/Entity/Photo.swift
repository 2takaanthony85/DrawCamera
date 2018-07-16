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
    
    @objc dynamic var photo_data: Data = Data()
    
    @objc dynamic var comment: String = ""
    
    @objc dynamic var create_date: Date = Date()
    
    //@objc dynamic var update_date: Date = Date()
    
    override static func primaryKey() -> String? {
        return "photo_id"
    }
}
