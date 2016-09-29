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
        imageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(browsePicture)))
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
        let browseVC = HWPictureBrowseViewController()
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
            imageView.sd_setImage(with: URL(string: data.image0!), placeholderImage: nil, options: [], progress: { (receivedSize, totalSize)  in
                    let progress = CGFloat(receivedSize)/CGFloat(totalSize)
                    self.progressView.setProgress(progress, animated: true)
                    self.progressView.progressLabel.text = "\(Int(progress*100))%"
                }, completed: {  (_, error, _, _)  in
                    self.placeholderImageView.isHidden = true
                    self.progressView.isHidden = true
            })
        case .reachableViaWiFi:
            imageView.sd_setImage(with: URL(string: data.image1!), placeholderImage: nil, options: [], progress: { (receivedSize, totalSize)  in
                    let progress = CGFloat(receivedSize)/CGFloat(totalSize)
                    self.progressView.setProgress(progress, animated: true)
                    self.progressView.progressLabel.text = "\(Int(progress*100))%"
                }, completed: {  (_, error, _, _)  in
                    self.placeholderImageView.isHidden = true
                    self.progressView.isHidden = true
            })

        default:
            imageView.sd_setImage(with: URL(string: data.image2!), placeholderImage: nil, options: [], progress: { (receivedSize, totalSize)  in
                    let progress = CGFloat(receivedSize)/CGFloat(totalSize)
                    self.progressView.setProgress(progress, animated: true)
                    self.progressView.progressLabel.text = "\(Int(progress*100))%"
                }, completed: {  (_, error, _, _)  in
                    self.placeholderImageView.isHidden = true
                    self.progressView.isHidden = true
            })

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
        if data.type.intValue == 31 {    // 音频
            playCountLabel.isHidden = false
            playCountLabel.text = data.playcount
            playTimeLabel.isHidden = false
            playTimeLabel.text = data.voicetime
            videoStartBtn.isHidden = false
            videoStartBtn.setImage(UIImage(named:"playButtonPlay"), for: .normal)
            videoStartBtn.setBackgroundImage(UIImage(named:"playButton"), for: .normal)
            videoStartBtn.setBackgroundImage(UIImage(named:"playButtonClick"), for: .highlighted)
        } else if data.type.intValue == 41 {    // 视频
            playCountLabel.isHidden = false
            playCountLabel.text = data.playcount
            playTimeLabel.isHidden = false
            playTimeLabel.text = data.videotime
            videoStartBtn.isHidden = false
            videoStartBtn.setImage(UIImage(named:"video-play"), for: .normal)
            videoStartBtn.setBackgroundImage(nil, for: .normal)
            videoStartBtn.setBackgroundImage(nil, for: .highlighted)
        }   
    }
}
