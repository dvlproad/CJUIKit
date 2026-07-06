//
//  Bundle+InFramework.swift
//  CJBaseUtil-Swift
//
//  Created by ciyouzen on 2020/8/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import Foundation

@objc public extension Bundle {
    // 方法一：不需要循环(从指定OC类所在的 framework 中取出 resource bundle)
    @objc public static func frameworkResourceBundle(_ bundleName: String, ocClassName: String) -> Bundle? {
        guard let frameworkClass = NSClassFromString(ocClassName) else { return nil }
        
        let frameworkBundle = Bundle(for: frameworkClass)
        guard let bundleURL = frameworkBundle.url(forResource: bundleName, withExtension: "bundle") else { return nil }
        
        let resourceBundle = Bundle(url: bundleURL)
        return resourceBundle
    }
    
    // 方法一：不需要循环(从指定Swift类所在的 framework 中取出 resource bundle)
    @objc public static func frameworkResourceBundle(_ bundleName: String, swiftClassName: String, nameSpace: String) -> Bundle? {
        guard let frameworkClass = NSFrameworkClassFromString(swiftClassName, nameSpace: nameSpace) else { return nil }
        
        let frameworkBundle = Bundle(for: frameworkClass)
        guard let bundleURL = frameworkBundle.url(forResource: bundleName, withExtension: "bundle") else { return nil }
        
        let resourceBundle = Bundle(url: bundleURL)
        return resourceBundle
    }
    
    // 方法二：需要循环
    @objc public static func frameworkResourceBundle(_ bundleName: String) -> Bundle? {
        // Search all loaded bundles first (e.g., directly embedded .bundle)
        var resourceBundle: Bundle? = Bundle.allBundles.first { $0.bundleURL.lastPathComponent == "\(bundleName).bundle" }
        // Search inside each framework for resource bundles (use_frameworks! case)
        if resourceBundle == nil {
            for frameworkBundle in Bundle.allFrameworks {
                if let bundleURL = frameworkBundle.url(forResource: bundleName, withExtension: "bundle"),
                   let found = Bundle(url: bundleURL) {
                    resourceBundle = found
                    break
                }
            }
        }
        
        return resourceBundle
    }
}
