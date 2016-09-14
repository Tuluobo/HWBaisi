//
//  BaseViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.defaultGray()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let btn = UIButton(type: .custom)
		btn.setTitle("返回", for: UIControlState())
		btn.setTitle("返回", for: .highlighted)
		btn.setImage(UIImage(named: "navigationButtonReturn"), for: UIControlState())
		btn.setImage(UIImage(named: "navigationButtonReturnClick"), for: .highlighted)
		btn.setTitleColor(UIColor.defaultDrakGray(), for: UIControlState())
		btn.setTitleColor(UIColor.defaultRed(), for: .highlighted)
		self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: btn)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}
