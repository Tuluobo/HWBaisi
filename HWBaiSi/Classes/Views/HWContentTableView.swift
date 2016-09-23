//
//  HWContentTableView.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWContentTableView: UITableView {

    var contentModels = [String]()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
        self.loadData()
    }
    
    private func loadData() {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2.0)
            for i in 0..<100 {
                self.contentModels.append("第\(i)个Content Cell")
            }
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

}
