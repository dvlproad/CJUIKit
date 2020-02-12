//
//  CJThemeModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CJAlertThemeModel, CJButtonThemeModel;
@interface CJThemeModel : NSObject {
    
}
@property (nonatomic, copy) NSString *themeColor;
@property (nonatomic, copy) NSString *themeDisabledColor;
@property (nonatomic, copy) NSString *themeOppositeColor;
@property (nonatomic, copy) NSString *themeOppositeDisabledColor;
@property (nonatomic, copy) NSString *separateLineColor;
@property (nonatomic, copy) NSString *textMainColor;
@property (nonatomic, copy) NSString *text666Color;
@property (nonatomic, copy) NSString *textAssistColor;
@property (nonatomic, copy) NSString *placeholderTextColor;

@property (nonatomic, strong) CJAlertThemeModel *alertThemeModel;
@property (nonatomic, strong) CJButtonThemeModel *buttonThemeModel;


/**
*  总的默认主题
*
*  @return 总的默认主题
*/
+ (CJThemeModel *)defaultThemeModel;

///**
// *  总的蓝色主题
// *
// *  @return 总的蓝色主题
// */
//+ (CJThemeModel *)blueThemeModel;

@end






@interface CJAlertThemeModel : NSObject {
    
}
@property (nonatomic, assign) CGFloat alertWidth;

@property (nonatomic, copy) NSString *backgroundColor;
@property (nonatomic, copy) NSString *textFieldBackgroundColor;

// alert 竖直上的间距:alertMarginVertical
@property (nonatomic, strong) NSArray *marginVertical_title_buttons;
@property (nonatomic, strong) NSArray *marginVertical_title_message_buttons;
@property (nonatomic, strong) NSArray *marginVertical_message_buttons;
@property (nonatomic, strong) NSArray *marginVertical_flagImage_title_message_buttons;
@property (nonatomic, strong) NSArray *marginVertical_title_textField_buttons;

// alert 水平上的左间距:LeftOffset
@property (nonatomic, assign) CGFloat titleLabelLeftOffset;
@property (nonatomic, assign) CGFloat messageLabelLeftOffset;
@property (nonatomic, assign) CGFloat bottomButtonsLeftOffset;

/**
 *  Alert的默认主题
 *
 *  @return 默认主题
 */
+ (CJAlertThemeModel *)defaultAlertThemeModel;


@end





@interface CJButtonThemeModel : NSObject {
    
}
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat selectedBorderWidth;

/**
 *  Button的默认主题
 *
 *  @return 默认主题
 */
+ (CJButtonThemeModel *)defaultButtonThemeModel;


@end
