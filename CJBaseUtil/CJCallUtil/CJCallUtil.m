//
//  CJCallUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJCallUtil.h"

@implementation CJCallUtil

+ (void)callPhoneWithNum:(NSString *)phoneNum atView:(UIView *)atView
{
    //去掉特殊字符
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞<>$%^&*)_+ "];
    phoneNum = [[phoneNum componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    
    
    //去掉字母
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z.-]" options:0 error:NULL];
    
    phoneNum = [regular stringByReplacingMatchesInString:phoneNum options:0 range:NSMakeRange(0, [phoneNum length]) withTemplate:@""];
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Warning:模拟器无法拨打电话,请使用真机测试(附电话：%@)", phoneNum);
#else
    NSMutableString *telString = [[NSMutableString alloc] initWithFormat:@"tel:%@", phoneNum];
    UIWebView *callWebview = [[UIWebView alloc] init];
    
    NSURL *URL = [NSURL URLWithString:telString];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
    [callWebview loadRequest:URLRequest];
    [atView addSubview:callWebview];
#endif
}

@end
