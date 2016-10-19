//
//  UIImageExtension.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/30.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func hw_circleImage(named: String) -> UIImage {
        return UIImage(named: named)!.hw_circleImage()
    }
    
    func hw_circleImage() -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        ctx?.addEllipse(in: rect)
        ctx?.clip()
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
