//
//  HWTopicImageView.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/28.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import AFNetworking

class HWTopicImageView: UIView {
    
    var topicModel: HWTopic? {
        didSet {
            updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.randomColor
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gitTagImageView: UIImageView!
    @IBOutlet weak var videoStartBtn: UIButton!
    @IBOutlet weak var openBigPictureBtn: UIButton!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var playTimeLabel: UILabel!
    
    private func updateUI() {
        imageView.image = nil
        videoStartBtn.isHidden = true
        openBigPictureBtn.isHidden = true
        playCountLabel.isHidden = true
        playTimeLabel.isHidden = true
    
        guard let data = topicModel else { return }
        
        self.frame = data.mediaFrame
        gitTagImageView.isHidden = !data.is_gif.boolValue
        
        switch AFNetworkReachabilityManager.shared().networkReachabilityStatus {
        case .reachableViaWWAN:
            imageView.sd_setImage(with: URL(string: data.image0!))
        case .reachableViaWiFi:
            imageView.sd_setImage(with: URL(string: data.image1!))
        default:
            imageView.sd_setImage(with: URL(string: data.image2!))
        }
        if data.isBigImage {
            openBigPictureBtn.isHidden = false
            imageView.contentMode = .top
            imageView.clipsToBounds = true
        } else {
            openBigPictureBtn.isHidden = true
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = false
        }
        // 对不同类型的帖子处理
        if data.type.intValue == 10 {   // 图片
            
        } else if data.type.intValue == 32 {    // 音频
            playCountLabel.isHidden = false
            playCountLabel.text = data.playcount
            playTimeLabel.isHidden = false
            playTimeLabel.text = data.voicelength
            videoStartBtn.isHidden = false
        } else if data.type.intValue == 41 {    // 视频
            playCountLabel.isHidden = false
            playCountLabel.text = data.playcount
            playTimeLabel.isHidden = false
            playTimeLabel.text = data.videotime
            videoStartBtn.isHidden = false
        }   
    }
}
