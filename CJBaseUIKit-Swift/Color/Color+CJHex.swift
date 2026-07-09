//
//  Color+CJHex.swift
//  CJUIKitDemo
//
//  Created by qian on 2024/12/15.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public extension Color {
    static public var randomColor: Color {
        let red = Double(arc4random() % 256 ) / 255.0
        let green = Double(arc4random() % 256) / 255.0
        let blue = Double(arc4random() % 256) / 255.0
        return Color(red: red, green: green, blue: blue)
    }
    
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    public func toHex(includeAlpha: Bool = false) -> String? {
        // 将Color转换为UIColor
        let uiColor: UIColor
        
        if #available(iOS 14.0, *) {
            uiColor = UIColor(self)
        } else {
            // iOS 13 需要使用 UIColor(red:green:blue:alpha:)
            // 但无法直接从 Color 获取 RGB 值
            // 建议直接使用 UIColor 扩展，而不是从 Color 转换
            return nil
        }
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // 尝试获取颜色的RGBA值
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            // 如果无法获取，返回nil
            return nil
        }
        if(red > 1){
            red = 1
        }else if(red < 0){
            red = 0
        }
        if(green > 1){
            green = 1
        }else if(green < 0){
            green = 0
        }
        if(blue > 1){
            blue = 1
        }else if(blue < 0){
            blue = 0
        }
        //print("颜色值ARGB：\(alpha)==\(red)==\(green)==\(blue)")
        // 根据是否包含透明度来决定格式化字符串
        if includeAlpha {
            // 将RGBA值转换为十六进制字符串，包括透明度
            return String(format: "#%02X%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
        } else {
            // 将RGB值转换为十六进制字符串
            return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
        }
    }
}
