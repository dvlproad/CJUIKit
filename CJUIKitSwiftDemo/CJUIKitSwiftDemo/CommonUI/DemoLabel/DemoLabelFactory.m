//
//  DemoLabelFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoLabelFactory.h"

@implementation DemoLabelFactory

+ (UILabel *)whiteLabelWithCornerRadius:(CGFloat)cornerRadius {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    //label.backgroundColor = [UIColor clearColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = cornerRadius;
    label.font = [UIFont systemFontOfSize:19];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

//+ (CJLabel *)trackLabel {
//
//}

+ (UILabel *)cyanLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor cyanColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.text = text;
    
    return label;
}

+ (UILabel *)testExplainLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor cyanColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    
    return label;
}

@end
