//
//  HWTopicImageView.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/28.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import AFNetworking
import DACircularProgress

class HWTopicImageView: UIView {
    
    var topicModel: HWTopic? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        progressView.progressLabel.textColor = UIColor.white
        progressView.roundedCorners = 5
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(browsePicture)))
    }
    
    override var frame: CGRect {
        didSet {
            if let data = topicModel {
                super.frame = data.mediaFrame
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gitTagImageView: UIImageView!
    @IBOutlet weak var videoStartBtn: UIButton!
    @IBOutlet weak var openBigPictureBtn: UIButton!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var placeholderImageView: UIImageView!
    @IBOutlet weak var progressView: DALabeledCircularProgressView!
    
    @objc private func browsePicture() {
        if topicModel?.type.intValue != 10 {
            return
        }
        let browseVC = UIStoryboard(name: "PictureBrowse", bundle: nil).instantiateInitialViewController() as! HWPictureBrowseViewController
        browseVC.model = topicModel
        self.window?.rootViewController?.present(browseVC, animated: true, completion: nil)
    }
    
    private func updateUI() {
        imageView.image = nil
        videoStartBtn.isHidden = true
        openBigPictureBtn.isHidden = true
        playCountLabel.isHidden = true
        playTimeLabel.isHidden = true
        placeholderImageView.isHidden = false
        progressView.isHidden = true

        guard let data = topicModel else { return }
        
        self.frame = data.mediaFrame
        gitTagImageView.isHidden = !data.is_gif.boolValue
        
        progressView.isHidden = false
        progressView.progress = 0
        
        switch AFNetworkReachabilityManager.shared().networkReachabilityStatus {
        case .reachableViaWWAN:
            setImageView(imageName: data.image0!, type: data.type)
        case .reachableViaWiFi:
            setImageView(imageName: data.image1!, type: data.type)
        default:
            setImageView(imageName: data.image2!, type: data.type)
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
        if data.type.intValue == 31 {           // 音频
            playCountLabel.isHidden = false
            playCountLabel.text = data.playcount
            playTimeLabel.isHidden = false
            playTimeLabel.text = data.voicetime
            videoStartBtn.setImage(UIImage(named:"playButtonPlay"), for: .normal)
            videoStartBtn.setBackgroundImage(UIImage(named:"playButton"), for: .normal)
            videoStartBtn.setBackgroundImage(UIImage(named:"playButtonClick"), for: .highlighted)
        } else if data.type.intValue == 41 {    // 视频
            playCountLabel.isHidden = false
            playCountLabel.text = data.playcount
            playTimeLabel.isHidden = false
            playTimeLabel.text = data.videotime
            videoStartBtn.setImage(UIImage(named:"video-play"), for: .normal)
            videoStartBtn.setBackgroundImage(nil, for: .normal)
            videoStartBtn.setBackgroundImage(nil, for: .highlighted)
        }
    }
    
    private func setImageView(imageName: String, type:NSNumber) {
        imageView.sd_setImage(with: URL(string: imageName), placeholderImage: nil, options: [], progress: { (receivedSize, totalSize)  in
            let progress = CGFloat(receivedSize)/CGFloat(totalSize)
            self.progressView.setProgress(progress, animated: true)
            self.progressView.progressLabel.text = "\(Int(progress*100))%"
            }, completed: {  (_, error, _, _)  in
                self.placeholderImageView.isHidden = true
                self.progressView.isHidden = true
                if type.intValue == 31 || type.intValue == 41 {
                    self.videoStartBtn.isHidden = false
                }
                
        })
    }
}
