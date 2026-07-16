//
//  CQTSTestMethodMiddleButton.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  背景是一排向下箭头，按钮居中的视图

#import <UIKit/UIKit.h>

@interface CQTSTestMethodMiddleButton : UIView {
    
}

#pragma mark - Init
/*
 *  初始化
 *
 *  @param tapAction       按钮的点击
 *
 *  @return 背景是一排向下箭头，按钮居中的视图
 */
- (instancetype)initWithTapAction:(void(^)(void))tapAction NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

#pragma mark - Config
- (void)configTitle:(NSString *)title;

@end
