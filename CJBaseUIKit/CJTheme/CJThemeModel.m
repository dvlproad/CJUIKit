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
/**
 *  总的默认主题
 *
 *  @return 总的默认主题
 */
+ (CJThemeModel *)defaultThemeModel {
    CJThemeModel *totalThemeModel = [[CJThemeModel alloc] init];
    
    totalThemeModel.themeColor = CJColorFromHexString(@"#01adfeFF");
    totalThemeModel.themeDisabledColor = CJColorFromHexString(@"#01adfe66");
    totalThemeModel.themeOppositeColor = CJColorFromHexString(@"#FFFFFF");
    totalThemeModel.themeOppositeDisabledColor = CJColorFromHexString(@"#FFFFFF4C");
    
//    totalThemeModel.themeColor = CJColorFromHexString(@"#192B93FF");
//    totalThemeModel.themeDisabledColor = CJColorFromHexString(@"#192B9366");
//    totalThemeModel.themeOppositeColor = CJColorFromHexString(@"#FFFFFF");
//    totalThemeModel.themeOppositeDisabledColor = CJColorFromHexString(@"#FFFFFF4C");
    
//    totalThemeModel.themeColor = CJColorFromHexString(@"#FF0000");
//    totalThemeModel.themeDisabledColor = CJColorFromHexString(@"#00FF00");
//    totalThemeModel.themeOppositeColor = CJColorFromHexString(@"#0000FF");
//    totalThemeModel.themeOppositeDisabledColor = CJColorFromHexString(@"#FFFFFF");
    
    totalThemeModel.separateLineColor = CJColorFromHexString(@"#E5E5E5");
    totalThemeModel.textMainColor = CJColorFromHexString(@"#333333");
    totalThemeModel.text666Color = CJColorFromHexString(@"#666666");
    totalThemeModel.textAssistColor = CJColorFromHexString(@"#999999");
    totalThemeModel.placeholderTextColor = CJColorFromHexString(@"#CCCCCC");
    
    totalThemeModel.blankBGColor = CJColorFromHexString(@"#282828");
    totalThemeModel.buttonThemeModel = [CJButtonThemeModel defaultButtonThemeModel];
    
    return totalThemeModel;
}

@end




@implementation CJButtonThemeModel

/**
 *  Button的默认主题
 *
 *  @return 默认主题
 */
+ (CJButtonThemeModel *)defaultButtonThemeModel
{
    CJButtonThemeModel *buttonThemeModel = [[CJButtonThemeModel alloc] init];
    
    buttonThemeModel.cornerRadius = 15;
    buttonThemeModel.selectedBorderWidth = 0.5;
    
    return buttonThemeModel;
}


@end
