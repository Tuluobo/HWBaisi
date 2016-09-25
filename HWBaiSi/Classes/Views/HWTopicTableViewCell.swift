//
//  HWTopicTableViewCell.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/25.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWTopicTableViewCell: UITableViewCell {
    
    var model: HWTopic? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var dingButton: UIButton!
    @IBOutlet weak var caiButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 44.0 / 2.0
        profileImageView.layer.masksToBounds = true
    }

    private func updateUI() {
        profileImageView.image = nil
        screenNameLabel.text = nil
        createTimeLabel.text = nil
        contentLabel.text = nil
        
        guard let data = model else {
            return
        }
        /// 头像
        if let profileImage = data.profile_image {
            profileImageView.sd_setImage(with: URL(string: profileImage), placeholderImage: UIImage(named: "defaultUserIcon"))
        }
        /// 昵称
        if let screen_name = data.screen_name {
            screenNameLabel.text = screen_name
        }
        /// 时间
        if let created_at = data.created_at {
            createTimeLabel.text = created_at
        }
        /// 内容
        if let text = data.text {
            contentLabel.text = text
            contentLabel.frame.size.height = contentLabel.textRect(forBounds: contentLabel.bounds, limitedToNumberOfLines: 0).size.height
        }
        
    }

    @IBAction func clickedMoreBtn() {
        HWLog("")
    }
    
}
