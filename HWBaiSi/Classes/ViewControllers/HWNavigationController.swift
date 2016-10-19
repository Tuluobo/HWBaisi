//
//  HWNavigationController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/14.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 右滑返回代理
        self.interactivePopGestureRecognizer?.delegate = self
        // 设置背景
        self.navigationBar.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), for: UIBarMetrics.default)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 设置通用返回按钮
        let btn = UIButton(type: .custom)
        btn.setTitle("返回", for: .normal)
        btn.setImage(UIImage(named: "navigationButtonReturn"), for: .normal)
        btn.setImage(UIImage(named: "navigationButtonReturnClick"), for: .highlighted)
        btn.setTitleColor(UIColor.hw_drakGray, for: .normal)
        btn.setTitleColor(UIColor.hw_red, for: .highlighted)
        btn.sizeToFit()
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        btn.addTarget(self, action: #selector(clickedBackBtn), for: .touchUpInside)
        // 添加左边按钮
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func clickedBackBtn() {
        self.popViewController(animated: true)
    }

}

// MARK: 代理：UIGestureRecognizerDelegate
extension HWNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count > 1
    }
}
