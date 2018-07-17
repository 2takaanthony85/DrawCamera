//
//  PhotoList.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

struct Photos {
    
    let photo: Photo
    
    let process: ProcessData
    
    init(_ photo: Photo, _ process: ProcessData) {
        self.photo = photo
        self.process = process
    }
}

struct PhotoList {
    
    let date: Date
    
    let photos: [Photos]
    
    init(_ date: Date, photos: [Photos]) {
        self.date = date
        self.photos = photos
    }
}
