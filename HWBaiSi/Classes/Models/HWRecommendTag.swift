//
//  HWRecommendTag.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import Foundation

class HWRecommendTag: NSObject {
    
    var is_sub: Int?            //是否含有子标签
    var theme_id: String?       //此标签的id
    var theme_name: String?     //标签名称
    var sub_number: NSNumber?   //此标签的订阅量
    var is_default: Int?        //是否是默认的推荐标签
    var image_list: String?     //推荐标签的图片url地址
    
}
