//
//  PhotoList.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

struct PhotoData {
    
    let id: Int
    
    let photo: Data
    
    let thumbnail: Data
    
    let process: ProcessData
    
    init(_ id: Int, _ photo: Data, _ thumbnail: Data, _ process: ProcessData) {
        self.id = id
        self.photo = photo
        self.thumbnail = thumbnail
        self.process = process
    }
}

struct PhotoList {
    
    let date: Date
    
    let photoDatas: [PhotoData]
    
    init(_ date: Date, photoDatas: [PhotoData]) {
        self.date = date
        self.photoDatas = photoDatas
    }
}
