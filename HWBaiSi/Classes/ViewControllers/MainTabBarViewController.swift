//
//  MainTabBarViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
	
	lazy private var centerBtn: UIButton = {
		let image = UIImage(named: "tabBar_publish_icon")!
		let centerBtn = UIButton(type: UIButtonType.Custom)
		centerBtn.setImage(image, forState: .Normal)
		centerBtn.setImage(UIImage(named: "tabBar_publish_click_icon"), forState: .Selected)
		centerBtn.frame.size = image.size
		centerBtn.center = self.tabBar.center
		return centerBtn
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// 插入中间的tab Bar Item
		var vcs = self.viewControllers!
		vcs.insert(UIViewController(), atIndex: 2)
		self.setViewControllers(vcs, animated: false)
		// 设置中间的按钮
		self.view.insertSubview(centerBtn, aboveSubview: self.tabBar)
		centerBtn.addTarget(self, action: #selector(clickedCenterBtn), forControlEvents: .TouchUpInside)
	}
	
	func clickedCenterBtn() {
		let publishVC = UIStoryboard(name: "Publish", bundle: nil).instantiateInitialViewController()!
		self.presentViewController(publishVC, animated: true, completion: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
