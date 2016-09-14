//
//  EssenceViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class EssenceViewController: BaseViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    @IBAction func clickedNaviLeftBtn() {
    }
    
}
