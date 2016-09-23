//
//  HWRecommendTagCell.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWRecommendTagCell: UITableViewCell {

    var tagModel: HWRecommendTag? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagTitleLabel: UILabel!
    @IBOutlet weak var tagDetailLabel: UILabel!

    @IBAction func clickedAttentionBtn(_ sender: AnyObject) {
    }
    
    private func updateUI() {
        tagImageView.image = nil
        tagTitleLabel.text = nil
        tagDetailLabel.text = nil
        guard let data = tagModel else { return }
        if let urlStr = data.image_list {
            tagImageView.sd_setImage(with: URL(string: urlStr))
        }
        tagTitleLabel.text = data.theme_name
        if let number = data.sub_number {
            tagDetailLabel.text = String(format: "%.2f万人订阅", Float(number)! / 10000.0)
        }
    }
}
