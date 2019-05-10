//
//  CJAlert.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

import UIKit

class CJAlert: NSObject {
    // MARK: - UIAlertController
    /// 显示系统AlertType弹框
    func showSystemAlert(title: String,
                         message: String,
                         alertActions:[UIAlertAction],
                         in viewController: UIViewController)
    {
        self.showAlertController(preferredStyle: .alert, title: title, message: message, alertActions: alertActions, in: viewController)
    }
    
    /// 显示系统SheetType弹框
    func showSystemSheet(title: String,
                         message: String,
                         alertActions:[UIAlertAction],
                         in viewController: UIViewController)
    {
        self.showAlertController(preferredStyle: .actionSheet, title: title, message: message, alertActions: alertActions, in: viewController)
    }
    
    func showAlertController(preferredStyle: UIAlertController.Style,
                             title: String,
                             message: String,
                             alertActions:[UIAlertAction],
                             in viewController: UIViewController)
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for alertAction in alertActions {
            alertController.addAction(alertAction)
        }
        viewController.present(alertController, animated: true, completion: nil)

    }
    
    
    // MARK: - CJAlertView
    /// 显示 title + message + 我知道了
    class func showIKnowAlert(title: String,
                              message: String,
                              okHandle: (()->())?)
    {
        let okButtonTitle: String = NSLocalizedString("我知道了", comment: "我知道了")
        self.showAlertView(flagImage: nil, title: title, message: message, cancelButtonTitle: nil, okButtonTitle: okButtonTitle, cancelHandle: nil, okHandle: okHandle)
    }

    /// 显示 flagImage + title + message + 我知道了
    class func showIKnowAlert(flagImage: UIImage,
                              title: String,
                              message: String,
                              okHandle: (()->())?)
    {
        let okButtonTitle: String = NSLocalizedString("我知道了", comment: "我知道了")
        self.showAlertView(flagImage: flagImage, title: title, message: message, cancelButtonTitle: nil, okButtonTitle: okButtonTitle, cancelHandle: nil, okHandle: okHandle)
    }

    /// 显示 title + 取消 + 确定
    class func showCancelOKAlert(title: String,
                                 message: String,
                                 cancelHandle:(()->())?,
                                 okHandle: (()->())?)
    {
        let cancelButtonTitle: String = NSLocalizedString("取消", comment: "取消")
        let okButtonTitle: String = NSLocalizedString("确定", comment: "确定")

        self.showAlertView(flagImage: nil, title: title, message: message, cancelButtonTitle: cancelButtonTitle, okButtonTitle: okButtonTitle, cancelHandle: cancelHandle, okHandle: okHandle)
    }

    class func showAlertView(flagImage: UIImage!,
                             title: String,
                             message: String,
                             cancelButtonTitle: String!,
                             okButtonTitle: String,
                             cancelHandle:(()->())?,
                             okHandle: (()->())!)
    {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let popupViewSize: CGSize = CGSize(width: screenWidth*0.7, height: 200)
        let alertView: CJAlertView = CJAlertView.alertViewWithSize(size: popupViewSize, flagImage: flagImage, title: title, message: message, cancelButtonTitle: cancelButtonTitle, okButtonTitle: okButtonTitle, cancelHandle: cancelHandle, okHandle: okHandle)
        let blankBGColor: UIColor = UIColor(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.6)
        alertView.showWithShouldFitHeight(true, blankBGColor: blankBGColor)
    }


    // MARK: - DebugView
    /// 显示app信息
    func showDebugViewWithAppExtraInfo(_ extraInfo: String) {
        let title: String = "app信息"
        let infoDictionary: [String : Any] = Bundle.main.infoDictionary!
        
        let appName: String = infoDictionary["CFBundleDisplayName"] as! String
        //app名
        let appVersion: String = infoDictionary["CFBundleShortVersionString"] as! String
        //版本号
        let appBuild: String = infoDictionary["CFBundleVersion"] as! String
        //buidId
        let message: NSMutableString = NSMutableString()
        message.appendFormat("appName:%@\n",appName)
        message.appendFormat("appVersion:%@\n",appVersion)
        message.appendFormat("appBuild:  %@\n",appBuild)
        message.append(extraInfo)
        CJAlert.showDebugView(title: title, message: message as String)
    }

    /// 显示调试面板
    class func showDebugView(title: String, message: String) {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let popupViewSize: CGSize = CGSize(width: screenWidth*0.9, height: 200)
        let alertView: CJAlertView = CJAlertView.init(size: popupViewSize, firstVerticalInterval: 10, secondVerticalInterval: 10, thirdVerticalInterval: 0, bottomMinVerticalInterval: 10)
        //UIImage *flagImage = [UIImage imageNamed:@"scan_icon_notice"];
        //[alertView addFlagImage:flagImage size:CGSizeMake(38, 38)];
        if title.count > 0 {
            alertView.addTitleWithText(title, font: UIFont.systemFont(ofSize: 15.0), textAlignment: .center, margin: 10, paragraphStyle: nil)
        }
        if message.count > 0 {
            let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.lineBreakMode = .byCharWrapping
            paragraphStyle.lineSpacing = 3
            paragraphStyle.firstLineHeadIndent = 10
            alertView.addMessageWithText(message, font: UIFont.systemFont(ofSize: 15.0), textAlignment: .left, margin: 10, paragraphStyle: paragraphStyle)
            alertView.addMessageLayer(borderWidth: 0.5, borderColor: nil, cornerRadius: 3)
        }
        
        let cancelButtonTitle: String = NSLocalizedString("取消", comment: "取消")
        let okButtonTitle: String = NSLocalizedString("复制到粘贴板", comment: "复制到粘贴板")
        
        alertView.addBottomButtons(actionButtonHeight: 50, cancelButtonTitle: cancelButtonTitle, okButtonTitle: okButtonTitle, cancelHandle: {
            //NSLog(@"调试面板:点击了取消按钮");
        }) {
            //NSLog(@"调试面板:调试信息已复制到粘贴板");
            let pasteboard: UIPasteboard = UIPasteboard.general
            pasteboard.string = message
        }
        
        let blankBGColor: UIColor = UIColor(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.6)
        alertView.showWithShouldFitHeight(true, blankBGColor: blankBGColor)
    }
}
