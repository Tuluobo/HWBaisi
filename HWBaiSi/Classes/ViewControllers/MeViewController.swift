//
//  MeViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {
	
    @IBOutlet weak var nightModeBtn: UIBarButtonItem!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "我"
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
    @IBAction func clickedNightModeBtn(_ sender: AnyObject) {
    }
}
