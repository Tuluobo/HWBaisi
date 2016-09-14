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
    lazy fileprivate var publishBtn: UIButton = {
        let centerBtn = UIButton(type: UIButtonType.custom)
        centerBtn.setImage(UIImage(named: "tabBar_publish_icon")!, for: UIControlState())
        centerBtn.setImage(UIImage(named: "tabBar_publish_click_icon"), for: .selected)
        centerBtn.sizeToFit()
        centerBtn.center = self.tabBar.convert(self.tabBar.center, from: self.tabBar.superview)
        return centerBtn
    }()
    
    // MARK: 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景
        self.tabBar.backgroundImage = UIImage(named:"tabbar-light")
        // 插入中间的发布的tab Bar Item，也可以自定义tabBar
        var vcs = self.viewControllers!
        vcs.insert(UIViewController(), at: 2)
        self.setViewControllers(vcs, animated: false)
        self.tabBar.items![2].isEnabled = false
        // 设置中间的按钮
        self.tabBar.addSubview(publishBtn)
        publishBtn.addTarget(self, action: #selector(clickedCenterBtn), for: .touchUpInside)
    }
    
    // MARK: 内部方法
    @objc fileprivate func clickedCenterBtn() {
        let publishVC = UIStoryboard(name: "Publish", bundle: nil).instantiateInitialViewController()!
        self.present(publishVC, animated: true, completion: nil)
    }
}
