//
//  DemoAlert.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoAlert.h"
#import "DemoButtonFactory.h"
#import <CJFoundation/NSString+CJTextSize.h>
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>
#import <CJBaseHelper/AuthorizationCJHelper.h>

@interface DemoAlert () {
    
}
@property (nonatomic, strong) CJAlertView *networkNoOpenAlert;      /**< 网络权限没打开的alert */
@property (nonatomic, strong) CJAlertView *locationNoOpenAlert;     /**< 定位权限没打开的alert */
@property (nonatomic, strong) CJAlertView *locationAbnormalAlert;   /**< 定位权限异常的alert */


@end



@implementation DemoAlert

+ (DemoAlert *)sharedInstance {
    static DemoAlert *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

///显示只有一个 "我知道了" 的 alertView
+ (void)showIKnowAlertViewWithTitle:(NSString *)title {
    [DemoAlert showAlertViewWithTitle:title
                          okButtonTitle:NSLocalizedString(@"我知道了", nil)
                               okHandle:nil];
}

/*
///显示 "取消" + "确定" 的 alertView
+ (void)showCancelAndOKAlertViewWithTitle:(NSString *)title
                             cancelHandle:(void(^)(void))cancelHandle
                                 okHandle:(void(^)(void))okHandle
{
    [DemoAlert showAlertViewWithTitle:title
                      cancelButtonTitle:NSLocalizedString(@"取消", nil)
                          okButtonTitle:NSLocalizedString(@"确定", nil)
                           cancelHandle:cancelHandle
                               okHandle:okHandle];
}
*/


///显示和隐藏网络权限没打开的alert
+ (void)showNetworkNoOpenAlert:(BOOL)show {
    if (!show) {
        if ([DemoAlert sharedInstance].networkNoOpenAlert) {
            [[DemoAlert sharedInstance].networkNoOpenAlert dismissWithDelay:0];
            [DemoAlert sharedInstance].networkNoOpenAlert = nil;
        }
    } else {
        if ([DemoAlert sharedInstance].networkNoOpenAlert) {
            return;
        }
        [DemoAlert sharedInstance].networkNoOpenAlert = [self alertViewWithTitle:NSLocalizedString(@"网络链接失败，请检查您的网络链接", nil) okButtonTitle:NSLocalizedString(@"查看设置", nil) okHandle:^{
            [DemoAlert sharedInstance].networkNoOpenAlert = nil;
            [AuthorizationCJHelper openSettingWithCompletionHandler:nil];
        }];
        UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        [[DemoAlert sharedInstance].networkNoOpenAlert showWithShouldFitHeight:YES blankBGColor:blankBGColor];
    }
}

///显示和隐藏定位权限没打开的alert
+ (void)showLocationNoOpenAlert:(BOOL)show {
    if (!show) {
        if ([DemoAlert sharedInstance].locationNoOpenAlert) {
            [[DemoAlert sharedInstance].locationNoOpenAlert dismissWithDelay:0];
            [DemoAlert sharedInstance].locationNoOpenAlert = nil;
        }
    } else {
        [self showLocationAbnormalAlert:NO]; //隐藏定位权限异常的alert
        if ([DemoAlert sharedInstance].locationNoOpenAlert) {
            return;
        }
        [DemoAlert sharedInstance].locationNoOpenAlert = [self alertViewWithTitle:NSLocalizedString(@"您没开启GPS，无法接单", nil) okButtonTitle:NSLocalizedString(@"去开启", nil) okHandle:^{
            [DemoAlert sharedInstance].locationNoOpenAlert = nil;
            [AuthorizationCJHelper openSettingWithCompletionHandler:nil];
        }];
        UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        [[DemoAlert sharedInstance].locationNoOpenAlert showWithShouldFitHeight:YES blankBGColor:blankBGColor];
    }
}

///显示和隐藏定位权限异常的alert
+ (void)showLocationAbnormalAlert:(BOOL)show {
    if (!show) {
        if ([DemoAlert sharedInstance].locationAbnormalAlert) {
            [[DemoAlert sharedInstance].locationAbnormalAlert dismissWithDelay:0];
            [DemoAlert sharedInstance].locationAbnormalAlert = nil;
        }
    } else {
        [self showLocationNoOpenAlert:NO]; //隐藏定位权限没打开的alert
        if ([DemoAlert sharedInstance].locationAbnormalAlert) {
            return;
        }
        [DemoAlert sharedInstance].locationAbnormalAlert = [self alertViewWithTitle:NSLocalizedString(@"获取定位权限异常，请手动授权APP定位权限", nil) okButtonTitle:NSLocalizedString(@"我知道了", nil) okHandle:^{
            [DemoAlert sharedInstance].locationAbnormalAlert = nil;
            [AuthorizationCJHelper openSettingWithCompletionHandler:nil];
        }];
        UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        [[DemoAlert sharedInstance].locationAbnormalAlert showWithShouldFitHeight:YES blankBGColor:blankBGColor];
    }
}


#pragma mark - 当需要自定义alert上的按钮的时候使用如下方法
///显示自定义 "OK" 的 alertView
+ (void)showAlertViewWithTitle:(NSString *)title
                 okButtonTitle:(NSString *)okButtonTitle
                      okHandle:(void(^)(void))okHandle
{
    CJAlertView *alertView = [self alertViewWithTitle:title okButtonTitle:okButtonTitle okHandle:okHandle];
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [alertView showWithShouldFitHeight:YES blankBGColor:blankBGColor];
}

+ (CJAlertView *)alertViewWithTitle:(NSString *)title
                      okButtonTitle:(NSString *)okButtonTitle
                           okHandle:(void(^)(void))okHandle
{
    CGSize popupViewSize = CGSizeMake(290, 150);
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:40 secondVerticalInterval:0 thirdVerticalInterval:0 bottomMinVerticalInterval:40];
    
    //title
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5;
    [alertView addTitleWithText:title font:[UIFont systemFontOfSize:17.0] textAlignment:NSTextAlignmentCenter margin:10 paragraphStyle:paragraphStyle];
    
    //bottomButtons
    UIButton *okButton = [DemoButtonFactory blueButton];
    [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
    [okButton setCjTouchUpInsideBlock:^(UIButton *button) {
        [alertView dismissWithDelay:0];
        if (okHandle) {
            okHandle();
        }
    }];
    
    //NSArray<UIButton *> *bottomButtons = @[okButton];
    //[alertView addBottomButtons:bottomButtons withHeight:44 bottomInterval:15 alongAxis:MASAxisTypeHorizontal fixedSpacing:10 leadSpacing:15 tailSpacing:15];
    [alertView addOnlyOneBottomButton:okButton withHeight:44 bottomInterval:15 leftOffset:15 rightOffset:15];
    
    return alertView;
}

///显示自定义 "Cancel" + "OK" 的 alertView
+ (void)showAlertViewWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
                 okButtonTitle:(NSString *)okButtonTitle
                  cancelHandle:(void(^)(void))cancelHandle
                      okHandle:(void(^)(void))okHandle
{
    CGSize popupViewSize = CGSizeMake(290, 150);
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:40 secondVerticalInterval:0 thirdVerticalInterval:0 bottomMinVerticalInterval:40];
    
    //title
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5;
    [alertView addTitleWithText:title font:[UIFont systemFontOfSize:17.0] textAlignment:NSTextAlignmentCenter margin:10 paragraphStyle:paragraphStyle];
    
    //bottomButtons
    UIButton *cancelButton = [DemoButtonFactory whiteButton];
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton setCjTouchUpInsideBlock:^(UIButton *button) {
        [alertView dismissWithDelay:0];
        if (cancelHandle) {
            cancelHandle();
        }
    }];
    
    UIButton *okButton = [DemoButtonFactory blueButton];
    [okButton setTitle:okButtonTitle forState:UIControlStateNormal];
    [okButton setCjTouchUpInsideBlock:^(UIButton *button) {
        [alertView dismissWithDelay:0];
        if (okHandle) {
            okHandle();
        }
    }];
    
    NSArray<UIButton *> *bottomButtons = @[cancelButton, okButton];
    [alertView addBottomButtons:bottomButtons withHeight:36 bottomInterval:15 alongAxis:MASAxisTypeHorizontal fixedSpacing:10 leadSpacing:15 tailSpacing:15];
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [alertView showWithShouldFitHeight:YES blankBGColor:blankBGColor];
}

///显示 "errorToast" 的 alertView
+ (void)showErrorToastAlertViewTitle:(NSString *)title
{
    if (title.length == 0) {
        return;
    }
    
    CGFloat textWidth = [title cjTextWidthWithFont:[UIFont systemFontOfSize:17.0]] > 160 ? 290 : 160;
    CGSize popupViewSize = CGSizeMake(textWidth, 150); //登录时候的账号密码错误是160的宽
    
    CJAlertView *alertView = [[CJAlertView alloc] initWithSize:popupViewSize firstVerticalInterval:20 secondVerticalInterval:15 thirdVerticalInterval:0 bottomMinVerticalInterval:19];
    
    alertView.backgroundColor = CJColorFromHexStringAndAlpha(@"#000000", 0.76);
    
    //image
    UIImage *errorImage = [UIImage imageNamed:@"cjdemo_toast_error"];
    [alertView addFlagImage:errorImage size:CGSizeMake(27, 27)];
    
    //title
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5;
    [alertView addTitleWithText:title font:[UIFont systemFontOfSize:17.0] textAlignment:NSTextAlignmentCenter margin:10 paragraphStyle:paragraphStyle];
    [alertView updateTitleTextColor:[UIColor whiteColor]];
    
    [alertView showWithShouldFitHeight:YES blankBGColor:[UIColor clearColor]];
    
    // dismiss
    [alertView dismissWithDelay:0.7];
}


@end
