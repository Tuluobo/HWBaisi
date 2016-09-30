//
//  Defines.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/12.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

/****** 自定义Log ******/
func HWLog<T>(_ message: T, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
	#if DEBUG
		let filename = (fileName as NSString).pathComponents.last
		print("\(filename!)\(function)[\(lineNumber)]: \(message)")
	#endif
}

let kPhotoCollectionTitle = "BDJ"
let kScreenSize = UIScreen.main.bounds.size
let kScreenWidth = kScreenSize.width
let kScreenHeight = kScreenSize.height

