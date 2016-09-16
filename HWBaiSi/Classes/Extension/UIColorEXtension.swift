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
	
    class var defaultLightGray: UIColor {
		return UIColor(R: 190, G: 190, B: 190)
	}
    
    class var defaultGray: UIColor {
        return UIColor(R: 110, G: 110, B: 110)
    }
	
	class var defaultDrakGray: UIColor {
		return UIColor(R: 81, G: 81, B: 81)
	}
	
	class var defaultRed: UIColor {
		return UIColor(R: 228, G: 46, B: 22)
	}
    
    class var placeTextColor: UIColor {
        return UIColor(colorLiteralRed: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
	
}
