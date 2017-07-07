//
//  SmallScaleHeadView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJScaleHeadView.h"

/**
 *  适用于有NavigationBar存在，但透明的视图
 */
@interface SmallScaleHeadView : CJScaleHeadView

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *portraitButton;
@property (nonatomic, strong) UIButton *navigationBarPortraitButton;
@property (nonatomic, strong) UILabel *nameLabel;

@end
