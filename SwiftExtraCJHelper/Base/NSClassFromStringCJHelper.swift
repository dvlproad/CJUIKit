//
//  NSClassFromStringCJHelper.swift
//  TSOverlayDemo_Swift
//
//  Created by ciyouzen on 2020/8/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  let anyCls: AnyClass? = NSClassFromStringCJHelper.swiftClass(from: <#T##String#>, nameSpace: <#T##String#>)
//  let anyCls: AnyClass? = NSClassFromStringCJHelper.ocClass(from: <#T##String#>)

import UIKit

//[Swift中关于NSClassFromString获取不到类](https://www.jianshu.com/p/bb4ddb63d709)
@objc public class NSClassFromStringCJHelper: NSObject {
    /// 获取 swift 的 类
    @objc public class func swiftClass(from className: String, nameSpace: String) -> AnyClass?{
        return self.classFromString(className, isOC: false, nameSpace: nameSpace)
    }
    
    @objc public class func ocClass(from className: String) -> AnyClass?{
        return self.classFromString(className, isOC: true, nameSpace: "")
    }
    
    // className:想要转换类名的字符串
    // isOC:是否是OC写的类，默认是false
    private class func classFromString(_ className: String, isOC:Bool = false, nameSpace: String) -> AnyClass?{
        var lastClassName : String!
        
        if isOC {
            // 当Swift中调用OC写的类
            lastClassName = className
        } else {
            // 当Swift中调用Swift写的类，因为Swift类现在是命名空间，因此它不是“MyViewController”而是“AppName.MyViewController”
            //这个特别需要注意一点的是如果你的包名中有'-'横线这样的字符，在拿到包名后，还需要把包名的'-'转换成'_'下横线，这点特别坑(折腾了半天才找到原因😤)
            var lastNameSpace : String = nameSpace;
            if nameSpace.count > 0 {
                lastNameSpace = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as! String
                lastNameSpace = nameSpace.replacingOccurrences(of: "-", with: "_")
            }
            lastClassName = lastNameSpace + "." + className
        }
        
        // 将字符串转换成类
        // (由于NSClassFromString返回的是AnyClass,但在swift中要想通过Class创建一个对象,必须告诉系统Class的类型,所以我们转换成UIViewController.Type类型)
        let anyCls: AnyClass? = NSClassFromString(lastClassName)
//        if let vcCls = anyCls as? UIViewController.Type
        
        return anyCls
    }
}
