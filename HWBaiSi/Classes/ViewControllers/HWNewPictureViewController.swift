//
//  HWNewPictureViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/10/22.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWNewPictureViewController: HWTopicViewController, HWTopicViewControllerDataSource {

    internal var listType: String {
        return "newlist"
    }
    
    internal var topicType: Int {
        return 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hwDataSource = self
    }

}
