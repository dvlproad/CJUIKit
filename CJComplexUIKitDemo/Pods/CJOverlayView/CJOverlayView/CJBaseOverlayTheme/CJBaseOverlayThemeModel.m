//
//  CJBaseOverlayThemeModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseOverlayThemeModel.h"

@implementation CJBaseOverlayThemeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        // 总的默认主题
        _commonThemeModel = [[CJOverlayCommonThemeModel alloc] init];
        _alertThemeModel = [[CJAlertThemeModel alloc] initWithCloseWithActionButtonHeight:45];
        //_alertThemeModel = [[CJAlertThemeModel alloc] initWithSpaceWithActionButtonHeight:45 bottomButtonsLeftOffset:15 bottomButtonsFixedSpacing:10];
        _sheetThemeModel = [[CJOverlaySheetThemeModel alloc] init];
        _sheetThemeModel.bottomLineHeight = 1;
        _sheetThemeModel.bottomLineColor = _commonThemeModel.separateLineColor;
        _sheetThemeModel.section0FooterHeight = 10;
    }
    return self;
}

@end
