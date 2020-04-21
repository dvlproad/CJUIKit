//
//  CJMessageAlertView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseAlertView.h"

@interface CJMessageAlertView : CJBaseAlertView {
    
}
@property (nonatomic, strong) UIImageView *flagImageView;
@property (nonatomic, readonly) CGFloat flagImageViewHeight;

@property (nonatomic, strong) UIScrollView *messageScrollView;
@property (nonatomic, strong) UIView *messageContainerView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, assign) CGFloat messageLabelHeight;

- (instancetype)initWithFlagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                    okButtonTitle:(NSString *)okButtonTitle
                         okHandle:(void(^)(void))okHandle;

- (instancetype)initWithFlagImage:(UIImage *)flagImage
                            title:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
                    okButtonTitle:(NSString *)okButtonTitle
                     cancelHandle:(void(^)(void))cancelHandle
                         okHandle:(void(^)(void))okHandle;

/// 创建调试的弹窗
+ (instancetype)debugMessageAlertViewWithTitle:(NSString *)title
                                       message:(NSString *)message
                          shouldContailAppInfo:(BOOL)shouldContailAppInfo;

@end
