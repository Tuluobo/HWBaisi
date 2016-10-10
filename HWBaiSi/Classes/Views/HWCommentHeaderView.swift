//
//  HWCommentHeaderView.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/10/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWCommentHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.defaultLightGray
        self.textLabel?.textColor = UIColor.defaultGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
    }

}
