//
//  MyUserInfoScaleHeadView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJScaleHeadView.h"

/**
 *  适用于有NavigationBar存在，但透明的视图
 */
@interface MyUserInfoScaleHeadView : CJScaleHeadView

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *portraitButton;
@property (nonatomic, strong) UIButton *navigationBarPortraitButton;
@property (nonatomic, strong) UILabel *nameLabel;

//@property (nonatomic, copy) void (^clickPortraitBlock)(void);   /**< 点击了头像后的事件 */
//@property (nonatomic, copy) void (^tapNameBlock)(void);         /**< 点击名字的回调 */
@property (nonatomic, copy) void (^tapViewBlock)(void);         /**< 点击视图的回调 */

@end
