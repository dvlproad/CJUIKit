//
//  CQAlertManager.swift
//  LuckyClient
//
//  Created by 李超前 on 2019/8/15.
//  Copyright © 2019 luckyteam. All rights reserved.
//

import UIKit

class CQAlertManager: NSObject {
    static let shared: CQAlertManager = CQAlertManager()
    var networkNoOpenAlert: CJAlertView?     /**< 网络权限没打开的alert */
    var locationNoOpenAlert: CJAlertView?    /**< 定位权限没打开的alert */
    var locationAbnormalAlert: CJAlertView?  /**< 定位权限异常的alert */
    
    ///显示和隐藏定位权限没打开的alert
    @objc
    class func showNetworkNoOpenAlert(_ show:Bool) {
        if (!show) {
            if let networkNoOpenAlert = CQAlertManager.shared.networkNoOpenAlert {
                networkNoOpenAlert.dismiss(0)
                CQAlertManager.shared.networkNoOpenAlert = nil;
            }
        }else{
            showLocationNoOpenAlert(false)
            if CQAlertManager.shared.networkNoOpenAlert != nil {
                return;
            }
            
            CQAlertManager.shared.networkNoOpenAlert = luckinAlertView(title: NSLocalizedString("网络链接失败，请检查您的网络链接", comment: ""), confirmButtonTitle: NSLocalizedString("查看设置", comment: ""), confirmActionHandle: {
                CQAlertManager.shared.networkNoOpenAlert = nil;
                AuthorizationCJHelper.openSetting(completionHandler: nil)
            })
            
            let blankBGColor = UIColor(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.6)
            CQAlertManager.shared.locationAbnormalAlert?.showWithShouldFitHeight(true, blankBGColor: blankBGColor)
        }
    }
    
    ///显示和隐藏定位权限没打开的alert
    @objc
    class func showLocationNoOpenAlert(_ show:Bool) {
        if (!show) {
            if let locationNoOpenAlert = CQAlertManager.shared.locationNoOpenAlert {
                locationNoOpenAlert.dismiss(0)
                CQAlertManager.shared.locationNoOpenAlert = nil;
            }
        }else{
            showLocationNoOpenAlert(false)
            if CQAlertManager.shared.locationNoOpenAlert != nil {
                return;
            }
            
            CQAlertManager.shared.locationNoOpenAlert = luckinAlertView(title: NSLocalizedString("您没开启GPS，无法接单", comment: ""), confirmButtonTitle: NSLocalizedString("去开启", comment: ""), confirmActionHandle: {
                CQAlertManager.shared.locationNoOpenAlert = nil;
                AuthorizationCJHelper.openSetting(completionHandler: nil)
            })
            
            let blankBGColor = UIColor(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.6)
            CQAlertManager.shared.locationAbnormalAlert?.showWithShouldFitHeight(true, blankBGColor: blankBGColor)
        }
    }
    
    ///显示和隐藏定位权限异常的alert
    @objc
    class func showLocationAbnormalAlert(_ show:Bool) {
        if (!show) {
            if let locationAbnormalAlert = CQAlertManager.shared.locationAbnormalAlert {
                locationAbnormalAlert.dismiss(0)
                CQAlertManager.shared.locationAbnormalAlert = nil;
            }
        }else{
            showLocationNoOpenAlert(false)
            if CQAlertManager.shared.locationAbnormalAlert != nil {
                return;
            }
            
            CQAlertManager.shared.locationAbnormalAlert = luckinAlertView(title: NSLocalizedString("获取定位权限异常，请手动授权APP定位权限", comment: ""), confirmButtonTitle: NSLocalizedString("我知道了", comment: ""), confirmActionHandle: {
                CQAlertManager.shared.locationAbnormalAlert = nil;
                AuthorizationCJHelper.openSetting(completionHandler: nil)
            })
            
            let blankBGColor = UIColor(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.6)
            CQAlertManager.shared.locationAbnormalAlert?.showWithShouldFitHeight(true, blankBGColor: blankBGColor)
            
        }
    }
    
    
    //MARK:- 当需要自定义alert上的按钮的时候使用如下方法
    class func luckinAlertView(title: String, confirmButtonTitle:String, confirmActionHandle:(()->())?) -> CJAlertView {
        
        let alertView = self.alertView(title);
        let confirmButton = LuckinButtonFactory.whiteBlueButton(confirmButtonTitle)
        confirmButton.cjTouchUpInsideBlock = { (button) in
            alertView.dismiss(withDelay: 0)
            if let confirmActionHandle = confirmActionHandle {
                confirmActionHandle();
            }
        }
        
        alertView.addOnlyOneBottomButton(confirmButton, withHeight: 44, bottomInterval: 15, leftOffset: 15, rightOffset: 15)
        return alertView;
    }
}

