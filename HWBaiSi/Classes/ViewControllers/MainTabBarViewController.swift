//
//  MainTabBarViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景
        self.tabBar.backgroundImage = UIImage(named:"tabbar-light")
        // 设置viewController
        setupChildViewControllers()
        // 设置自定义tabBar
        self.setValue(HWTabBar(), forKey: "tabBar")
    }
    
    // MARK: - 内部方法
    // 设置子控制器
    private func setupChildViewControllers() {
        layoutViewController(storyboardName:"TopicCollection", title:"精华", imageName:"tabBar_essence_icon", selectedImageName:"tabBar_essence_click_icon")
        layoutViewController(storyboardName:"TopicCollection", title:"新帖", imageName:"tabBar_new_icon", selectedImageName:"tabBar_new_click_icon")
        layoutViewController(storyboardName:"FriendTrends", title:"关注", imageName:"tabBar_friendTrends_icon", selectedImageName:"tabBar_friendTrends_click_icon")
        layoutViewController(storyboardName:"Me", title:"我", imageName:"tabBar_me_icon", selectedImageName:"tabBar_me_click_icon")
    }
    
    // 布局单个子控制器
    private func layoutViewController(storyboardName: String, title:String, imageName: String, selectedImageName: String) {
        let navVC = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = UIImage(named:imageName)
        navVC.tabBarItem.selectedImage = UIImage(named:selectedImageName)
        self.addChildViewController(navVC)
    }
}
