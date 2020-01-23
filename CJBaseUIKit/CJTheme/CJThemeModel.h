//
//  CJThemeModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CJAlertThemeModel;
@interface CJThemeModel : NSObject {
    
}
@property (nonatomic, copy) NSString *themeBlueColor;
@property (nonatomic, copy) NSString *separateLineColor;
@property (nonatomic, copy) NSString *textMainColor;
@property (nonatomic, copy) NSString *text666Color;
@property (nonatomic, copy) NSString *textAssistColor;
@property (nonatomic, copy) NSString *placeholderTextColor;

@property (nonatomic, strong) CJAlertThemeModel *alertThemeModel;


/**
*  总的默认主题
*
*  @return 总的默认主题
*/
+ (CJThemeModel *)defaultThemeModel;

/**
 *  总的蓝色主题
 *
 *  @return 总的蓝色主题
 */
+ (CJThemeModel *)blueThemeModel;

@end






@interface CJAlertThemeModel : NSObject {
    
}
@property (nonatomic, copy) NSString *backgroundColor;
@property (nonatomic, copy) NSString *textFieldBackgroundColor;

// alert 竖直上的间距:alertMarginVertical
@property (nonatomic, strong) NSArray *marginVertical_title_buttons;
@property (nonatomic, strong) NSArray *marginVertical_title_message_buttons;
@property (nonatomic, strong) NSArray *marginVertical_message_buttons;
@property (nonatomic, strong) NSArray *marginVertical_flagImage_title_message_buttons;

/**
 *  Alert的默认主题
 *
 *  @return 默认主题
 */
+ (CJAlertThemeModel *)defaultAlertThemeModel;


@end
