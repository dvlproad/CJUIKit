//
//  CQTSButtonFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSButtonFactory.h"

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


#pragma mark - 只文字按钮
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
