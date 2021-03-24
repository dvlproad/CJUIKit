//
//  UIView+CJPopupInView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupInView.h"
#import <objc/runtime.h>
#import "UIView+CJPopupAnimation.h"
#import "CJBasePopupInfo.h"

#define CJPopupMainThreadAssert() NSAssert([NSThread isMainThread], @"UIView+CJPopupInView needs to be accessed on the main thread.");

static CGFloat kCJPopupAnimationDuration = 0.3;

static NSString *cjPopupAnimationTypeKey = @"cjPopupAnimationType";
static NSString *cjPopupViewHideFrameStringKey = @"cjPopupViewHideFrameString";
static NSString *cjPopupViewHideTransformKey = @"cjPopupViewHideTransform";

static NSString *cjShowInViewKey = @"cjShowInView";
static NSString *cjTapViewKey = @"cjTapView";

static NSString *cjShowPopupViewCompleteBlockKey = @"cjShowPopupViewCompleteBlock";
static NSString *cjTapBlankViewCompleteBlockKey = @"cjTapBlankViewCompleteBlock";

static NSString *cjPopupViewShowingKey = @"cjPopupViewShowing";
static NSString *cjMustHideFromPopupViewKey = @"cjMustHideFromPopupView";


@interface UIView ()

@property (nonatomic, assign, readonly) CJAnimationType cjPopupAnimationType;   /**< 弹出视图的动画方式 */
@property (nonatomic, copy) NSString *cjPopupViewHideFrameString;   /**< 弹出视图隐藏时候的frame */
//@property (nonatomic, assign) CATransform3D cjPopupViewHideTransform;/**< 弹出视图隐藏时候的transform */

@property (nonatomic, strong) UIView *cjShowInView; /**< 弹出视图被add到的view */
@property (nonatomic, strong) UIView *cjTapView;    /**< 空白区域（指radioButtons组合下的点击区域（不包括radioButtons区域），用来点击之后隐藏列表） */

@property (nonatomic, copy) void(^cjTapBlankViewCompleteBlock)(void);   /**< 点击空白区域执行的操作 */
@property (nonatomic, copy) void(^cjShowPopupViewCompleteBlock)(void);  /**< 显示弹出视图后的操作 */

@end


@implementation UIView (CJPopupInView)

#pragma mark - runtime
//cjPopupAnimationType
- (CJAnimationType)cjPopupAnimationType {
    return [objc_getAssociatedObject(self, &cjPopupAnimationTypeKey) integerValue];
}

- (void)setCjPopupAnimationType:(CJAnimationType)cjPopupAnimationType {
    return objc_setAssociatedObject(self, &cjPopupAnimationTypeKey, @(cjPopupAnimationType), OBJC_ASSOCIATION_ASSIGN);
}

//cjPopupViewHideFrameString
- (NSString *)cjPopupViewHideFrameString {
    return objc_getAssociatedObject(self, &cjPopupViewHideFrameStringKey);
}

- (void)setCjPopupViewHideFrameString:(NSString *)cjPopupViewHideFrameString {
    return objc_setAssociatedObject(self, &cjPopupViewHideFrameStringKey, cjPopupViewHideFrameString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

////cjPopupViewHideTransform
//- (CATransform3D)cjPopupViewHideTransform {
//    return objc_getAssociatedObject(self, &cjPopupViewHideTransformKey);
//}
//
//- (void)setCjPopupViewHideTransform:(CATransform3D)cjPopupViewHideTransform {
//    return objc_setAssociatedObject(self, &cjPopupViewHideTransformKey, cjPopupViewHideTransform, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

//cjShowInView
- (UIView *)cjShowInView {
    return objc_getAssociatedObject(self, &cjShowInViewKey);
}

- (void)setCjShowInView:(UIView *)cjShowInView {
    return objc_setAssociatedObject(self, &cjShowInViewKey, cjShowInView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjTapView
- (UIView *)cjTapView {
    return objc_getAssociatedObject(self, &cjTapViewKey);
}

- (void)setCjTapView:(UIView *)cjTapView {
    return objc_setAssociatedObject(self, &cjTapViewKey, cjTapView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjTapBlankViewCompleteBlock
- (void(^)(void))cjTapBlankViewCompleteBlock {
    return objc_getAssociatedObject(self, &cjTapBlankViewCompleteBlockKey);
}

- (void)setCjTapBlankViewCompleteBlock:(void(^)(void))cjTapBlankViewCompleteBlock {
    return objc_setAssociatedObject(self, &cjTapBlankViewCompleteBlockKey, cjTapBlankViewCompleteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//cjShowPopupViewCompleteBlock
- (void(^)(void))cjShowPopupViewCompleteBlock {
    return objc_getAssociatedObject(self, &cjShowPopupViewCompleteBlockKey);
}

- (void)setCjShowPopupViewCompleteBlock:(void(^)(void))cjShowPopupViewCompleteBlock {
    return objc_setAssociatedObject(self, &cjShowPopupViewCompleteBlockKey, cjShowPopupViewCompleteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


//cjPopupViewShowing
- (BOOL)isCJPopupViewShowing {
    return [objc_getAssociatedObject(self, &cjPopupViewShowingKey) boolValue];
}

- (void)setCjPopupViewShowing:(BOOL)cjPopupViewShowing {
    return objc_setAssociatedObject(self, &cjPopupViewShowingKey, @(cjPopupViewShowing), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - 底层接口:弹出到视图View
/*
 *  将本View以size大小弹出到showInView视图中location位置
 *
 *  @param popupSuperview               弹出视图的父视图view
 *  @param popupViewOrigin              弹出视图的左上角origin坐标
 *  @param popupViewSize                弹出视图的size大小
 *  @param showBeforeConfigBlock        显示弹出视图前的一些对视图定制操作(可为nil,为nil时候会内置默认设置背景颜色)
 *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInView:(nonnull UIView *)popupSuperview
            withOrigin:(CGPoint)popupViewOrigin
                  size:(CGSize)popupViewSize
 showBeforeConfigBlock:(void(^ _Nullable)(UIView *bBlankView, UIView *bRealPopupView))showBeforeConfigBlock
          showComplete:(void(^ _Nullable)(void))showPopupViewCompleteBlock
      tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock;
{
    CJBasePopupInfo *popupInfo = [UIView addSubviewToPopupSuperview:popupSuperview
                                                withBlankViewBelong:CJBlankViewBelongPopupView
                                                          popupView:self
                                                    popupViewOrigin:popupViewOrigin
                                                      popupViewSize:popupViewSize];
    
    self.cjPopupAnimationType = CJAnimationTypeNormal;
    self.cjShowPopupViewCompleteBlock = showPopupViewCompleteBlock;
    self.cjTapBlankViewCompleteBlock = tapBlankViewCompleteBlock;
    [self popupWithViewInfo:popupInfo isToBottom:NO showBeforeConfigBlock:showBeforeConfigBlock showComplete:showPopupViewCompleteBlock tapBlankComplete:tapBlankViewCompleteBlock];
}

- (void)popupWithViewInfo:(CJBasePopupInfo *)popupInfo
               isToBottom:(BOOL)isToBottom
    showBeforeConfigBlock:(void(^ _Nullable)(UIView *bBlankView, UIView *bRealPopupView))showBeforeConfigBlock
             showComplete:(void(^ _Nullable)(void))showPopupViewCompleteBlock
         tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock
{
    UIView *blankView = popupInfo.blankView;
    if (showBeforeConfigBlock == nil) {
        blankView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    } else {
        showBeforeConfigBlock(blankView, self);
    }
    
    CGRect popupViewShowFrame = popupInfo.popupViewShowFrame;
    [self __popupViewToShowFrame:popupViewShowFrame
                      isToBottom:isToBottom
                   animationType:CJAnimationTypeNone];
    
    if(showPopupViewCompleteBlock){
        showPopupViewCompleteBlock();
    }
    
}

/*
 *  将当前视图弹出到视图view中央
 *
 *  @param popupSuperview               弹出视图的父视图view(可以为nil,为nil时候弹出到keyWindow上)
 *  @param animationType                弹出时候的动画采用的类型
 *  @param popupViewSize                弹出视图的大小
 *  @param centerOffset                 弹窗弹出位置的中心与window中心的偏移量
 *  @param showBeforeConfigBlock        显示弹出视图前的一些对视图定制操作(可为nil,为nil时候会内置默认设置背景颜色)
 *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInCenterInView:(nullable UIView *)popupSuperview
                 animationType:(CJAnimationType)animationType
                      withSize:(CGSize)popupViewSize
                  centerOffset:(CGPoint)centerOffset
          showBeforeConfigBlock:(void(^ _Nullable)(UIView *bBlankView, UIView *bRealPopupView))showBeforeConfigBlock
                  showComplete:(void(^ _Nullable)(void))showPopupViewCompleteBlock
              tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock
{
    if (popupSuperview == nil) {
        popupSuperview = [[UIApplication sharedApplication] keyWindow];
    }
    
    CGFloat popupSuperviewWidth = CGRectGetWidth(popupSuperview.frame);
    CGFloat popupSuperviewHeight = CGRectGetHeight(popupSuperview.frame);
    
    CGPoint popupViewShowCenter = CGPointMake(popupSuperviewWidth/2 + centerOffset.x,
                                              popupSuperviewHeight/2 + centerOffset.y);
    CGFloat originX = popupViewShowCenter.x - popupViewSize.width/2;
    CGFloat originY = popupViewShowCenter.y - popupViewSize.height/2;
    CGPoint popupViewOrigin = CGPointMake(originX, originY);
    
    CJBasePopupInfo *popupInfo = [UIView addSubviewToPopupSuperview:popupSuperview
                                                withBlankViewBelong:CJBlankViewBelongPopupView
                                                          popupView:self
                                                    popupViewOrigin:popupViewOrigin
                                                      popupViewSize:popupViewSize];
    
    self.cjPopupAnimationType = CJAnimationTypeNormal;
    self.cjShowPopupViewCompleteBlock = showPopupViewCompleteBlock;
    self.cjTapBlankViewCompleteBlock = tapBlankViewCompleteBlock;
    [self popupWithViewInfo:popupInfo isToBottom:NO showBeforeConfigBlock:showBeforeConfigBlock showComplete:showPopupViewCompleteBlock tapBlankComplete:tapBlankViewCompleteBlock];
}


/*
 *  将当前视图弹出到视图view底部
 *
 *  @param popupSuperview               弹出视图的父视图view(可以为nil,为nil时候弹出到keyWindow上)
 *  @param animationType                弹出时候的动画采用的类型
 *  @param popupViewHeight              弹出视图的高度
 *  @param edgeInsets                   弹窗与window的(左右下)边距
 *  @param showBeforeConfigBlock        显示弹出视图前的一些对视图定制操作(可为nil,为nil时候会内置默认设置背景颜色)
 *  @param showPopupViewCompleteBlock   显示弹出视图后的操作
 *  @param tapBlankViewCompleteBlock    点击空白区域后的操作(要自己执行cj_hidePopupView...来隐藏，因为有时候点击背景是不执行隐藏的)
 */
- (void)cj_popupInBottomInView:(nullable UIView *)popupSuperview
                 animationType:(CJAnimationType)animationType
                    withHeight:(CGFloat)popupViewHeight
                    edgeInsets:(UIEdgeInsets)edgeInsets
          showBeforeConfigBlock:(void(^ _Nullable)(UIView *bBlankView, UIView *bRealPopupView))showBeforeConfigBlock
                  showComplete:(void(^ _Nullable)(void))showPopupViewCompleteBlock
              tapBlankComplete:(void(^ _Nullable)(void))tapBlankViewCompleteBlock
{
    if (popupSuperview == nil) {
        popupSuperview = [[UIApplication sharedApplication] keyWindow];
    }
    
    CGFloat popupViewWidth = CGRectGetWidth(popupSuperview.frame) - edgeInsets.left - edgeInsets.right;
    CGSize popupViewSize = CGSizeMake(popupViewWidth, popupViewHeight);
    
    CGFloat popupViewX = edgeInsets.left;
    CGFloat popupViewShowY = CGRectGetHeight(popupSuperview.frame) - popupViewHeight - edgeInsets.bottom;
    CGPoint popupViewOrigin = CGPointMake(popupViewX, popupViewShowY);
    
    CJBasePopupInfo *popupInfo = [UIView addSubviewToPopupSuperview:popupSuperview
                                                withBlankViewBelong:CJBlankViewBelongPopupView
                                                          popupView:self
                                                    popupViewOrigin:popupViewOrigin
                                                      popupViewSize:popupViewSize];
    
    self.cjPopupAnimationType = CJAnimationTypeNormal;
    self.cjShowPopupViewCompleteBlock = showPopupViewCompleteBlock;
    self.cjTapBlankViewCompleteBlock = tapBlankViewCompleteBlock;
    [self popupWithViewInfo:popupInfo isToBottom:YES showBeforeConfigBlock:showBeforeConfigBlock showComplete:showPopupViewCompleteBlock tapBlankComplete:tapBlankViewCompleteBlock];
}


#pragma mark - Private Method
/*
 *  将本View以size大小添加到showInView视图中location位置
 *
 *  @param popupSuperview               弹出视图的父视图view
 *  @param blankViewBelong              blankView用哪个视图的属性来标记
 *  @param popupView                    要被添加的视图
 *  @param popupViewOrigin              弹出视图的左上角origin坐标
 *  @param popupViewSize                弹出视图的size大小
 */
+ (CJBasePopupInfo *)addSubviewToPopupSuperview:(nonnull UIView *)popupSuperview
                            withBlankViewBelong:(CJBlankViewBelong)blankViewBelong
                                      popupView:(UIView *)popupView
                                popupViewOrigin:(CGPoint)popupViewOrigin
                                  popupViewSize:(CGSize)popupViewSize
{
    CJPopupMainThreadAssert();
    
    if (CGSizeEqualToSize(popupView.frame.size, popupViewSize)) {
        NSLog(@"Warning:popupView视图大小将自动调整为指定的弹出视图大小");
        CGRect selfFrame = popupView.frame;
        selfFrame.size = popupViewSize;
        popupView.frame = selfFrame;
    }
    
    // popupView改成添加到blankView中
    CGRect popupViewShowFrame = CGRectMake(popupViewOrigin.x, popupViewOrigin.y,
                                           popupViewSize.width, popupViewSize.height);
    NSAssert(popupViewShowFrame.size.width != 0 && popupViewShowFrame.size.height != 0, @"弹出视图的宽高都不能为0");
    
    
    CJBasePopupInfo *popupInfo = [UIView addSubviewForPopupSuperview:popupSuperview
                                                 withBlankViewBelong:blankViewBelong
                                                           popupView:popupView];
    popupInfo.popupViewShowFrame = popupViewShowFrame;
    
    return popupInfo;
}


/*
 *  在popupSuperview上添加BlankView和popupView
 *
 *  @param popupSuperview           被添加到的地方
 *  @param blankViewBelong          blankView用哪个视图的属性来标记
 *  @param popupView                要被添加的视图
 *
 *  @return 添加的blankView和popupView
 */
+ (CJBasePopupInfo *)addSubviewForPopupSuperview:(UIView *)popupSuperview
                             withBlankViewBelong:(CJBlankViewBelong)blankViewBelong
                                       popupView:(UIView *)popupView
{
    if ([popupSuperview.subviews containsObject:popupView]) {
        return nil;
    }
    
    /* 1、popupSuperview添加空白的点击区域blankView */
    UIView *blankView;
    if (blankViewBelong == CJBlankViewBelongPopupView) {
        blankView = popupView.cjTapView;
    } else if (blankViewBelong == CJBlankViewBelongSuper) {
        blankView = popupSuperview.cjTapView;
    } else {
        blankView = popupView.cjTapView;
    }
    
    if (blankView == nil) { // 确保只有一个背景（否则弹出多个弹窗，容易叠加）
        blankView = [[UIView alloc] initWithFrame:CGRectZero];
        
        // 为了解决bug:将手势改为button，防止弹出的视图上有tableView或collectionView的时候，点击上面的cell会无法响应cell的点击事件，而变成响应tap的事件的bug
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:popupView action:@selector(cj_TapBlankViewAction:)];
//        [blankView addGestureRecognizer:tapGesture];
        UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //tapButton.backgroundColor = [UIColor redColor];
        [tapButton addTarget:popupView action:@selector(cj_TapBlankViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [UIView cjPopup_makeView:blankView addSubView:tapButton withEdgeInsets:UIEdgeInsetsZero];
        
        
        [UIView cjPopup_makeView:popupSuperview addSubView:blankView withEdgeInsets:UIEdgeInsetsZero];
//        [popupSuperview addSubview:blankView];
//        CGFloat blankViewWidth = CGRectGetWidth(popupSuperview.frame);
//        CGFloat blankViewHeight = CGRectGetHeight(popupSuperview.frame);
//        CGRect blankViewFrame = CGRectMake(0, 0, blankViewWidth, blankViewHeight);
//        [blankView setFrame:blankViewFrame];    // blankView直接添加上去，popupView的Frame才用来控制动画
        
        
        if (popupSuperview.cjPopupSuperviewSubview == nil) {
            popupSuperview.cjPopupSuperviewSubview = [[NSMutableArray alloc] init];
        }
        [popupSuperview.cjPopupSuperviewSubview addObject:blankView];
    }
    
    if (blankViewBelong == CJBlankViewBelongPopupView) {
        popupView.cjTapView = blankView;
    } else if (blankViewBelong == CJBlankViewBelongSuper) {
        popupSuperview.cjTapView = blankView;
    } else {
        popupView.cjTapView = blankView;
    }
    
    /* 2、blankView添加popupView */
    [blankView addSubview:popupView];   // popupView改成添加到blankView中
    
    CJBasePopupInfo *popupInfo = [[CJBasePopupInfo alloc] init];
    popupInfo.blankView = blankView;
    popupInfo.popupView = popupView;
    
    return popupInfo;
}


+ (void)cjPopup_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}


/*
 *  视图
 *
 *  @param popupViewShowFrame   popupViewShowFrame
 *  @param isToBottom           isToBottom
 *  @param animationType        animationType
 */
- (void)__popupViewToShowFrame:(CGRect)popupViewShowFrame
                    isToBottom:(BOOL)isToBottom
                 animationType:(CJAnimationType)animationType
{
    CGRect popupViewHideFrame = popupViewShowFrame;
    if (isToBottom) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow]; //
        popupViewHideFrame.origin.y = CGRectGetMaxY(keyWindow.frame);
    } else {
        popupViewHideFrame.size.height = 0;
    }
    
    
    self.cjPopupViewHideFrameString = NSStringFromCGRect(popupViewHideFrame);
    
    
    UIView *popupView = self;
    
    if (animationType == CJAnimationTypeNone) {
        popupView.frame = popupViewShowFrame;
        
    } else if (animationType == CJAnimationTypeNormal) {
        //popupViewHideFrame
        self.cjPopupViewHideFrameString = NSStringFromCGRect(popupViewHideFrame);
        
        //动画设置位置
        UIView *blankView = self.cjTapView;
        blankView.alpha = 0.2;
        popupView.alpha = 0.2;
        popupView.frame = popupViewHideFrame;
        [UIView animateWithDuration:kCJPopupAnimationDuration
                         animations:^{
                             blankView.alpha = 1.0;
                             popupView.alpha = 1.0;
                             popupView.frame = popupViewShowFrame;
                         }];
        
    } else if (animationType == CJAnimationTypeCATransform3D) {
        popupView.alpha = 1.0f; // 修复单例时候，在隐藏过后，想再显示，没法继续显示的问题
        popupView.frame = popupViewShowFrame;
        
        CATransform3D popupViewShowTransform = CATransform3DIdentity;
        
        CATransform3D rotate = CATransform3DMakeRotation(70.0*M_PI/180.0, 0.0, 0.0, 1.0);
        CATransform3D translate = CATransform3DMakeTranslation(20.0, -500.0, 0.0);
        CATransform3D popupViewHideTransform = CATransform3DConcat(rotate, translate);
        
        self.layer.transform = popupViewHideTransform;
        [UIView animateWithDuration:kCJPopupAnimationDuration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.layer.transform = popupViewShowTransform;
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }
}


#pragma mark - Event

/** 点击空白区域的事件 */
//- (void)cj_TapBlankViewAction:(UITapGestureRecognizer *)tapGR {
- (void)cj_TapBlankViewAction:(UIButton *)tapButton {
    if (self.cjTapBlankViewCompleteBlock) {
        self.cjTapBlankViewCompleteBlock();
    }
}


/** 完整的描述请参见文件头部 */
- (void)cj_hidePopupView {
    CJAnimationType animationType = self.cjPopupAnimationType;
    [self cj_hidePopupViewWithAnimationType:animationType];
}

/** 完整的描述请参见文件头部 */
- (void)cj_hidePopupViewWithAnimationType:(CJAnimationType)animationType {
    CJPopupMainThreadAssert();
    
    self.cjPopupViewShowing = NO;  //设置成NO表示当前未显示任何弹出视图
    [self endEditing:YES];
    
    UIView *popupView = self;
    UIView *tapView = self.cjTapView;
    
    switch (animationType) {
        case CJAnimationTypeNone:
        {
            [popupView removeFromSuperview];
            [tapView removeFromSuperview];
            break;
        }
        case CJAnimationTypeNormal:
        {
            CGRect popupViewHideFrame = CGRectFromString(self.cjPopupViewHideFrameString);
            if (CGRectEqualToRect(popupViewHideFrame, CGRectZero)) {
                popupViewHideFrame = self.frame;
            }
            
            [UIView animateWithDuration:kCJPopupAnimationDuration
                             animations:^{
                                 //要设置成0，不设置非零值如0.2，是为了防止在显示出来的时候，在0.3秒内很快按两次按钮，仍有view存在
                                 tapView.alpha = 0.0f;
                                 popupView.alpha = 0.0f;
                                 popupView.frame = popupViewHideFrame;
                                 
                             }completion:^(BOOL finished) {
                                 [popupView removeFromSuperview];
                                 [tapView removeFromSuperview];
                             }];
            break;
        }
        case CJAnimationTypeCATransform3D:
        {
            [UIView animateWithDuration:kCJPopupAnimationDuration
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 CATransform3D rotate = CATransform3DMakeRotation(-70.0 * M_PI / 180.0, 0.0, 0.0, 1.0);
                                 CATransform3D translate = CATransform3DMakeTranslation(-20.0, 500.0, 0.0);
                                 popupView.layer.transform = CATransform3DConcat(rotate, translate);
                                 
                             } completion:^(BOOL finished) {
                                 [popupView removeFromSuperview];
                                 [tapView removeFromSuperview];
                             }];
            break;
        }
    }
    
    UIView *blankView = self.cjTapView;
    [self.cjPopupSuperviewSubview removeObject:blankView];
}




@end
