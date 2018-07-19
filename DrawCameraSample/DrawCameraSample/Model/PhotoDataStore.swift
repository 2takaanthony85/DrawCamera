//
//  PhotoDataStore.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/19.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import RealmSwift


//自身ができる仕事 (presenter及びviewにとってやってほしいこと)
protocol PhotoDataStoreTasks: class {
    
    func update(_ id: Int, _ thumbnail: Data, _ process: Data, callback: () -> ())
    
}

class PhotoDataStore: PhotoDataStoreTasks {
    
    func update(_ id: Int, _ thumbnail: Data, _ process: Data, callback: () -> ()) {
        DispatchQueue.global().async {
            let realm = try! Realm()
            
            let result = realm.objects(Photo.self).filter("photo_id = \(id)").first
            try! realm.write {
                result!.process_data = process
                result!.thumbnail_data = thumbnail
            }
        }
        callback()
    }
    
}
