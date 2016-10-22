//
//  HWNewAllViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/10/22.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWNewAllViewController: HWTopicViewController, HWTopicViewControllerDataSource {
    internal var listType: String {
        return "newlist"
    }
    
    internal var topicType: Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hwDataSource = self
    }

}
