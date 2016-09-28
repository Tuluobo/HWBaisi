//
//  HWTopicImageView.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/28.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

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
        gitTagImageView.isHidden = true
        videoStartBtn.isHidden = true
        openBigPictureBtn.isHidden = true
        playCountLabel.isHidden = true
        playTimeLabel.isHidden = true
        
        
        guard let data = topicModel else { return }
        
        let maxWidth = kScreenWidth-14.0*2.0
        let height = maxWidth * CGFloat(data.height!.doubleValue) / CGFloat(data.width!.doubleValue)
        self.frame = CGRect(x: 14, y: 84, width: maxWidth, height: height)
        if data.type.intValue == 10 {   // 图片
            imageView.sd_setImage(with: URL(string: data.image0!))
            
        } else if data.type.intValue == 32 {    // 音频
            
        } else if data.type.intValue == 41 {    // 视频
            imageView.sd_setImage(with: URL(string: data.image0!))
            
        }

        
        
    }
}
