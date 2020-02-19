//
//  CJThemeModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CJButtonThemeModel;
@interface CJThemeModel : NSObject {
    
}
@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, strong) UIColor *themeDisabledColor;
@property (nonatomic, strong) UIColor *themeOppositeColor;
@property (nonatomic, strong) UIColor *themeOppositeDisabledColor;
@property (nonatomic, strong) UIColor *separateLineColor;
@property (nonatomic, strong) UIColor *textMainColor;
@property (nonatomic, strong) UIColor *text666Color;
@property (nonatomic, strong) UIColor *textAssistColor;
@property (nonatomic, strong) UIColor *placeholderTextColor;

@property (nonatomic, strong) UIColor *blankBGColor;
@property (nonatomic, strong) CJButtonThemeModel *buttonThemeModel;


@end




@interface CJButtonThemeModel : NSObject {
    
}
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat selectedBorderWidth;

@end
