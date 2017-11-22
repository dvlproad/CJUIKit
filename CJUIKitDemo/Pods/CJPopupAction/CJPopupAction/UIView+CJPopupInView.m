//
//  UIView+CJPopupInView.m
//  CJPopupViewDemo
//
//  Created by lichq on 15/11/12.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import "UIView+CJPopupInView.h"

static CGFloat kPopupAnimationDuration = 0.3;

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

@property (nonatomic, assign) CJAnimationType cjPopupAnimationType; /**< 弹出视图的动画方式 */
@property (nonatomic, copy) NSString *cjPopupViewHideFrameString;   /**< 弹出视图隐藏时候的frame */
//@property (nonatomic, assign) CATransform3D cjPopupViewHideTransform;/**< 弹出视图隐藏时候的transform */

@property (nonatomic, strong) UIView *cjShowInView; /**< 弹出视图被add到的view */
@property (nonatomic, strong) UIView *cjTapView;    /**< 空白区域 */

@property (nonatomic, copy) CJTapBlankViewCompleteBlock cjTapBlankViewCompleteBlock;    /**< 点击空白区域执行的操作 */
@property (nonatomic, copy) CJShowPopupViewCompleteBlock cjShowPopupViewCompleteBlock;    /**< 显示弹出视图后的操作 */

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
- (CJTapBlankViewCompleteBlock)cjTapBlankViewCompleteBlock {
    return objc_getAssociatedObject(self, &cjTapBlankViewCompleteBlockKey);
}

- (void)setCjTapBlankViewCompleteBlock:(CJTapBlankViewCompleteBlock)cjTapBlankViewCompleteBlock {
    return objc_setAssociatedObject(self, &cjTapBlankViewCompleteBlockKey, cjTapBlankViewCompleteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//cjShowPopupViewCompleteBlock
- (CJShowPopupViewCompleteBlock)cjShowPopupViewCompleteBlock {
    return objc_getAssociatedObject(self, &cjShowPopupViewCompleteBlockKey);
}

- (void)setCjShowPopupViewCompleteBlock:(CJShowPopupViewCompleteBlock)cjShowPopupViewCompleteBlock {
    return objc_setAssociatedObject(self, &cjShowPopupViewCompleteBlockKey, cjShowPopupViewCompleteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


//cjPopupViewShowing
- (BOOL)isCJPopupViewShowing {
    return [objc_getAssociatedObject(self, &cjPopupViewShowingKey) boolValue];
}

- (void)setCjPopupViewShowing:(BOOL)cjPopupViewShowing {
    return objc_setAssociatedObject(self, &cjPopupViewShowingKey, @(cjPopupViewShowing), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - 底层接口
/** 完整的描述请参见文件头部 */
- (void)cj_popupInView:(UIView *)popupSuperview
            atLocation:(CGPoint)location
              withSize:(CGSize)size
          showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
      tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock
{
    
    self.cjPopupAnimationType = CJAnimationTypeNormal;
    
    UIView *popupView = self;
    
    
    UIView *blankView = self.cjTapView;
    if (blankView) {
        [blankView removeFromSuperview];
        [popupView removeFromSuperview];
    }
    if (blankView == nil) { //tapV是指radioButtons组合下的点击区域（不包括radioButtons区域），用来点击之后隐藏列表
        blankView = [[UIView alloc] initWithFrame:CGRectZero];
        blankView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cj_TapBlankViewAction:)];
        [blankView addGestureRecognizer:tapGesture];
    }
    [popupSuperview addSubview:blankView];
    [popupSuperview addSubview:popupView];
    
    self.cjShowInView = popupSuperview;
    self.cjTapView = blankView;
    self.cjPopupViewShowing = YES;
    self.cjShowPopupViewCompleteBlock = showPopupViewCompleteBlock;
    self.cjTapBlankViewCompleteBlock = tapBlankViewCompleteBlock;
    
    
    
    
    CGFloat popupViewX = location.x;
    CGFloat popupViewY = location.y;
    CGFloat popupViewWidth = size.width;
    CGFloat popupViewShowHeight = size.height;
    CGFloat popupViewHideHeight = 0;
    CGRect popupViewShowFrame = CGRectMake(popupViewX,
                                           popupViewY,
                                           popupViewWidth,
                                           popupViewShowHeight);
    CGRect popupViewHideFrame = CGRectMake(popupViewX,
                                           popupViewY,
                                           popupViewWidth,
                                           popupViewHideHeight);
    self.cjPopupViewHideFrameString = NSStringFromCGRect(popupViewHideFrame);
    
    CGFloat blankViewX = location.x;
    CGFloat blankViewY = location.y;
    CGFloat blankViewWidth = size.width;
    CGFloat blankViewHeight = CGRectGetHeight(popupSuperview.frame) - CGRectGetMinY(popupViewShowFrame);
    CGRect blankViewFrame = CGRectMake(blankViewX,
                                       blankViewY,
                                       blankViewWidth,
                                       blankViewHeight);
    [blankView setFrame:blankViewFrame];
    
    
    //动画设置位置
    blankView.alpha = 0.2;
    popupView.alpha = 0.2;
    popupView.frame = popupViewHideFrame;
    [UIView animateWithDuration:kPopupAnimationDuration
                     animations:^{
                         blankView.alpha = 1.0;
                         popupView.alpha = 1.0;
                         popupView.frame = popupViewShowFrame;
                     }];
    
    if(showPopupViewCompleteBlock){
        showPopupViewCompleteBlock();
    }
}


/** 完整的描述请参见文件头部 */
- (void)cj_popupInWindowAtPosition:(CJWindowPosition)windowPosition
                     animationType:(CJAnimationType)animationType
                      showComplete:(CJShowPopupViewCompleteBlock)showPopupViewCompleteBlock
                  tapBlankComplete:(CJTapBlankViewCompleteBlock)tapBlankViewCompleteBlock
{
    
    self.cjPopupAnimationType = animationType;
    
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    
    UIView *popupView = self;
    UIView *popupSuperview = keywindow;
    if ([popupSuperview.subviews containsObject:popupView]) {
        return;
    }
    
    
    UIView *blankView = self.cjTapView;
    if (blankView) {
        [blankView removeFromSuperview];
        [popupView removeFromSuperview];
    }
    if (blankView == nil) { //tapV是指radioButtons组合下的点击区域（不包括radioButtons区域），用来点击之后隐藏列表
        blankView = [[UIView alloc] initWithFrame:CGRectZero];
        blankView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cj_TapBlankViewAction:)];
        [blankView addGestureRecognizer:tapGesture];
    }
    [popupSuperview addSubview:blankView];
    [popupSuperview addSubview:popupView];
    
    self.cjShowInView = popupSuperview;
    self.cjTapView = blankView;
    self.cjPopupViewShowing = YES;
    self.cjShowPopupViewCompleteBlock = showPopupViewCompleteBlock;
    self.cjTapBlankViewCompleteBlock = tapBlankViewCompleteBlock;
    
    /* popupView的一些设置 */
    popupView.layer.shadowColor = [[UIColor blackColor] CGColor];
    popupView.layer.shadowOffset = CGSizeMake(0, -2);
    popupView.layer.shadowRadius = 5.0;
    popupView.layer.shadowOpacity = 0.8;
    
    
    
    
    CGFloat blankViewX = 0;
    CGFloat blankViewY = 0;
    CGFloat blankViewWidth = CGRectGetWidth(keywindow.frame);
    CGFloat blankViewHeight = CGRectGetHeight(keywindow.frame);;
    CGRect blankViewFrame = CGRectMake(blankViewX,
                                       blankViewY,
                                       blankViewWidth,
                                       blankViewHeight);
    [blankView setFrame:blankViewFrame];
    
    switch (windowPosition) {
        case CJWindowPositionBottom:
        {
            //popupViewShowFrame
            CGFloat popupViewX = 0;
            CGFloat popupViewShowY = CGRectGetHeight(keywindow.frame) - CGRectGetHeight(popupView.frame);
            CGFloat popupViewWidth = CGRectGetWidth(keywindow.frame);
            CGFloat popupViewHeight = CGRectGetHeight(popupView.frame);
            
            CGRect popupViewShowFrame = CGRectZero;
            popupViewShowFrame = CGRectMake(popupViewX,
                                            popupViewShowY,
                                            popupViewWidth,
                                            popupViewHeight);
            
            
            
            
            
            if (animationType == CJAnimationTypeNone) {
                popupView.frame = popupViewShowFrame;
                
            } else if (animationType == CJAnimationTypeNormal) {
                //popupViewHideFrame
                CGRect popupViewHideFrame = popupViewShowFrame;
                popupViewHideFrame.origin.y = CGRectGetMaxY(keywindow.frame);
                self.cjPopupViewHideFrameString = NSStringFromCGRect(popupViewHideFrame);
                
                //动画设置位置
                blankView.alpha = 0.2;
                popupView.alpha = 0.2;
                popupView.frame = popupViewHideFrame;
                [UIView animateWithDuration:kPopupAnimationDuration
                                 animations:^{
                                     blankView.alpha = 1.0;
                                     popupView.alpha = 1.0;
                                     popupView.frame = popupViewShowFrame;
                                 }];
                
            } else if (animationType == CJAnimationTypeCATransform3D) {
                popupView.frame = popupViewShowFrame;
                
                CATransform3D popupViewShowTransform = CATransform3DIdentity;
                
                CATransform3D rotate = CATransform3DMakeRotation(70.0*M_PI/180.0, 0.0, 0.0, 1.0);
                CATransform3D translate = CATransform3DMakeTranslation(20.0, -500.0, 0.0);
                CATransform3D popupViewHideTransform = CATransform3DConcat(rotate, translate);
                
                self.layer.transform = popupViewHideTransform;
                [UIView animateWithDuration:kPopupAnimationDuration
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     self.layer.transform = popupViewShowTransform;
                                 } completion:^(BOOL finished) {
                                     
                                 }];
                
            }
            
            break;
        }
        case CJWindowPositionCenter:
        {
            if (animationType == CJAnimationTypeNone) {
                popupView.center = popupSuperview.center;
                
            } else if (animationType == CJAnimationTypeNormal) {
                popupView.center = popupSuperview.center;
                
            } else if (animationType == CJAnimationTypeCATransform3D) {
                popupView.center = popupSuperview.center;
                
                CATransform3D popupViewShowTransform = CATransform3DIdentity;
                
                CATransform3D rotate = CATransform3DMakeRotation(70.0*M_PI/180.0, 0.0, 0.0, 1.0);
                CATransform3D translate = CATransform3DMakeTranslation(20.0, -500.0, 0.0);
                CATransform3D popupViewHideTransform = CATransform3DConcat(rotate, translate);
                
                self.layer.transform = popupViewHideTransform;
                [UIView animateWithDuration:kPopupAnimationDuration
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     self.layer.transform = popupViewShowTransform;
                                 } completion:^(BOOL finished) {
                                     
                                 }];
                
            }
            break;
        }
        default:
        {
            break;
        }
    }
    
    
    if(showPopupViewCompleteBlock){
        showPopupViewCompleteBlock();
    }
}


/** 点击空白区域的事件 */
- (void)cj_TapBlankViewAction:(UITapGestureRecognizer *)tap {
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
            [UIView animateWithDuration:kPopupAnimationDuration
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
            [UIView animateWithDuration:kPopupAnimationDuration
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
}




@end
