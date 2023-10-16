//
//  CQTSButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSButtonFactory.h"
#import "UIButton+CQTSMoreProperty.h"

@interface CQTSButtonFactory () {
    
}
@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, strong) UIColor *themeDisabledColor;
@property (nonatomic, strong) UIColor *themeOppositeColor;
@property (nonatomic, strong) UIColor *themeOppositeDisabledColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat selectedBorderWidth;

@end

@implementation CQTSButtonFactory

+ (CQTSButtonFactory *)sharedInstance {
    static CQTSButtonFactory *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _themeColor = [UIColor colorWithRed:1/255.0f green:173/255.0f blue:254/255.0f alpha:1.0];  // @"#01adfeFF");
        _themeDisabledColor = [UIColor colorWithRed:1/255.0f green:173/255.0f blue:254/255.0f alpha:0.6];  // (@"#01adfe66");
        _themeOppositeColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];  // (@"#FFFFFF");
        _themeOppositeDisabledColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.4];  // (@"#FFFFFF4C");

        _cornerRadius = 15;
        _selectedBorderWidth = 0.5;
    }
    return self;
}


#pragma mark - themeBGButton
/// 以主题色为背景的按钮
+ (UIButton *)themeBGButton {
    UIColor *themeColor = [CQTSButtonFactory sharedInstance].themeColor;
    UIColor *themeDisabledColor = [CQTSButtonFactory sharedInstance].themeDisabledColor;
    UIColor *themeOppositeColor = [CQTSButtonFactory sharedInstance].themeOppositeColor;
    CGFloat buttonCornerRadius = [CQTSButtonFactory sharedInstance].cornerRadius;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = buttonCornerRadius;
    
    [button setTitleColor:themeOppositeColor forState:UIControlStateNormal];
    
    //button.cjNormalBGColor = themeOppositeColor;
    //button.cjDisabledBGColor = themeOppositeDisabledColor;
    UIImage *normalBGImage = cqts_buttonBGImage(themeColor);
    [button setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    UIImage *disabledBGImage = cqts_buttonBGImage(themeDisabledColor);
    [button setBackgroundImage:disabledBGImage forState:UIControlStateNormal | UIControlStateDisabled];
    
    return button;
}

+ (UIButton *)themeBGButtonWithTitle:(NSString *)title
                         actionBlock:(void(^)(UIButton *bButton))actionBlock
{
    UIButton *button = [CQTSButtonFactory themeBGButton];
    [button setTitle:title forState:UIControlStateNormal];
    button.cqtsTouchUpInsideBlock = ^(UIButton *bButton) {
        !actionBlock ?: actionBlock(bButton);
    };
    
    return button;
}

#pragma mark - themeBorderButton
///以主题色为边框的按钮
+ (UIButton *)themeBorderButton {
    UIColor *themeColor = [CQTSButtonFactory sharedInstance].themeColor;
    UIColor *themeOppositeColor = [CQTSButtonFactory sharedInstance].themeOppositeColor;
    UIColor *themeOppositeDisabledColor = [CQTSButtonFactory sharedInstance].themeOppositeDisabledColor;
    CGFloat buttonCornerRadius = [CQTSButtonFactory sharedInstance].cornerRadius;
    CGFloat buttonSelectedBorderWidth = [CQTSButtonFactory sharedInstance].selectedBorderWidth;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = buttonCornerRadius;
    button.layer.borderWidth = buttonSelectedBorderWidth;
    button.layer.borderColor = themeColor.CGColor;
    
    [button setTitleColor:themeColor forState:UIControlStateNormal];
    //button.cjNormalBGColor = themeOppositeColor;
    //button.cjDisabledBGColor = themeOppositeDisabledColor;
    UIImage *normalBGImage = cqts_buttonBGImage(themeOppositeColor);
    [button setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    UIImage *disabledBGImage = cqts_buttonBGImage(themeOppositeDisabledColor);
    [button setBackgroundImage:disabledBGImage forState:UIControlStateNormal | UIControlStateDisabled];
    
    return button;
}

+ (UIButton *)themeBorderButtonWithTitle:(NSString *)title
                             actionBlock:(void(^)(UIButton *bButton))actionBlock
{
    UIButton *button = [CQTSButtonFactory themeBorderButton];
    [button setTitle:title forState:UIControlStateNormal];
    button.cqtsTouchUpInsideBlock = ^(UIButton *bButton) {
        !actionBlock ?: actionBlock(bButton);
    };
    
    return button;
}


#pragma mark - submitButton
/*
 *  "重现bug"/"重现bug"的状态选择按钮(默认是bug已重现待修复的状态)
 *  @param fixBugHandle             修复bug要执行的操作
 *  @param reproduceBugHandle       重现bug要执行的操作
 */
+ (UIButton *)bugButtonWithFixBugHandle:(void(^)(void))fixBugHandle reproduceBugHandle:(void(^)(void))reproduceBugHandle {
    UIButton *bugStateButton = [CQTSButtonFactory submitButtonWithSubmitTitle:@"重现bug" editTitle:@"修复bug" showEditTitle:YES clickSubmitTitleHandle:^(UIButton * _Nonnull button) {
        button.selected = !button.selected;
        !fixBugHandle ?: fixBugHandle();
    } clickEditTitleHandle:^(UIButton * _Nonnull button) {
        button.selected = !button.selected;
        !reproduceBugHandle ?: reproduceBugHandle();
    }];
    return bugStateButton;
}
/*
 *  "提交"/"修改"状态选择按钮(if you want to show editTitle, you should make selected == YES)
 *
 *  @param submitTitle              submitTitle(current selected should be YES)
 *  @param editTitle                editTitle(current selected should be NO)
 *  @param showEditTitle            showEditTitle(if you want to show editTitle, you should make selected == YES)
 *  @param clickSubmitTitleHandle   click submitTitle action
 *  @param clickEditTitleHandle     click editTitle action
 */
+ (UIButton *)submitButtonWithSubmitTitle:(NSString *)submitTitle
                                editTitle:(NSString *)editTitle
                            showEditTitle:(BOOL)showEditTitle
                   clickSubmitTitleHandle:(void(^)(UIButton *button))clickSubmitTitleHandle
                     clickEditTitleHandle:(void(^)(UIButton *button))clickEditTitleHandle
{
    UIButton *submitButton = [self themeNormalSelectedButtonWithNormalTitle:submitTitle selectedTitle:editTitle];
    submitButton.selected = showEditTitle;
    submitButton.cqtsTouchUpInsideBlock = ^(UIButton *bButton) {
        if (bButton.selected) {
            !clickEditTitleHandle ?: clickEditTitleHandle(bButton);
        } else {
            !clickSubmitTitleHandle ?: clickSubmitTitleHandle(bButton);
        }
    };
    
    return submitButton;
}

/// 有状态切换的按钮
+ (CQTSBorderStateButton *)themeNormalSelectedButtonWithNormalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle {
    UIColor *themeColor = [CQTSButtonFactory sharedInstance].themeColor;
    UIColor *themeDisabledColor = [CQTSButtonFactory sharedInstance].themeDisabledColor;
    UIColor *themeOppositeColor = [CQTSButtonFactory sharedInstance].themeOppositeColor;
    UIColor *themeOppositeDisabledColor = [CQTSButtonFactory sharedInstance].themeOppositeDisabledColor;
    CGFloat buttonCornerRadius = [CQTSButtonFactory sharedInstance].cornerRadius;
    CGFloat buttonSelectedBorderWidth = [CQTSButtonFactory sharedInstance].selectedBorderWidth;
    
    CQTSBorderStateButton *button = [CQTSBorderStateButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = buttonCornerRadius;
    button.cjNormalBorderWidth = 0;
    button.cjSelectedBorderWidth = buttonSelectedBorderWidth;
    
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitleColor:themeOppositeColor forState:UIControlStateNormal];
//    [button setTitleColor:themeOppositeColor forState:UIControlStateNormal | UIControlStateDisabled];
//    button.cjNormalBGColor = themeColor;
    UIImage *normalBGImage = cqts_buttonBGImage(themeColor);
    [button setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    button.cjNormalBorderColor = themeColor;
//    button.cjDisabledBGColor = themeDisabledColor;
    UIImage *disabledBGImage = cqts_buttonBGImage(themeDisabledColor);
    [button setBackgroundImage:disabledBGImage forState:UIControlStateNormal | UIControlStateDisabled];
    button.cjDisabledBorderColor = themeDisabledColor;
    
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button setTitleColor:themeColor forState:UIControlStateSelected];
//    [button setTitleColor:themeColor forState:UIControlStateSelected | UIControlStateNormal];
    [button setTitleColor:themeDisabledColor forState:UIControlStateSelected | UIControlStateDisabled];
//    button.cjSelectedBGColor = themeOppositeColor;
    UIImage *selectedBGImage = cqts_buttonBGImage(themeOppositeColor);
    [button setBackgroundImage:selectedBGImage forState:UIControlStateSelected];
    button.cjSelectedBorderColor = themeColor;
//    button.cjSelectedDisabledBGColor = themeOppositeDisabledColor;
    UIImage *selectedDisabledBGImage = cqts_buttonBGImage(themeOppositeDisabledColor);
    [button setBackgroundImage:selectedDisabledBGImage forState:UIControlStateSelected | UIControlStateDisabled];
    button.cjSelectedDisabledBorderColor = themeDisabledColor;
    
    return button;
}


/// 使用颜色构建的背景图片
UIImage *cqts_buttonBGImage(UIColor *bgColor) {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [bgColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *normalBGImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return normalBGImage;
}

@end
