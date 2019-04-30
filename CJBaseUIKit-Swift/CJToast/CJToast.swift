//
//  CJToast.swift
//  CJUIKitSwiftDemo
//
//  Created by 李超前 on 2019/4/30.
//  Copyright © 2019 dvlproad. All rights reserved.
//

import UIKit
import Foundation

class CJToast: NSObject {
    // MARK: - Only Text
    /**
     *  在window上短暂的显示文字(灰底黑字，2秒后自动消失)
     *
     *  @param message  要显示的信息
     */
    class func shortShowMessage(_ message: NSString?) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let window: UIView = appDelegate.window!
        let keyWindow: UIView! = UIApplication.shared.keyWindow
        CJToast.shortShowMessage(message, in: keyWindow)
    }
    
    
    /**
     *  在window上短暂的显示文字(黑底白字，2秒后自动消失)
     *
     *  @param message  要显示的信息
     */
    
    class func shortShowWhiteMessage(_ message: NSString?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window: UIView = appDelegate.window!
        CJToast.shortShowWhiteMessage(message, in: window)
    }
    
    /**
     *  在指定的view上短暂的显示文字(灰底黑字，2秒后自动消失)
     *
     *  @param message  要显示的信息
     *  @param view     信息要显示的位置
     */
    class func shortShowMessage(_ message: NSString?, in view: UIView?) {
        self.shortShowMessage(message, in: view!, withLabelTextColor: nil, bezelViewColor: nil, hideAfterDelay: 2.0)
    }
    
    /**
     *  在指定的view上短暂的显示文字(黑底白字，2秒后自动消失)
     *
     *  @param message  要显示的信息
     *  @param view     信息要显示的位置
     */
    class func shortShowWhiteMessage(_ message: NSString?, in view: UIView?) {
        self.shortShowMessage(message, in: view!, withLabelTextColor: UIColor.white, bezelViewColor: UIColor.black, hideAfterDelay: 2.0)
    }
    

    /**
     *  在指定的view上显示文字，并在delay秒后自动消失
     *
     *  @param message          要显示的信息
     *  @param view             信息要显示的位置
     *  @param labelTextColor   文字的颜色
     *  @param bezelViewColor   文字所在背景框的颜色
     *  @param delay            多少秒后自动消失
     */
    class func shortShowMessage(_ message: NSString?, in view: UIView, withLabelTextColor labelTextColor: UIColor?, bezelViewColor: UIColor?, hideAfterDelay delay: TimeInterval) {
        if (message?.length == 0) {
            print("toast message length == 0")
            return
        }
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)

        let margin: CGFloat = 10

        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.margin = margin

        let labelMaxWidth: CGFloat = view.frame.width - 4 * margin
        let hudLabelFont: UIFont = hud.label.font
        let labelWidth: CGFloat = labelMaxWidth;
        let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let textSize: CGSize = self.getTextSize(from: message!, with: hudLabelFont, maxSize: maxSize, lineBreakMode: .byCharWrapping, paragraphStyle: nil)
        
        
        
        //由于 MBProgressHUD 的label的numberOfLines为1，所以label只支持单行显示。(附detailsLabel支持多行)
        //情况①当文本太长时候，需要多行显示，所以如果要显示的字符串超过单行最大长度，我们则改为用自定义的label显示；
        //情况②当使用\n时候，一样的道理，也无法显示多行，所以干脆直接放弃到原本的label
//        if textSize.width < labelMaxWidth {
//            hud.mode = MBProgressHUDModeText
//            //hud.label.numberOfLines = 0;
//            if labelTextColor {
//                hud.label.textColor = labelTextColor
//                //hud.detailsLabel.textColor = labelTextColor;
//            }
//            if bezelViewColor {
//                hud.bezelView.color = bezelViewColor
//            }
//
//
//            hud.minSize = CGSize(width: 200, height: 80)
//
//            hud.label.text = message
//            //hud.detailsLabel.text = message;
//        }
//        else
//        {
            hud.mode = .customView
        
            if labelTextColor != nil {
    //            if let labelTextColor = labelTextColor {
                    hud.label.textColor = labelTextColor
    //            }
            }
        
            if bezelViewColor != nil {
                hud.bezelView.color = bezelViewColor!
            }
        
            let label  = UILabel()
            label.textAlignment = .center
            label.font = hudLabelFont
            label.textColor = hud.label.textColor
            label.numberOfLines = 0
            label.lineBreakMode = .byCharWrapping
        
            let labelHeight: CGFloat = min(view.frame.height - 4 * margin, textSize.height)
            var frame: CGRect = label.frame
            frame.size = CGSize(width: labelWidth, height: labelHeight)
            label.frame = frame
        
            label.text = message as String?
        
            hud.customView = label
//        }
        hud.hide(animated: true, afterDelay: delay)
    }


    // MARK: - Text And Image
    /**
     *  在指定的view上短暂的显示文字及图片（0.7秒后自动消失）
     *
     *  @param message  要显示的文字
     *  @param image    要显示的图片
     *  @param view     要显示在的视图
     */
    class func shortShowMessage(_ message: NSString?, image: UIImage?, to view: UIView?) {
        var view = view
        if view == nil {
            view = UIApplication.shared.keyWindow
        }

        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.label.text = message as String?
        hud.customView = UIImageView(image: image) // 设置图片
        hud.mode = .customView // 再设置模式

        hud.removeFromSuperViewOnHide = true // 隐藏时候从父控件中移除
        hud.hide(animated: true, afterDelay: 0.7) // 0.7秒之后再消失
    }


    // MARK: - Text And 菊花
    /**
     *  创建一个显示菊花和信息的上下结构HUD(实际一般不用此方法,而是直接写如CJTotalDemo中 AppDelegate+DefaultSetting.h 的数据库初始化)
     *
     *  @param message                  要显示的文字(可以为nil)
     *  @param view                     要显示在的视图
     */
    class func createChrysanthemumHUD(withMessage message: NSString?, to view: UIView?) -> MBProgressHUD? {
        var view = view
        if view == nil {
            view = UIApplication.shared.keyWindow
        }

        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        hud.contentColor = UIColor.white //等待框文字颜色
        hud.bezelView.backgroundColor = UIColor(white: 0, alpha: 0.76) //等待框背景色

        if message != nil {
            hud.label.text = message as String?
        }

        return hud
    }

    /**
     *  exec operation With HUD
     *
     *  @param startProgressMessage startProgressMessage
     *  @param endProgressMessage   endProgressMessage
     *  @param operationHandle      operationHandle
     */
    class func execOperation(withStartMessage startProgressMessage: String?, endMessage endProgressMessage: String?, operationHandle: (() -> Void)? = nil) {
        let hudAddedToView: UIView! = UIApplication.shared.keyWindow
        let hud = MBProgressHUD.showAdded(to: hudAddedToView, animated: true)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        hud.contentColor = UIColor(red: 0.0, green: 0.6, blue: 0.7, alpha: 1.0)

        hud.label.text = startProgressMessage
        DispatchQueue.global(qos: .default).async(execute: {
            operationHandle!() 

            DispatchQueue.main.async(execute: {
                hud.label.text = endProgressMessage
                hud.hide(animated: true, afterDelay: 0.7)
            })
        })
    }


    // MARK: - HUD
    class func showHUDAdded(to view: UIView?, animated: Bool) {
        MBProgressHUD.showAdded(to: view!, animated: animated)
        //TODO:UIActivityIndicatorView
    }

    class func hideHUD(for view: UIView?, animated: Bool) -> Bool {
        return MBProgressHUD.hide(for: view!, animated: animated)
    }
    
    
    
    // MARK: - Private
    //以下获取textSize方法取自NSString+CJTextSize
    class func getTextSize(from string: NSString, with font: UIFont, maxSize: CGSize, lineBreakMode: NSLineBreakMode, paragraphStyle: NSMutableParagraphStyle?) -> CGSize {
        var paragraphStyle = paragraphStyle
        if (string.length == 0) {
            return CGSize.zero
        }

    
        if paragraphStyle == nil {
            paragraphStyle = NSParagraphStyle.default as? NSMutableParagraphStyle
            paragraphStyle?.lineBreakMode = lineBreakMode
        }
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle!,
            NSAttributedString.Key.font: font
        ]
        let options: NSStringDrawingOptions = .usesLineFragmentOrigin
        
        let textRect: CGRect = string.boundingRect(with: maxSize, options: options, attributes: attributes, context: nil)
        let size: CGSize = textRect.size
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
}
