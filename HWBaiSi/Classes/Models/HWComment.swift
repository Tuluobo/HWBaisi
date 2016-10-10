//
//  HWComment.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/26.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import Foundation

class HWComment: NSObject {

    var data_id: String?
    var id: String!
    var content: String!
    var ctime: String?
    var like_count: NSNumber!
    var voiceuri: String!
    var voicetime: NSNumber!
    var user: HWUser!
    
    // MARK: - 重写MJExtension的方法
    override class func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["user": HWUser.self]
    }
    
}
