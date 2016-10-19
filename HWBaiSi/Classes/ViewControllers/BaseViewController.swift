//
//  BaseViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let model = (UIApplication.shared.delegate as! AppDelegate).nightMode
        return model ? .lightContent : .default
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
        // 设置通用背景颜色
		self.view.backgroundColor = UIColor.hw_lightGray
	}
    
}
