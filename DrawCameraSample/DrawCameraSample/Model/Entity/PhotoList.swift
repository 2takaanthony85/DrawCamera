//
//  PhotoList.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

struct PhotoList {
    
    let date: Date
    
    let photos: [Photo]
    
    init(_ date: Date, photos: [Photo]) {
        self.date = date
        self.photos = photos
    }
}
