//
//  HWCommentTableViewCell.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/10/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWCommentTableViewCell: UITableViewCell {
        
    var comment: HWComment? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var voiceComment: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundView = UIImageView(image: UIImage(named:"mainCellBackground"))
    }
    
    private func updateUI() {
        commentLabel.isHidden = true
        voiceComment.isHidden = true
        nickNameLabel.text = nil
        likeNumberLabel.text = nil
        
        guard let model = comment else {
            return
        }
        // 头像
        profileImageView.sd_setImage(with: URL(string: model.user.profile_image ?? ""), placeholderImage: UIImage(named: "defaultUserIcon")!.hw_circleImage(), options: [], completed: { (image, error, _, _) in
            if let img = image {
                self.profileImageView.image = img.hw_circleImage()
            }
        })
        // 性别
        if model.user.sex == "f" {
            genderImageView.image = UIImage(named:"Profile_womanIcon")
        } else {
            genderImageView.image = UIImage(named:"Profile_manIcon")
        }
        // 昵称
        nickNameLabel.text = model.user.username
        // 评论内容
        if model.voiceuri.hasPrefix("http") {
            voiceComment.isHidden = false
            voiceComment.setTitle(String(format:"%d\"", model.voicetime!.intValue), for: .normal)
        } else {
            commentLabel.text = model.content
            commentLabel.isHidden = false
        }
        // 喜欢的数
        likeNumberLabel.text = model.like_count.stringValue
        
    }
    
    @IBAction func clickedLikeBtn() {
        guard let model = comment else {
            return
        }
        likeBtn.isSelected = !likeBtn.isSelected
        var likeCount = model.like_count.intValue
        // TODO: 这里需要与服务器通信
        if likeBtn.isSelected {
            likeCount += 1
        } else {
            likeCount -= 1
        }
        model.like_count = NSNumber(value: likeCount)
        likeNumberLabel.text = model.like_count.stringValue
    }
}

