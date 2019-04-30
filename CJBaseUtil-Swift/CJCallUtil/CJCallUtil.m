//
//  CJCallUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/23.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJCallUtil.h"

@interface CJCallUtil () {
    
}
@property (nonatomic, strong) UIWebView *callWebview;    /**< 拨打电话Webview */

@end

@implementation CJCallUtil

+ (CJCallUtil *)sharedInstance {
    static CJCallUtil *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (void)showCallViewWithPhone:(NSString *)phoneNum atView:(UIView *)atView {
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"模拟器不支持拨打电话");
    return;
#endif
    
    if (![CJCallUtil sharedInstance].callWebview) {
        UIWebView *callWebview = [[UIWebView alloc] init];
        [atView addSubview:callWebview];
        
        [CJCallUtil sharedInstance].callWebview = callWebview;
    }
    
    
    //去掉特殊字符
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞<>$%^&*)_+ "];
    phoneNum = [[phoneNum componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    
    //去掉字母
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z.-]" options:0 error:NULL];
    
    phoneNum = [regular stringByReplacingMatchesInString:phoneNum options:0 range:NSMakeRange(0, [phoneNum length]) withTemplate:@""];
    NSMutableString *telString = [[NSMutableString alloc] initWithFormat:@"tel:%@", phoneNum];
    NSURL *URL = [NSURL URLWithString:telString];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
    [[CJCallUtil sharedInstance].callWebview loadRequest:URLRequest];
}

+ (void)hideCallView {
    if ([CJCallUtil sharedInstance].callWebview) {
        [[CJCallUtil sharedInstance].callWebview removeFromSuperview];
        [CJCallUtil sharedInstance].callWebview = nil;
    }
}

@end
