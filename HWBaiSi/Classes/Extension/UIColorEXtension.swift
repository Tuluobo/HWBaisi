//
//  UIColorEXtension.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/12.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

extension UIColor {
	
	convenience init(R: Int, G: Int, B: Int) {
		self.init(red: CGFloat(R) / 255.0, green: CGFloat(G) / 255.0, blue: CGFloat(B) / 255.0, alpha: 1.0)
	}
	
	convenience init(R: Int, G: Int, B: Int, A: Int) {
		self.init(red: CGFloat(R) / 255.0, green: CGFloat(G) / 255.0, blue: CGFloat(B) / 255.0, alpha: CGFloat(A) / 255.0)
	}
	
	class func defaultGray() -> UIColor {
		return UIColor(R: 206, G: 206, B: 206)
	}
	
	class func defaultDrakGray() -> UIColor {
		return UIColor(R: 81, G: 81, B: 81)
	}
	
	class func defaultRed() -> UIColor {
		return UIColor(R: 228, G: 46, B: 22)
	}
	
}
