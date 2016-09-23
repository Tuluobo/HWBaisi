//
//  HWConetentTableViewCell.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

// MARK: tableView 中的 Cell
class HWConetentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    var model: String? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        contentLabel.text = nil
        guard let data = model else { return }
        contentLabel.text = data
    }
    
}
