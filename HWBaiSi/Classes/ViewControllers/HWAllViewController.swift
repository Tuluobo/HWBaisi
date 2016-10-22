//
//  HWAllViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/24.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWAllViewController: HWTopicViewController, HWTopicViewControllerDataSource {
    
    internal var listType: String {
        return "list"
    }

    internal var topicType: Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hwDataSource = self
    }
}
