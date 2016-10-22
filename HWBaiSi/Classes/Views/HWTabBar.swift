//
//  HWTabBar.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/10/19.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWTabBar: UITabBar {
    
    // MARK: - 懒加载
    // + 按钮
    lazy fileprivate var publishBtn: UIButton = {
        let centerBtn = UIButton(type: UIButtonType.custom)
        centerBtn.setImage(UIImage(named: "tabBar_publish_icon")!, for: UIControlState())
        centerBtn.setImage(UIImage(named: "tabBar_publish_click_icon"), for: .selected)
        centerBtn.sizeToFit()
        centerBtn.center = self.convert(self.center, from: self.superview)
        return centerBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundImage = UIImage(named:"tabbar-light")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 自定义
        let buttonW = self.frame.size.width / 5.0
        let buttonH = self.frame.size.height
        // 按钮索引
        var index = 0;
        
        for subview in self.subviews {
            // 过滤掉其他不是UITabBarButton的
            if !subview.isKind(of: NSClassFromString("UITabBarButton")!) {
                continue
            }
            // 设置frame
            var buttonX = CGFloat(index) * buttonW
            // 右边的2个UITabBarButton
            if (index >= 2) {
                buttonX += buttonW
            }
            subview.frame = CGRect(x: buttonX, y: 0, width: buttonW, height: buttonH);
            // 增加索引
            index += 1
        }
        
        // 设置中间的按钮
        self.addSubview(publishBtn)
        publishBtn.addTarget(self, action: #selector(clickedCenterBtn), for: .touchUpInside)
    }
    
    // 点击 + 按钮
    @objc private func clickedCenterBtn() {
        let publishVC = UIStoryboard(name: "Publish", bundle: nil).instantiateInitialViewController()!
        let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarViewController
        tabBarVC.present(publishVC, animated: true, completion: nil)
    }

}
