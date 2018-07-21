//
//  ProcessData.swift
//  DrawCameraSample
//
//  Created by atd on 2018/07/17.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

struct SerializedKey {
    
    static let labels = "labels"
    
    static let layers = "layers"
    
}

class ProcessData: NSObject, NSCoding {
    
    var labels: [String: UILabel]
    var layers: [CAShapeLayer]
    
    init(_ labels: [String: UILabel], _ layers: [CAShapeLayer]) {
        self.labels = labels
        self.layers = layers
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.labels = aDecoder.decodeObject(forKey: SerializedKey.labels) as? [String: UILabel] ?? [:]
        self.layers = aDecoder.decodeObject(forKey: SerializedKey.layers) as? [CAShapeLayer] ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.labels, forKey: SerializedKey.labels)
        aCoder.encode(self.layers, forKey: SerializedKey.layers)
    }

}
