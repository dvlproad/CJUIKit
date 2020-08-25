//
//  NSClassFromStringCJHelper.swift
//  TSOverlayDemo_Swift
//
//  Created by 李超前 on 2020/8/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import UIKit

//[Swift中关于NSClassFromString获取不到类](https://www.jianshu.com/p/bb4ddb63d709)
class NSClassFromStringCJHelper: NSObject {
    // className:想要转换类名的字符串
    class func controllerFormString(className: String, isOC:Bool = false, nameSpace: String = "") -> UIViewController{
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
        guard let vcCls = anyCls as? UIViewController.Type else {
            //fatalError("转换失败")
            return UIViewController.init();
        }
        
        // 通过Class创建对象
        return vcCls.init();
    }
}
