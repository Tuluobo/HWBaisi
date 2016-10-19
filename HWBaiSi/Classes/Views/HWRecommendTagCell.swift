//
//  HWRecommendTagCell.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import SDWebImage

class HWRecommendTagCell: UITableViewCell {

    var tagModel: HWRecommendTag? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagTitleLabel: UILabel!
    @IBOutlet weak var tagDetailLabel: UILabel!
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.size.height -= 1
            super.frame = newFrame
        }
    }

    private func updateUI() {
        tagImageView.image = nil
        tagTitleLabel.text = nil
        tagDetailLabel.text = nil
        guard let data = tagModel else { return }
        if let urlStr = data.image_list {
            tagImageView.sd_setImage(with: URL(string: urlStr), placeholderImage: UIImage(named: "defaultUserIcon")!.hw_circleImage(), options: [], completed: { (image, error, _, _) in
                if let img = image {
                    self.tagImageView.image = img.hw_circleImage()
                }
            })
        }
        tagTitleLabel.text = data.theme_name
        if let number = data.sub_number {
            if number.intValue > 10000 {
                tagDetailLabel.text = String(format: "%.2f万人订阅", number.floatValue / 10000.0)
            } else {
               tagDetailLabel.text = String(format: "%d人订阅", number.intValue)
            }
        }
    }
    
    @IBAction func clickedAttentionBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setTitleColor(UIColor.hw_gray, for: .normal)
            sender.setTitle("已订阅", for: .normal)
        } else {
            sender.setTitleColor(UIColor.red, for: .normal)
            sender.setTitle("+ 订阅", for: .normal)
        }
        
    }
}
