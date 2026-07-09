//
//  String+subString.swift
//  CJUIKitDemo
//
//  Created by qian on 2020/12/15.
//  Copyright © 2020年 dvlproad. All rights reserved.
//

import Foundation

public extension String {
    /// 截取规定下标之后的字符串
    public func subStringFrom(index: Int) -> String {
        let temporaryString: String = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[temporaryIndex...])
    }
    
    /// 截取规定下标之前的字符串
    public func subStringTo(index: Int) -> String {
        let temporaryString = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[...temporaryIndex])
        
    }
}
