//
//  UIView+CJPopupInView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

func CJPopupMainThreadAssert() {
    assert(Thread.isMainThread, "UIView+CJPopupInView needs to be accessed on the main thread.");
}


enum CJWindowPosition: NSInteger {
    case bottom = 0
    case center
}

enum CJAnimationType: NSInteger {
    case none = 0        //Directly
    case normal          //通过设置frame来实现
    case CATransform3D
}

typealias CJTapBlankViewCompleteBlock = () -> ()
typealias CJShowPopupViewCompleteBlock = () -> ()




private var kCJPopupAnimationDuration: TimeInterval = 0.3
private var cjPopupAnimationTypeKey: String = "cjPopupAnimationType"
private var cjPopupViewHideFrameStringKey: String = "cjPopupViewHideFrameString"
private var cjPopupViewHideTransformKey: String = "cjPopupViewHideTransform"
private var cjShowInViewKey: String = "cjShowInView"
private var cjTapViewKey: String = "cjTapView"
private var cjShowPopupViewCompleteBlockKey: String = "cjShowPopupViewCompleteBlock"
private var cjTapBlankViewCompleteBlockKey: String = "cjTapBlankViewCompleteBlock"
private var cjPopupViewShowingKey: String = "cjPopupViewShowing"
private var cjMustHideFromPopupViewKey: String = "cjMustHideFromPopupView"



extension UIView {
    // MARK: - runtime
    /// 弹出视图的动画方式
    var cjPopupAnimationType: CJAnimationType {
        get {
            let animationType = objc_getAssociatedObject(self, &cjPopupAnimationTypeKey)
            return animationType as! CJAnimationType
        }
        set {
            objc_setAssociatedObject(self, &cjPopupAnimationTypeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 弹出视图隐藏时候的frame
    var cjPopupViewHideFrameString: String {
        get {
            return objc_getAssociatedObject(self, &cjPopupViewHideFrameStringKey) as! String
        }
        set {
            objc_setAssociatedObject(self, &cjPopupViewHideFrameStringKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    /*
    /// 弹出视图隐藏时候的transform
    var cjPopupViewHideTransform: CATransform3D {
        get {
            return objc_getAssociatedObject(self, &cjPopupViewHideTransformKey) as! CATransform3D
        }
        set {
            objc_setAssociatedObject(self, &cjPopupViewHideTransformKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    */
    
    /// 弹出视图被add到的view
    var cjShowInView: UIView {
        get {
            return objc_getAssociatedObject(self, &cjShowInViewKey) as! UIView
        }
        set {
            objc_setAssociatedObject(self, &cjShowInViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 空白区域（指radioButtons组合下的点击区域（不包括radioButtons区域），用来点击之后隐藏列表）
    var cjTapView: UIView {
        get {
            return objc_getAssociatedObject(self, &cjTapViewKey) as! UIView
        }
        set {
            objc_setAssociatedObject(self, &cjTapViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    
    /// 点击空白区域执行的操作
    var cjTapBlankViewCompleteBlock: CJTapBlankViewCompleteBlock {
        get {
            return objc_getAssociatedObject(self, &cjTapBlankViewCompleteBlockKey) as! CJTapBlankViewCompleteBlock
        }
        set {
            objc_setAssociatedObject(self, &cjTapBlankViewCompleteBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    

    /// 显示弹出视图后的操作
    var cjShowPopupViewCompleteBlock: CJShowPopupViewCompleteBlock {
        get {
            return objc_getAssociatedObject(self, &cjShowPopupViewCompleteBlockKey) as! CJShowPopupViewCompleteBlock
        }
        set {
            objc_setAssociatedObject(self, &cjShowPopupViewCompleteBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    /// 判断当前是否有弹出视图显示
    var cjPopupViewShowing: Bool {
        get {
            let isShowing = objc_getAssociatedObject(self, &cjPopupViewShowingKey)
            return isShowing as! Bool
        }
        set {
            objc_setAssociatedObject(self, &cjPopupViewShowingKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    
    // MARK: - Event
    /**
     *  将本View以size大小弹出到showInView视图中location位置
     *
     *  @param popupSuperview               弹出视图的父视图view
     *  @param popupViewOrigin              弹出视图的左上角origin坐标
     *  @param popupViewSize                弹出视图的size大小
     *  @param blankBGColor                 空白区域的背景颜色
     *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
     *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
     */
    func cj_popupInView(popupSuperview: UIView,
                        popupViewOrigin: CGPoint,
                        popupViewSize: CGSize,
                        blankBGColor: UIColor,
                        showPopupViewCompleteBlock: @escaping CJShowPopupViewCompleteBlock,
                        tapBlankViewCompleteBlock: @escaping CJTapBlankViewCompleteBlock)
    {
        CJPopupMainThreadAssert();
        
        let popupView: UIView = self
        let canAdd: Bool = self.letPopupSuperview(popupSuperview: popupSuperview, popupView: popupView, blankBGColor: blankBGColor)
        if !canAdd {
            return
        }
        let blankView: UIView = self.cjTapView
        let blankViewX: CGFloat = popupViewOrigin.x
        let blankViewY: CGFloat = popupViewOrigin.y
        let blankViewWidth: CGFloat = popupViewSize.width
        let blankViewHeight: CGFloat = popupSuperview.frame.height-popupViewOrigin.y
        let blankViewFrame: CGRect = CGRect(x: blankViewX, y: blankViewY, width: blankViewWidth, height: blankViewHeight)
        blankView.frame = blankViewFrame
        self.cjPopupAnimationType = .normal
        self.cjShowPopupViewCompleteBlock = showPopupViewCompleteBlock
        self.cjTapBlankViewCompleteBlock = tapBlankViewCompleteBlock
        let popupViewX: CGFloat = popupViewOrigin.x
        let popupViewY: CGFloat = popupViewOrigin.y
        let popupViewWidth: CGFloat = popupViewSize.width
        let popupViewShowHeight: CGFloat = popupViewSize.height
        let popupViewHideHeight: CGFloat = 0
        let popupViewShowFrame: CGRect = CGRect(x: popupViewX, y: popupViewY, width: popupViewWidth, height: popupViewShowHeight)
        let popupViewHideFrame: CGRect = CGRect(x: popupViewX, y: popupViewY, width: popupViewWidth, height: popupViewHideHeight)
        self.cjPopupViewHideFrameString = NSCoder.string(for: popupViewHideFrame)
        
        //动画设置位置
        blankView.alpha = 0.2
        popupView.alpha = 0.2
        popupView.frame = popupViewHideFrame
        UIView.animate(withDuration: kCJPopupAnimationDuration, animations: {    blankView.alpha = 1.0
            popupView.alpha = 1.0
            popupView.frame = popupViewShowFrame
            
        })
        showPopupViewCompleteBlock()

    }

    /**
     *  将popupView添加进keyWindow中(会默认添加进blankView及对popupView做一些默认设置)
     *
     *  @param popupView                要被添加的视图
     *  @param blankBGColor             空白区域的背景颜色
     *
     *  @return 是否可以被添加成功
     */
    func letkeyWindowAddPopupView(popupView: UIView, blankBGColor: UIColor) -> Bool {
        let keyWindow: UIWindow = UIApplication.shared.keyWindow!
        let canAdd: Bool = self.letPopupSuperview(popupSuperview: keyWindow, popupView: popupView, blankBGColor: blankBGColor)
        if !canAdd {
            return false
        }
        /* 设置blankView的位置 */
        let blankView: UIView = self.cjTapView
        let blankViewX: CGFloat = 0
        let blankViewY: CGFloat = 0
        let blankViewWidth: CGFloat = keyWindow.frame.width
        let blankViewHeight: CGFloat = keyWindow.frame.height
        
        let blankViewFrame: CGRect = CGRect(x: blankViewX, y: blankViewY, width: blankViewWidth, height: blankViewHeight)
        blankView.frame = blankViewFrame
        /* 对popupView做一些默认设置 */
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOffset = CGSize(width: 0, height: -2)
        popupView.layer.shadowRadius = 5.0
        popupView.layer.shadowOpacity = 0.8
        return true
    }
    
    /**
     *  将popupView添加进popupSuperview中(会默认添加进blankView及对popupView做一些默认设置)
     *
     *  @param popupSuperview           被添加到的地方
     *  @param popupView                要被添加的视图
     *  @param blankBGColor             空白区域的背景颜色
     *
     *  @return 是否可以被添加成功
     */
    func letPopupSuperview(popupSuperview: UIView, popupView: UIView, blankBGColor: UIColor?) -> Bool {
        if popupSuperview.subviews.contains(popupView) {
            return false
        }
        /* 添加进空白的点击区域blankView */
        var blankView: UIView? = self.cjTapView
        if blankView == nil {
            blankView = UIView(frame: CGRect.zero)
            if blankBGColor == nil {
                blankView!.backgroundColor = UIColor(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.6)
            } else {
                blankView!.backgroundColor = blankBGColor
                
            }
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cj_TapBlankViewAction(tap:)))
            blankView!.addGestureRecognizer(tapGesture)
            self.cjTapView = blankView!
        }
        if self.cjPopupViewShowing {
            //如果存在，先清除
            blankView!.removeFromSuperview()
        }
        popupSuperview.addSubview(blankView!)
        /* 添加进popupView，并做一些默认设置 */
        if self.cjPopupViewShowing {
            //如果存在，先清除
            popupView.removeFromSuperview()
        }
        popupSuperview.addSubview(popupView)
        self.cjShowInView = popupSuperview
        self.cjPopupViewShowing = true
        return true
    }
    
    /// 点击空白区域的事件
    @objc func cj_TapBlankViewAction(tap: UITapGestureRecognizer) {
        self.cjTapBlankViewCompleteBlock()
    }

    
    
    
    /**
     *  将当前视图弹出到window中央
     *
     *  @param animationType                弹出时候的动画采用的类型
     *  @param popupViewSize                弹出视图的大小
     *  @param blankBGColor                 空白区域的背景颜色
     *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
     *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
     */
    func cj_popupInCenterWindow(animationType: CJAnimationType,
                                popupViewSize: CGSize,
                                blankBGColor: UIColor,
                                showPopupViewCompleteBlock: CJShowPopupViewCompleteBlock!,
                                tapBlankViewCompleteBlock: CJTapBlankViewCompleteBlock!)
    {
        CJPopupMainThreadAssert()
        let keyWindow: UIWindow = UIApplication.shared.keyWindow!
        let popupView: UIView = self
        let popupSuperview: UIView = keyWindow
        assert(popupViewSize.width != 0 && popupViewSize.height != 0, "弹出视图的宽高都不能为0")
        var frame: CGRect = popupView.frame
        frame.size.width = popupViewSize.width
        frame.size.height = popupViewSize.height
        popupView.frame = frame
        let canAdd: Bool = self.letkeyWindowAddPopupView(popupView: popupView, blankBGColor: blankBGColor)
        if !canAdd {
            return
        }
        self.cjPopupAnimationType = animationType
        self.cjShowPopupViewCompleteBlock = showPopupViewCompleteBlock
        self.cjTapBlankViewCompleteBlock = tapBlankViewCompleteBlock
        popupView.center = popupSuperview.center
        if animationType == .none {
            
        } else if animationType == .normal {
            
        } else if animationType == .CATransform3D {
            let popupViewShowTransform: CATransform3D = CATransform3DIdentity;
            let rotate: CATransform3D = CATransform3DMakeRotation(CGFloat(70.0*Double.pi/180.0), 0.0, 0.0, 1.0);
            let translate: CATransform3D = CATransform3DMakeTranslation(20.0, -500.0, 0.0);
            let popupViewHideTransform: CATransform3D = CATransform3DConcat(rotate, translate);
            self.layer.transform = popupViewHideTransform
            UIView.animate(withDuration: kCJPopupAnimationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                self.layer.transform = popupViewShowTransform
                
            })
        }
        showPopupViewCompleteBlock()
    }
    
    
    /**
     *  将当前视图弹出到window底部
     *
     *  @param animationType                弹出时候的动画采用的类型
     *  @param popupViewHeight              弹出视图的高度
     *  @param blankBGColor                 空白区域的背景颜色
     *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
     *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
     */
    func cj_popupInBottomWindow(animationType: CJAnimationType,
                               popupViewHeight: CGFloat,
                               blankBGColor: UIColor,
                               showPopupViewCompleteBlock: @escaping CJShowPopupViewCompleteBlock,
                               tapBlankViewCompleteBlock: @escaping CJTapBlankViewCompleteBlock)
    {
        CJPopupMainThreadAssert()
        assert(popupViewHeight != 0, "弹出视图的高都不能为0")
        let keyWindow: UIWindow = UIApplication.shared.keyWindow!
        let popupViewWidth: CGFloat = keyWindow.frame.width
        let popupViewSize: CGSize = CGSize(width: popupViewWidth, height: popupViewHeight)
        if self.frame.size.equalTo(popupViewSize) {
            print("Warning:popupView视图大小将自动调整为指定的弹出视图大小")
            var selfFrame: CGRect = self.frame
            selfFrame.size = popupViewSize
            self.frame = selfFrame
        }
        let popupView: UIView = self
        let canAdd: Bool = self.letkeyWindowAddPopupView(popupView: popupView, blankBGColor: blankBGColor)
        if !canAdd {
            return
        }
        self.cjPopupAnimationType = animationType
        self.cjShowPopupViewCompleteBlock = showPopupViewCompleteBlock
        self.cjTapBlankViewCompleteBlock = tapBlankViewCompleteBlock
        //popupViewShowFrame
        let popupViewX: CGFloat = 0
        let popupViewShowY: CGFloat = keyWindow.frame.height-popupViewHeight
        var popupViewShowFrame: CGRect = CGRect.zero
        popupViewShowFrame = CGRect(x: popupViewX, y: popupViewShowY, width: popupViewWidth, height: popupViewHeight)
        if animationType == .none {
            popupView.frame = popupViewShowFrame
            
        } else if animationType == .normal {
            //popupViewHideFrame
            var popupViewHideFrame: CGRect = popupViewShowFrame
            popupViewHideFrame.origin.y = keyWindow.frame.maxY
            self.cjPopupViewHideFrameString = NSCoder.string(for: popupViewHideFrame)
            //动画设置位置
            let blankView: UIView = self.cjTapView
            blankView.alpha = 0.2
            popupView.alpha = 0.2
            popupView.frame = popupViewHideFrame
            UIView.animate(withDuration: kCJPopupAnimationDuration, animations: {    blankView.alpha = 1.0
                popupView.alpha = 1.0
                popupView.frame = popupViewShowFrame
                
            })
        } else if animationType == .CATransform3D {
            popupView.frame = popupViewShowFrame
            let popupViewShowTransform: CATransform3D = CATransform3DIdentity;
            let rotate: CATransform3D = CATransform3DMakeRotation(CGFloat(70.0*Double.pi/180.0), 0.0, 0.0, 1.0);
            let translate: CATransform3D = CATransform3DMakeTranslation(20.0, -500.0, 0.0);
            let popupViewHideTransform: CATransform3D = CATransform3DConcat(rotate, translate);
            self.layer.transform = popupViewHideTransform
            UIView.animate(withDuration: kCJPopupAnimationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                self.layer.transform = popupViewShowTransform
                
            })
        }
        
        showPopupViewCompleteBlock()
    }
    
    
    /// 隐藏弹出视图
    func cj_hidePopupView() {
        let animationType: CJAnimationType = self.cjPopupAnimationType
        self.cj_hidePopupView(animationType)
    }
    
    /**
     *  隐藏弹出视图
     *
     *  @param animationType                弹出时候的动画采用的类型
     */
    func cj_hidePopupView(_ animationType: CJAnimationType) {
        CJPopupMainThreadAssert();
        self.cjPopupViewShowing = false
        //设置成NO表示当前未显示任何弹出视图
        self.endEditing(true)
        let popupView: UIView = self
        let tapView: UIView = self.cjTapView
        switch animationType {
        case .none:
            
            popupView.removeFromSuperview()
            tapView.removeFromSuperview()
            break
            
        case .normal:
            
            var popupViewHideFrame: CGRect = NSCoder.cgRect(for: self.cjPopupViewHideFrameString)
            if popupViewHideFrame.equalTo(CGRect.zero) {
                popupViewHideFrame = self.frame
            }
            UIView.animate(withDuration: kCJPopupAnimationDuration, animations: {    //要设置成0，不设置非零值如0.2，是为了防止在显示出来的时候，在0.3秒内很快按两次按钮，仍有view存在
                tapView.alpha = 0.0
                popupView.alpha = 0.0
                popupView.frame = popupViewHideFrame
                
            })
            break
            
        case .CATransform3D:
            UIView.animate(withDuration: kCJPopupAnimationDuration, delay: 0.0, options: .curveEaseIn, animations: {
                let rotate: CATransform3D = CATransform3DMakeRotation(CGFloat(-70.0 * Double.pi / 180.0), 0.0, 0.0, 1.0);
                let translate: CATransform3D = CATransform3DMakeTranslation(-20.0, 500.0, 0.0);
                popupView.layer.transform = CATransform3DConcat(rotate, translate)
                
            })
            break
        }

    }
}
