//
//  UIViewController+CJToast.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/19.
//  Copyright © 2019 dvlproad. All rights reserved.
//

import UIKit

private var cjChrysanthemumHUDKey: Void?

extension UIViewController {
//@property (nonatomic, strong, readonly) MBProgressHUD *cjChrysanthemumHUD;  /**< "菊花HUD" */
//@property (nonatomic, assign, readonly) BOOL isCJChrysanthemumHUDShowing;   /**< 是否"菊花HUD"在显示中 */

    var cjChrysanthemumHUD: MBProgressHUD {
        get {
            var hud = objc_getAssociatedObject(self, &cjChrysanthemumHUDKey) as? MBProgressHUD
            if hud == nil {
                hud = MBProgressHUD.init(view: self.view)
                hud?.backgroundView.style = .solidColor
                hud?.backgroundView.color = UIColor(white: 0, alpha: 0.1)
                hud?.contentColor = UIColor.white //等待框文字颜色
                hud?.bezelView.backgroundColor = UIColor(white: 0, alpha: 0.76) //等待框背景色
                hud?.removeFromSuperViewOnHide = true
                
                objc_setAssociatedObject(self, &cjChrysanthemumHUDKey, hud, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return hud!
        }
    }
    
    /// 显示"菊花HUD"视图
    func cj_showChrysanthemumHUD(startProgressMessage: String, animated: Bool) {
        self.cjChrysanthemumHUD.label.text = startProgressMessage
        
        self.view.addSubview(self.cjChrysanthemumHUD)
        self.cjChrysanthemumHUD.show(animated: animated)
    }
    
    /// 更新"菊花HUD"文本
    func cj_updateChrysanthemumHUD(progressingMessage: String) {
        self.cjChrysanthemumHUD.label.text = progressingMessage
    }

    /// 隐藏"菊花HUD"视图
    func cj_hideChrysanthemumHUD(animated:Bool, afterDelay:TimeInterval) {
        self.cjChrysanthemumHUD.hide(animated: animated, afterDelay: afterDelay)
    }

}
