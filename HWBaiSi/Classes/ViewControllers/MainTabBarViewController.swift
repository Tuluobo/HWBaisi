//
//  MainTabBarViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
	
	// MARK: 懒加载
	lazy private var publishBtn: UIButton = {
		let centerBtn = UIButton(type: UIButtonType.Custom)
		centerBtn.setImage(UIImage(named: "tabBar_publish_icon")!, forState: .Normal)
		centerBtn.setImage(UIImage(named: "tabBar_publish_click_icon"), forState: .Selected)
		centerBtn.sizeToFit()
		centerBtn.center = self.tabBar.center
		return centerBtn
	}()
	
	// MARK: 生命周期方法
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// 插入中间的发布的tab Bar Item，也可以自定义tabBar
		var vcs = self.viewControllers!
		vcs.insert(UIViewController(), atIndex: 2)
		self.setViewControllers(vcs, animated: false)
		self.tabBar.items![2].enabled = false
		// 设置中间的按钮
		self.view.insertSubview(publishBtn, aboveSubview: self.tabBar)
		publishBtn.addTarget(self, action: #selector(clickedCenterBtn), forControlEvents: .TouchUpInside)
	}
	
	// MARK: 内部方法
	@objc private func clickedCenterBtn() {
		let publishVC = UIStoryboard(name: "Publish", bundle: nil).instantiateInitialViewController()!
		self.presentViewController(publishVC, animated: true, completion: nil)
	}
}
