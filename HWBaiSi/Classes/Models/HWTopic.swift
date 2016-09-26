
//
//  HWTopic.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/25.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import Foundation

class HWTopic: NSObject {
    
    /// 帖子信息
    var id: NSNumber?               // 帖子id
    var type: String?               // 帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频
    var text: String?               // 帖子的内容
    private var _createdAt: String? // 系统审核通过后创建帖子的时间
    var created_at: String? {
        set {
           _createdAt = newValue
        }
        get {
            return formatCreateAt()
        }
    }
    var is_gif: String?             // 是否是gif动画
    var top_cmt = [HWComment]()     // 热门评论
    
    /// 发帖人的信息
    var user_id: String?            // 发帖人的id
    var jie_v: Int?                 // 是否是百思不得姐的认证用户
    var screen_name: String?        // 发帖人的昵称
    var profile_image: String?      // 头像的图片url地址
    
    /// 关注播放等相关的
    var repost: NSNumber?           // 转发的数量
    var comment: NSNumber?          // 帖子的被评论数量
    var cai: NSNumber?              // 踩的人数
    var ding: NSNumber?             // 顶的人数
    
    var playfcount: NSNumber?       // 真实的播放次数？
    var hate: NSNumber?             // 踩的数量
    var bookmark: NSNumber?         // 帖子的收藏量
    var favourite: NSNumber?        // 帖子的收藏量
    var love: NSNumber?             // 收藏量
    
    // MARK: - 重写MJExtension的方法
    override class func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["top_cmt": HWComment.self]
    }
    
    // MARK: - 内部方法
    private func formatCreateAt() -> String? {
        guard let datetime = _createdAt else { return nil }
        
        let calendar = Calendar.hw_calendar
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: datetime) else { return nil }
        
        // 今年以前
        if !date.hw_isInThisYear {
            return datetime
        }
        // 昨天
        if date.hw_isInYesterday {
            dateFormatter.dateFormat = "昨天 HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        // 昨天以前
        if !date.hw_isInToday {
            dateFormatter.dateFormat = "MM-dd HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        // 今天
        let components = calendar.dateComponents([.hour, .minute, .second], from: date, to: Date())
        if components.hour! > 0 {
            return "\(components.hour!)小时前"
        }
        if components.minute! > 0 {
            return "\(components.minute!)分前"
        }
        
        return "刚刚"
    }
    
//    var weixin_url: String?    // 当分享到微信中的url链接
//    var theme_id: Int?    // 0
//    var mid: Int?    // 0

//    var videotime: String?    // 如果含有视频则该参数为视频的长度

//    var theme_id: String?    // 标签的id,如：微视频的id为55
//    var theme_name: String?    // 帖子的所属分类的标签名字
//    var theme_type: Int?    // 一般为1
//    var voicelength: String?    // 如果为音频则为音频的时长
//    var passtime: String?    // 帖子通过的时间和created_at的参数时间一致
//    var playcount: String?    // 播放次数
//    var voiceuri: String?    // 如果为音频，则为音频的播放地址
//    var cdn_img: String?    // 视频加载时候的静态显示的图片地址
//    var from: String?    // 9
//    var tag: String?    // 帖子的标签备注
//    var height: String?    // 图片或视频等其他的内容的高度
//    var original_pid: String?    // 空
//    var image1: String?    // 显示在页面中的视频图片的url
//    var url: String?    // 空
//    var voicetime: String?    // 如果为音频类帖子，则返回值为音频的时长
//    var image0: String?    // 显示在页面中的视频图片的url
//    var videouri: String?    // 视频播放的url地址
//    var image_small: String?    // 显示在页面中的视频图片的url
//    var sina_v: Int?    // 是否是新浪会员
//    var width: String?    // 视频或图片类型帖子的宽度
//    var theme_name: String?    // 空
//    var status: String?    // 帖子的状态（例：4）
}
