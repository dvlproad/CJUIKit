//
//  DateExtension.swift
//  CJFoundation-Swift
//
//  Created by ciyouzen on 2020/8/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import Foundation

public struct DateUtil {
    @discardableResult
    public static func xx_dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

class TestSwift3: NSObject {
    func test() {
        CJFoundation_Swift.DateUtil.xx_dateToString(date: Date())
//        CJFoundation_Swift.DateUtil.xx_dateToString(date: Date())
//        let str = CJFoundation_Swift.DateUtil.xx_dateToString(date: Date())
//        print(str)
    }
}
