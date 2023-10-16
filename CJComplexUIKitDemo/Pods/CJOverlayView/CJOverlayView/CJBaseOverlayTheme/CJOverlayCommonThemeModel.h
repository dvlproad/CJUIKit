//
//  CJOverlayCommonThemeModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJOverlayCommonThemeModel : NSObject {
    
}
@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, strong) UIColor *themeDisabledColor;
@property (nonatomic, strong) UIColor *themeOppositeColor;
@property (nonatomic, strong) UIColor *themeOppositeDisabledColor;
@property (nonatomic, strong) UIColor *separateLineColor;
@property (nonatomic, strong) UIColor *textAssistColor; // actionSheet的subTitle会用到
@property (nonatomic, strong) UIColor *textMainColor;   // 使用的地方：hud取消按钮
@property (nonatomic, strong) UIColor *text666Color;    // 使用的地方：HUD弹窗标题
@property (nonatomic, strong) UIColor *textDangerColor; // 使用的地方：HUD删除按钮
@property (nonatomic, strong) UIColor *placeholderTextColor;

@property (nonatomic, strong) UIColor *blankBGColor;

@end
