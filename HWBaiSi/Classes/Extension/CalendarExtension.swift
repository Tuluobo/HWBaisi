//
//  CalendarExtension.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/26.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import Foundation

extension Calendar {
    
    static var hw_calendar: Calendar {
        let calendar: Calendar
        if #available(iOS 8.0, *) {
            calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        } else {
            calendar = Calendar.current
        }
        return calendar
    }
    
}
