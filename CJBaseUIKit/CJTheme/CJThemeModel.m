//
//  CJThemeModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJThemeModel.h"
#include "UIColor+CJHex.h"

@implementation CJThemeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        // 总的默认主题
        _themeColor = CJColorFromHexString(@"#01adfeFF");
        _themeDisabledColor = CJColorFromHexString(@"#01adfe66");
        _themeOppositeColor = CJColorFromHexString(@"#FFFFFF");
        _themeOppositeDisabledColor = CJColorFromHexString(@"#FFFFFF4C");

        _separateLineColor = CJColorFromHexString(@"#E5E5E5");
        _textMainColor = CJColorFromHexString(@"#333333");
        _text666Color = CJColorFromHexString(@"#666666");
        _textAssistColor = CJColorFromHexString(@"#999999");
        _placeholderTextColor = CJColorFromHexString(@"#CCCCCC");

        _blankBGColor = CJColorFromHexString(@"#282828");
        _buttonThemeModel = [[CJButtonThemeModel alloc] init];
    }
    return self;
}

@end




@implementation CJButtonThemeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        // Button的默认主题
        _cornerRadius = 15;
        _selectedBorderWidth = 0.5;
    }
    return self;
}

@end
