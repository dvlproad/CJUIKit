//
//  UIColor+CJHex.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//


/**
 *  1.返回一个RGBA格式的UIColor对象
 */
func CJColorFromRGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}

/// 一个随机颜色
func CJColorRandom() -> UIColor
{
    let r : CGFloat = CGFloat(arc4random_uniform(256))
    let g : CGFloat = CGFloat(arc4random_uniform(256))
    let b : CGFloat = CGFloat(arc4random_uniform(256))
    return CJColorFromRGBA(r: r, g: g, b: b, a: 1.0)
}

/// hexValueColor
func CJColorFromHexValue(_ hexValueColor: NSInteger) -> UIColor
{
    let r : CGFloat = CGFloat((hexValueColor & 0xFF0000) >> 16)
    let g : CGFloat = CGFloat((hexValueColor & 0xFF00) >> 8)
    let b : CGFloat = CGFloat(hexValueColor & 0xFF)
    return CJColorFromRGBA(r: r, g: g, b: b, a: 1.0)
}

/**
 *  2.支持使用16进制数值/字符串来选取颜色
 */
func CJColorFromHexString(_ hexStringColor:String) -> UIColor
{
    return CJColorFromHexString(hexStringColor, 1.0)
}

func CJColorFromHexString(_ hexStringColor:String, _ alpha:CGFloat) -> UIColor
{
    return UIColor.cjColor(hexStringColor: hexStringColor, alpha: alpha)
}



extension UIColor {
    /**
     *  初始化颜色(从十六进制字符串获取颜色)
     *
     *  @param hexStringColor   颜色的值（支持@“#123456”、 @“0X123456”、 @“123456”三种格式）
     *  @param alpha            alpha
     *
     *  return  颜色
     */
    class func cjColor(hexStringColor: String, alpha: CGFloat) -> UIColor {
        //删除字符串中的空格
        var cString: String = hexStringColor.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // String should be 6 or 8 characters
        if cString.count < 6 {
            return UIColor.clear
        }
        // strip 0X if it appears
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if cString.hasPrefix("0X") {
            let index = cString.index(cString.startIndex, offsetBy:2)
            let cString2 = cString[index..<cString.endIndex]
            cString = String(cString2)
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy:1)
            let cString2 = cString[index..<cString.endIndex]
            cString = String(cString2)
        }
        if cString.count != 6 {
            return UIColor.clear
        }
        // Separate into r, g, b substrings
        //r
        let rStartIndex = cString.index(cString.startIndex, offsetBy:1)
        let rEndIndex = cString.index(cString.startIndex, offsetBy:2)
        let rString: String = String(cString[rStartIndex..<rEndIndex])
        //g
        let gStartIndex = cString.index(cString.startIndex, offsetBy:3)
        let gEndIndex = cString.index(cString.startIndex, offsetBy:4)
        let gString: String = String(cString[gStartIndex..<gEndIndex])
        //b
        let bStartIndex = cString.index(cString.startIndex, offsetBy:5)
        let bEndIndex = cString.index(cString.startIndex, offsetBy:6)
        let bString: String = String(cString[bStartIndex..<bEndIndex])
        // Scan values
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        let hexColor = UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
        
        return hexColor
    }
}
