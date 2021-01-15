//
//  UITextInputChangeResultModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UITextInputChangeResultModel.h"

@implementation UITextInputChangeResultModel

/*
 *  初始化
 *
 *  @param originReplacementString 原始的替换文本（未处理空格等之前的）
 *
 *  @return 模型
 */
- (instancetype)initWithOriginReplacementString:(NSString *)originReplacementString {
    self = [super init];
    if (self) {
        _originReplacementString = originReplacementString;
    }
    return self;
}

@end
