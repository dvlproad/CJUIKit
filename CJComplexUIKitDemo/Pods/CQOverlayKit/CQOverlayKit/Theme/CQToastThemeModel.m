//
//  CQToastThemeModel.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQToastThemeModel.h"

@implementation CQToastThemeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        // 黑底白字
        _textColor = [UIColor whiteColor];
        _bezelViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _hideAfterDelay = 2.0f;
    }
    return self;
}

@end
