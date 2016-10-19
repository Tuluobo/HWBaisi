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
    
    class var hw_randomColor: UIColor {
        let r = arc4random_uniform(255)
        let g = arc4random_uniform(255)
        let b = arc4random_uniform(255)
        return UIColor(R: Int(r), G: Int(g), B: Int(b))
    }
	
    class var hw_lightGray: UIColor {
		return UIColor(R: 243, G: 243, B: 243)
	}
    
    class var hw_gray: UIColor {
        return UIColor(R: 39, G: 39, B: 39)
    }
	
	class var hw_drakGray: UIColor {
		return UIColor(R: 26, G: 26, B: 26)
	}
	
	class var hw_red: UIColor {
		return UIColor(R: 255, G: 26, B: 85)
	}
    
    class var hw_placeTextColor: UIColor {
        return UIColor(colorLiteralRed: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
	
}
