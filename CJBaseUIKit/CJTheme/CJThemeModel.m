//
//  CJThemeModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJThemeModel.h"

@implementation CJThemeModel

/**
 *  总的默认主题
 *
 *  @return 总的默认主题
 */
+ (CJThemeModel *)defaultThemeModel {
    CJThemeModel *totalThemeModel = [[CJThemeModel alloc] init];
    totalThemeModel.themeBlueColor = @"#172991";
    totalThemeModel.separateLineColor = @"#E5E5E5";
    totalThemeModel.textMainColor = @"#333333";
    totalThemeModel.text666Color = @"#666666";
    totalThemeModel.textAssistColor = @"#999999";
    totalThemeModel.placeholderTextColor = @"#CCCCCC";
    
    totalThemeModel.alertThemeModel = [CJAlertThemeModel defaultAlertThemeModel];
    
    return totalThemeModel;
}

/**
 *  总的蓝色主题
 *
 *  @return 总的蓝色主题
 */
+ (CJThemeModel *)blueThemeModel {
    CJThemeModel *totalThemeModel = [[CJThemeModel alloc] init];
    totalThemeModel.themeBlueColor = @"#4499FF";
    totalThemeModel.separateLineColor = @"#E5E5E5";
    totalThemeModel.textMainColor = @"#333333";
    totalThemeModel.text666Color = @"#666666";
    totalThemeModel.textAssistColor = @"#999999";
    totalThemeModel.placeholderTextColor = @"#CCCCCC";
    
    totalThemeModel.alertThemeModel = [CJAlertThemeModel defaultAlertThemeModel];
    
    return totalThemeModel;
}

@end


@implementation CJAlertThemeModel

/**
 *  Alert的默认主题
 *
 *  @return 默认主题
 */
+ (CJAlertThemeModel *)defaultAlertThemeModel {
    CJAlertThemeModel *alertThemeModel = [[CJAlertThemeModel alloc] init];
    alertThemeModel.backgroundColor = @"#FFFFFF";
    alertThemeModel.textFieldBackgroundColor = @"#F1F1F1";
    
    // alert 竖直上的间距:alertMarginVertical
    alertThemeModel.marginVertical_title_buttons = @[@30, @30, @0 , @0];
    alertThemeModel.marginVertical_title_message_buttons = @[@20, @10, @20, @0];
    alertThemeModel.marginVertical_message_buttons = @[@30, @30, @0, @0];
    alertThemeModel.marginVertical_flagImage_title_message_buttons = @[@30, @30, @0, @0];
    
    return alertThemeModel;
}

@end
