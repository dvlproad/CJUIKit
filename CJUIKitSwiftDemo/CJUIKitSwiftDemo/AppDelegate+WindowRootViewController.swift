//
//  AppDelegate+WindowRootViewController.swift
//  CJUIKitSwiftDemo
//
//  Created by 李超前 on 2019/4/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

import UIKit
import Foundation

//#import "HomeViewController.h"
//#import "FoundationHomeViewController.h"
//#import "UtilHomeViewController.h"
//#import "HelperHomeViewController.h"
//#import "MoreHomeViewController.h"

extension AppDelegate {
    func getMainRootViewController() -> UIViewController? {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundImage = UIImage(named: "tabbar_BG")
        
        /*
         知识点(UITabBarController):
         ①设置标题tabBarItem.title：为了使得tabBarItem中的title可以和显示在顶部的navigationItem的title保持各自，分别设置.tabBarItem.title和.navigationItem的title的值
         ②设置图片tabBarItem.image：会默认去掉图片的颜色，如果要看到原图片，需要设置图片的渲染模式为UIImageRenderingModeAlwaysOriginal
         ③设置角标tabBarItem.badgeValue：如果没有设置图片，角标默认显示在左上角，设置了图片就会在图片的右上角显示
         */
        let homeViewController = ViewController()
        homeViewController.view.backgroundColor = UIColor.white
        homeViewController.navigationItem.title = NSLocalizedString("CJBaseUIKit首页", comment: "")
        homeViewController.tabBarItem.title = NSLocalizedString("CJBaseUIKit", comment: "")
        homeViewController.tabBarItem.image = UIImage(named: "icons8-home")?.withRenderingMode(.alwaysOriginal)
        //homeViewController. = @"10";
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        tabBarController.addChild(homeNavigationController)
        
        let foundationHomeViewController = ViewController()
        foundationHomeViewController.view.backgroundColor = UIColor.white
        foundationHomeViewController.navigationItem.title = NSLocalizedString("Foundation首页", comment: "")
        foundationHomeViewController.tabBarItem.title = NSLocalizedString("CJFoundataion", comment: "")
        foundationHomeViewController.tabBarItem.image = UIImage(named: "icons8-settings")?.withRenderingMode(.alwaysOriginal)
        let foundationHomeNavigationController = UINavigationController(rootViewController: foundationHomeViewController)
        tabBarController.addChild(foundationHomeNavigationController)
        
        let helperHomeViewController = ViewController()
        helperHomeViewController.view.backgroundColor = UIColor.white
        helperHomeViewController.navigationItem.title = NSLocalizedString("CJHelper首页", comment: "")
        helperHomeViewController.tabBarItem.title = NSLocalizedString("CJHelper", comment: "")
        helperHomeViewController.tabBarItem.image = UIImage(named: "icons8-settings")?.withRenderingMode(.alwaysOriginal)
        let helperHomeNavigationController = UINavigationController(rootViewController: helperHomeViewController)
        tabBarController.addChild(helperHomeNavigationController)
        
        let utilHomeViewController = ViewController();
        utilHomeViewController.view.backgroundColor = UIColor.white;
        utilHomeViewController.navigationItem.title = NSLocalizedString("Util首页", comment: "")
        utilHomeViewController.tabBarItem.title = NSLocalizedString("CJUtil", comment: "")
        utilHomeViewController.tabBarItem.image = UIImage(named: "icons8-settings")?.withRenderingMode(.alwaysOriginal)
        let utilHomeNavigationController = UINavigationController(rootViewController: utilHomeViewController)
        tabBarController.addChild(utilHomeNavigationController)
        
        
        let moreHomeViewController = ViewController();
        moreHomeViewController.view.backgroundColor = UIColor.white;
        moreHomeViewController.navigationItem.title = NSLocalizedString("更多", comment: "")
        moreHomeViewController.tabBarItem.title = NSLocalizedString("更多", comment: "")
        moreHomeViewController.tabBarItem.image = UIImage(named: "icons8-settings")?.withRenderingMode(.alwaysOriginal)
        let moreHomeNavigationController = UINavigationController(rootViewController: moreHomeViewController)
        tabBarController.addChild(moreHomeNavigationController)
        
        
        //    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController, navigationController3, navigationController4] animated:YES];
        
        return tabBarController
    }
}
