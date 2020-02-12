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
    
    totalThemeModel.themeColor = @"#01adfeFF";
    totalThemeModel.themeDisabledColor = @"#01adfe66";
    totalThemeModel.themeOppositeColor = @"#FFFFFF";
    totalThemeModel.themeOppositeDisabledColor = @"#FFFFFF4C";
    
//    totalThemeModel.themeColor = @"#192B93FF";
//    totalThemeModel.themeDisabledColor = @"#192B9366";
//    totalThemeModel.themeOppositeColor = @"#FFFFFF";
//    totalThemeModel.themeOppositeDisabledColor = @"#FFFFFF4C";
    
//    totalThemeModel.themeColor = @"#FF0000";
//    totalThemeModel.themeDisabledColor = @"#00FF00";
//    totalThemeModel.themeOppositeColor = @"#0000FF";
//    totalThemeModel.themeOppositeDisabledColor = @"#FFFFFF";
    
    totalThemeModel.separateLineColor = @"#E5E5E5";
    totalThemeModel.textMainColor = @"#333333";
    totalThemeModel.text666Color = @"#666666";
    totalThemeModel.textAssistColor = @"#999999";
    totalThemeModel.placeholderTextColor = @"#CCCCCC";
    
    totalThemeModel.alertThemeModel = [CJAlertThemeModel defaultAlertThemeModel];
    totalThemeModel.buttonThemeModel = [CJButtonThemeModel defaultButtonThemeModel];
    
    return totalThemeModel;
}

///**
// *  总的蓝色主题
// *
// *  @return 总的蓝色主题
// */
//+ (CJThemeModel *)blueThemeModel {
//    CJThemeModel *totalThemeModel = [[CJThemeModel alloc] init];
//    totalThemeModel.themeColor = @"#4499FF";
//    totalThemeModel.separateLineColor = @"#E5E5E5";
//    totalThemeModel.textMainColor = @"#333333";
//    totalThemeModel.text666Color = @"#666666";
//    totalThemeModel.textAssistColor = @"#999999";
//    totalThemeModel.placeholderTextColor = @"#CCCCCC";
//    
//    totalThemeModel.alertThemeModel = [CJAlertThemeModel defaultAlertThemeModel];
//    
//    return totalThemeModel;
//}

@end


@implementation CJAlertThemeModel

/**
 *  Alert的默认主题
 *
 *  @return 默认主题
 */
+ (CJAlertThemeModel *)defaultAlertThemeModel {
    CJAlertThemeModel *alertThemeModel = [[CJAlertThemeModel alloc] init];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    alertThemeModel.alertWidth = screenWidth - 2*60;
    
    alertThemeModel.backgroundColor = @"#FFFFFF";
    alertThemeModel.textFieldBackgroundColor = @"#F1F1F1";
    
    // alert 水平上的左间距:LeftOffset
    alertThemeModel.titleLabelLeftOffset    = 20;
    alertThemeModel.messageLabelLeftOffset  = 20;
    alertThemeModel.bottomButtonsLeftOffset = 0;
    
    // alert 竖直上的间距:alertMarginVertical
    alertThemeModel.marginVertical_flagImage_title_message_buttons  = @[@20, @20, @10, @20, @0];
    alertThemeModel.marginVertical_title_message_buttons            = @[@20, @10, @20, @0];
    alertThemeModel.marginVertical_title_buttons                    = @[@30, @30, @0];
    alertThemeModel.marginVertical_message_buttons                  = @[@30, @30, @0];
    
    alertThemeModel.marginVertical_title_textField_buttons          = @[@30, @30, @30, @0];
    
    
    return alertThemeModel;
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
