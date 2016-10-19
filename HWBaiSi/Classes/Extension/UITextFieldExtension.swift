//
//  UITextFieldExtension.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/15.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

fileprivate let kUITextFieldPlaceholderColorKey = "placeholderLabel.textColor"

extension UITextField {
    
    var hw_placeholderColor: UIColor? {
        set {
            // 使 UITextField 创建 placeholderLabel
            let oldPlaceholder = self.placeholder
            self.placeholder = " "
            self.placeholder = oldPlaceholder
            // 设置颜色
            var color = newValue
            if color == nil {
                color = UIColor.hw_placeTextColor
            }
            self.setValue(color, forKeyPath: kUITextFieldPlaceholderColorKey)
        }
        get {
            return self.value(forKeyPath: kUITextFieldPlaceholderColorKey) as? UIColor
        }
    }
    
}
