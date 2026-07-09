//
//  UIDevice+Extension.swift
//  CJUIKitDemo
//
//  Created by qian on 2020/12/15.
//  Copyright © 2020年 dvlproad. All rights reserved.
//
// ============================================================
// 此类请自行拷贝一份到不会被加载进 App Extension 的底层公共子库(如 CommonUI )下来使用。
// 因为：App Extension 中不允许访问 UIApplication.shared。
// 即：App Extension（Widget、Today Extension、Notification Extension 等）运行在沙盒环境中
// 这一份还放在这里的目的是为了让用户了解在做适配的时候有时候还得考虑到各个版本的一些控件尺寸变化问题
// ============================================================
/*
import UIKit
import Foundation

public extension UIDevice {
    /// 是否是 App Extension
    static var cj_isAppExtension: Bool {
        return Bundle.main.bundlePath.hasSuffix(".appex")
    }
    
    /// 顶部导航栏高度
    static let cj_navigationBarHeight: CGFloat = 44.0
    /// 底部导航栏高度
    static let cj_tabBarHeight: CGFloat = 49.0

#if APP_MAINTARGET  // 这里即使你使用条件编译也无效，因为你无法强制让用户这个pod不会有添加给App Extension的情况
    // MARK: 底层方法
    static var cj_firstWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return nil }
            let window = windowScene.windows.first
            return window
            
        } else if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            return window
        }
        return nil;
    }
        
    /// 顶部状态栏高度（包括安全区）
    static var cj_statusBarFrame: CGRect {
        var statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return .zero }
            guard let statusBarManager = windowScene.statusBarManager else { return .zero }
            statusBarFrame = statusBarManager.statusBarFrame
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        return statusBarFrame
    }
    
    // MARK: 简洁方法
//    static func cj_statusBarHeight() -> CGFloat {
//        var statusBarFrame: CGRect = self.cj_statusBarFrame
//        return statusBarFrame.height
//    }
    
    /// 顶部安全区高度
    static var cj_safeTop: CGFloat {
        guard let window = self.cj_firstWindow else { return 0 }
        return window.safeAreaInsets.top
    }
    
    /// 底部安全区高度
    static var cj_safeBottom: CGFloat {
        guard let window = self.cj_firstWindow else { return 0 }
        return window.safeAreaInsets.bottom
    }


    // MARK: 复合方法
    /// 状态栏 + 导航栏总高度
    static var cj_navigationFullHeight: CGFloat = cj_navigationBarHeight + cj_statusBarFrame.height
    
    /// TabBar + 底部安全区总高度
    static var cj_tabBarFullHeight: CGFloat = cj_tabBarHeight + cj_safeBottom
#endif
}
*/
