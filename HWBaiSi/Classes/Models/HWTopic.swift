
//
//  HWTopic.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/25.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

enum TopicType: Int {
    case all        = 1     // 全部
    case picture    = 10    // 图片
    case word       = 29    // 段子
    case voice      = 31    // 音频
    case video      = 41    // 视频
}

class HWTopic: NSObject {
    
    /// 帖子信息
    var id: String!               // 帖子id
    var type: NSNumber!            // 帖子的类型
    var text: String?               // 帖子的内容
    private var _createdAt: String? // 系统审核通过后创建帖子的时间
    
    var is_gif: NSNumber!           // 是否是gif动画
    var top_cmt = [HWComment]()     // 热门评论
    var width: NSNumber?            // 视频或图片类型帖子的宽度
    var height: NSNumber?           // 图片或视频等其他的内容的高度
    private var _playcount: UInt64!         // 如果含有视频则该参数为视频的长度
    
    // 图片
    var image0: String?             // 显示在页面中的视频图片的url，小图
    var image1: String?             // 显示在页面中的视频图片的url，大图
    var image2: String?             // 显示在页面中的视频图片的url，中图
    // 视频
    var image_small: String?        // 显示在页面中的视频图片的url
    var videouri: String?           // 视频播放的url地址
    private var _videotime: String?
    var cdn_img: String?            // 视频加载时候的静态显示的图片地址
    // 音频
    var voiceuri: String?           // 如果为音频，则为音频的播放地址
    private var _voicetime: String? // 如果为音频类帖子，则返回值为音频的时长
    var voicelength: String?        // 如果为音频则为音频的时长
    
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
    
    /// 计算属性
    // 创建时间
    var created_at: String! {
        set {
            _createdAt = newValue
        }
        get {
            return formatCreateAt()
        }
    }
    // 播放次数
    var playcount: String? {         // 播放次数
        set {
            _playcount = NumberFormatter().number(from: newValue ?? "0")?.uint64Value
        }
        get {
            if _playcount > 10000 {
                return String(format:"%.2f万次", Double(_playcount) / 10000.0)
            } else {
                return String(format:"%ld次", _playcount)
            }
        }
    }
    // 视频时间
    var videotime: String? {
        set {
            guard let time = NumberFormatter().number(from: newValue!) else { return }
            let minute = time.intValue / 60
            let second = time.intValue % 60
            _videotime = String(format:"%02d:%02d",minute, second)
        }
        get {
            return _videotime
        }
    }
    var voicetime: String? {
        set {
            guard let time = NumberFormatter().number(from: newValue!) else { return }
            let minute = time.intValue / 60
            let second = time.intValue % 60
            _voicetime = String(format:"%02d:%02d",minute, second)
        }
        get {
            return _voicetime
        }
    }

    
    /// 自定义的一些属性方便设置cell
    private(set) var isBigImage: Bool = false
    private var _mediaFrame: CGRect?
    var mediaFrame: CGRect! {
        return calcMediaFrame()
    }
    private var _cellHeight: CGFloat?
    var cellHeight: CGFloat! {      // cell 高度
        return calcCellHeight()
    }
    
    // MARK: - 重写MJExtension的方法
    override class func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["top_cmt": HWComment.self]
    }
    
    // MARK: - 外部方法
    func setCellHeight(height: CGFloat) {
        _cellHeight = height
    }
    
    // MARK: - 内部方法
    
    /// 
    private func calcMediaFrame() -> CGRect {
        if let frame = _mediaFrame {
            return frame
        }
        let maxWidth = kScreenWidth-14.0*2.0
        let textMaxSize = CGSize(width: maxWidth, height: 200)
        let attri = [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)]
        
        // 头像和底部计算
        var cellY: CGFloat = 10 + 44 + 10;
        // 文字
        if let text = text {
            let size = (text as NSString).boundingRect(with: textMaxSize, options: .usesLineFragmentOrigin, attributes: attri, context: nil)
            cellY += (size.height + 10)
        }
        // 其他资源
        var mediaHeight: CGFloat = 0
        if type != 29 {
            if type == 10 && height!.doubleValue > 360.0 && is_gif.boolValue == false {
                isBigImage = true
                mediaHeight = 200.0
            } else {
                mediaHeight = maxWidth * CGFloat(height!.doubleValue) / CGFloat(width!.doubleValue)
            }
        }
        return CGRect(x: CGFloat(14.0), y: cellY, width: maxWidth, height: mediaHeight)
    }
    
    /// 计算Cell高度
    private func calcCellHeight() -> CGFloat {
        if let height = _cellHeight, height > 0 {
            return height
        }
        var cHeight = mediaFrame.origin.y + mediaFrame.size.height + 10.0
        // 评论区
        if top_cmt.count > 0 {
            var content = top_cmt[0].content!
            if top_cmt[0].voiceuri.hasPrefix("http") {
                content = "[语音评论]"
            }
            let comment = "\(top_cmt[0].user.username ?? "") : \(content)" as NSString
            let maxWidth = kScreenWidth-14.0*2.0
            let textMaxSize = CGSize(width: maxWidth, height: 200)
            let attri = [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
            let size = comment.boundingRect(with: textMaxSize, options: .usesLineFragmentOrigin, attributes: attri, context: nil)
            cHeight += (size.height + 10 + 20)
        }
        cHeight += (35 + 10)
        _cellHeight = cHeight
        return cHeight
    }
    
    /// 格式化输出时间
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
//    var theme_id: String?    // 标签的id,如：微视频的id为55
//    var theme_name: String?    // 帖子的所属分类的标签名字
//    var theme_type: Int?    // 一般为1
//    var passtime: String?    // 帖子通过的时间和created_at的参数时间一致
//    var from: String?    // 9
//    var tag: String?    // 帖子的标签备注
//    var original_pid: String?    // 空
//    var url: String?    // 空
//    var sina_v: Int?    // 是否是新浪会员
//    var theme_name: String?    // 空
//    var status: String?    // 帖子的状态（例：4）
}
