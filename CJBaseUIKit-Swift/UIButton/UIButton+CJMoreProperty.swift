//
//  UIButton+CJMoreProperty.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

typealias CJButtonTouchBlock = (_ button: UIButton) -> ()

private var cjNormalBGColorKey: String = "cjNormalBGColorKey"
private var cjHighlightedBGColorKey: String = "cjHighlightedBGColorKey"
private var cjDisabledBGColorKey: String = "cjDisabledBGColorKey"
private var cjSelectedBGColorKey: String = "cjSelectedBGColorKey"
private var cjTouchUpInsideBlockKey: String = "cjTouchUpInsideBlockKey"
private var cjDataModelKey: String = "cjDataModelKey"


extension UIButton {
    // MARK: - runtime 颜色相关
    /// 设置按钮默认时候的背景颜色
    var cjNormalBGColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &cjNormalBGColorKey) as! UIColor
        }
        set {
            objc_setAssociatedObject(self, &cjNormalBGColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            let normalBGImage: UIImage = UIButton.cj_buttonBGImage(bgColor: newValue)
            self.setBackgroundImage(normalBGImage, for: .normal)
        }
    }
    
    
    /// 设置按钮高亮时候的背景颜色
    var cjHighlightedBGColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &cjHighlightedBGColorKey) as! UIColor
        }
        set {
            objc_setAssociatedObject(self, &cjHighlightedBGColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            let highlightedBGImage: UIImage = UIButton.cj_buttonBGImage(bgColor: newValue)
            self.setBackgroundImage(highlightedBGImage, for: .highlighted)
            
        }
    }
    
    /// 设置按钮失效时候的背景颜色
    var cjDisabledBGColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &cjDisabledBGColorKey) as! UIColor
        }
        set {
            objc_setAssociatedObject(self, &cjDisabledBGColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            let disabledBGImage: UIImage = UIButton.cj_buttonBGImage(bgColor: newValue)
            self.setBackgroundImage(disabledBGImage, for: .disabled)
        }
    }
    

    /// 设置按钮失效时候的背景颜色
    var cjSelectedBGColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &cjSelectedBGColorKey) as! UIColor
        }
        set {
            objc_setAssociatedObject(self, &cjSelectedBGColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            let selectedBGImage: UIImage = UIButton.cj_buttonBGImage(bgColor: newValue)
            self.setBackgroundImage(selectedBGImage, for: .selected)
        }
    }
    
    /// 使用颜色构建的背景图片
    class func cj_buttonBGImage(bgColor: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(bgColor.cgColor)
        context.fill(rect)
        let bgImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return bgImage
    }
    
    
    
    // MARK: - runtime 数据相关
    /// 设置按钮持有的数据对象
    var cjDataModel: Any {
        get {
            return objc_getAssociatedObject(self, &cjDataModelKey) as! UIColor
        }
        set {
            objc_setAssociatedObject(self, &cjDataModelKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    
    // MARK: - runtime 事件点击相关
    /// 设置按钮操作的事件
    var cjTouchUpInsideBlock: CJButtonTouchBlock {
        get {
            return objc_getAssociatedObject(self, &cjTouchUpInsideBlockKey) as! CJButtonTouchBlock
        }
        set {
            objc_setAssociatedObject(self, &cjTouchUpInsideBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            //设置的时候，就给他添加方法，省得再多个接口处理
            self.addTarget(self, action: #selector(cjTouchUpInsideAction(button:)), for: .touchUpInside)
        }
    }
    
    /// 按钮点击事件
    @objc func cjTouchUpInsideAction(button: UIButton) {
        self.cjTouchUpInsideBlock(button)
    }
}
