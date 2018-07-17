//
//  DateFormat.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

struct DateFormat {
    
    static var format: DateFormatter = {
        let _formatter = DateFormatter()
        _formatter.locale = Locale(identifier: "ja_JP")
        _formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        _formatter.dateFormat = "yyyy/MM/dd"
        return _formatter
    }()

}
