//
//  UIView+CJShowExtendView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

private var cjExtendViewKey: String = "cjExtendViewKey"

enum CJPopupViewPosition: NSInteger {
    case below = 0
    case above
}

extension UIView {
    /// 当前视图的弹出视图
    var cjExtendView: UIView {
        get {
            return objc_getAssociatedObject(self, &cjExtendViewKey) as! UIView
        }
        set {
            objc_setAssociatedObject(self, &cjExtendViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     *  显示当前视图的弹出视图方法1（弹出视图popupView的位置及大小根据设置的location和size来确定)
     *
     *  @param popupView                    弹出视图popupView
     *  @param popupSuperview               弹出视图popupView的superview
     *  @param popupViewLocation            弹出视图popupView的位置location
     *  @param popupViewSize                弹出视图popupView的大小size
     *  @param blankBGColor                 空白区域的背景颜色
     *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
     *  @param tapBlankViewCompleteBlock    点击空白区域后的操作
     */
    func cj_showExtendView(popupView: UIView,
                           popupSuperview: UIView,
                           popupViewLocation: CGPoint,
                           popupViewSize: CGSize,
                           blankBGColor: UIColor,
                           showPopupViewCompleteBlock: @escaping CJShowPopupViewCompleteBlock,
                           tapBlankViewCompleteBlock: @escaping CJTapBlankViewCompleteBlock)
    {
        self.cjExtendView = popupView;
        
        popupView.cj_popupInView(popupSuperview: popupSuperview,
                                 popupViewOrigin: popupViewLocation,
                                 popupViewSize: popupViewSize,
                                 blankBGColor: blankBGColor,
                                 showPopupViewCompleteBlock: showPopupViewCompleteBlock,
                                 tapBlankViewCompleteBlock: tapBlankViewCompleteBlock)
    }
    
    
    /**
     *  显示当前视图的弹出视图方法2（弹出视图popupView的位置根据其与参照视图accordingView的位置及关系来确定)
     *
     *  @param popupView                    弹出视图popupView
     *  @param popupSuperview               弹出视图popupView的superview
     *  @param accordingView                根据accordingView来取得弹出视图的应该的位置
     *  @param popupViewPosition            弹出视图popupView相对accordingView的位置
     *  @param blankBGColor                 空白区域的背景颜色
     *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
     *  @param tapBlankViewCompleteBlock    点击空白区域后的操作
     */
    func cj_showExtendView(popupView: UIView,
                           popupSuperview: UIView,
                           accordingView: UIView!,
                           popupViewPosition: CJPopupViewPosition,
                           blankBGColor: UIColor,
                           showPopupViewCompleteBlock: @escaping CJShowPopupViewCompleteBlock,
                           tapBlankViewCompleteBlock: @escaping CJTapBlankViewCompleteBlock)
    {
        assert(accordingView != nil, "accordingView不能为空,如果为空，请选择 -cj_showExtendView:inView:atLocation:withSize:showComplete:tapBlankComplete:hideComplete:方法")
        self.cjExtendView = popupView
        //accordingView在popupView的superview中对应的y、rect值为：
        let accordingViewFrameInHisSuperview: CGRect = accordingView.superview!.convert(accordingView.frame, to: popupSuperview)
        //NSLog(@"accordingViewFrameInHisSuperview = %@", NSStringFromCGRect(accordingViewFrameInHisSuperview));
        var popupViewLocation: CGPoint = CGPoint.zero
        var popupViewSize: CGSize = CGSize.zero
        if popupViewPosition == .below {
            let popupViewX: CGFloat = accordingViewFrameInHisSuperview.minX
            let popupViewY: CGFloat = accordingViewFrameInHisSuperview.minY+accordingView.frame.height
            popupViewLocation = CGPoint(x: popupViewX, y: popupViewY)
            let popupViewWidth: CGFloat = accordingView.frame.width
            let popupViewHeight: CGFloat = popupView.frame.height
            assert(popupViewHeight != 0, "弹出视图的高度不能为0")
            popupViewSize = CGSize(width: popupViewWidth, height: popupViewHeight)
        }
        popupView.cj_popupInView(popupSuperview: popupSuperview,
                                 popupViewOrigin: popupViewLocation,
                                 popupViewSize: popupViewSize,
                                 blankBGColor: blankBGColor,
                                 showPopupViewCompleteBlock: showPopupViewCompleteBlock,
                                 tapBlankViewCompleteBlock: tapBlankViewCompleteBlock)
    }
    
    /**
     *  隐藏下拉视图
     *
     *  @param animated 是否动画
     */
    func cj_hideExtendView(animated: Bool) {
        if animated == true {
            self.cjExtendView.cj_hidePopupView(.normal)
        } else {
            self.cjExtendView.cj_hidePopupView(.none)
        }
    }
}



///** 完整的描述请参见文件头部 */
//- (void)cj_showExtendView:(UIView *)popupView
//                   inView:(UIView *)popupSuperview
//    locationAccordingView:(UIView *)accordingView
//         relativePosition:(CJPopupViewPosition)popupViewPosition
//             blankBGColor:(UIColor *)blankBGColor
//             showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
//         tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock
//{
//    
//}
