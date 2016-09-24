//
//  HWContentType.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/24.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import Foundation

class HWContentType: NSObject {
    
    var title: String?
    var dataURL: String?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    class func mutilInit(arr: [[String: Any]]) -> [HWContentType] {
        var type = [HWContentType]()
        for item in arr {
            type.append(HWContentType(dict: item))
        }
        return type
    }
}
