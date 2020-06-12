//
//  CQTSContainerViewFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSContainerViewFactory.h"
#import "CQTSButtonFactory.h"

@interface CQTSContainerViewFactory () {
    
}

@end

@implementation CQTSContainerViewFactory

#pragma mark - 多按钮视图
+ (UIView *)twoButtonsViewAlongAxis:(MASAxisType)axisType
                             title1:(NSString *)title1
                       actionBlock1:(void(^)(UIButton *bButton))actionBlock1
                             title2:(NSString *)title2
                       actionBlock2:(void(^)(UIButton *bButton))actionBlock2
{
    NSArray *buttons = @[[CQTSButtonFactory themeBGButtonWithTitle:title1 actionBlock:actionBlock1],
                         [CQTSButtonFactory themeBGButtonWithTitle:title2 actionBlock:actionBlock2],
    ];
    
    return [self containerViewAlongAxis:axisType withSubviews:buttons];
}


+ (UIView *)threeButtonsViewAlongAxis:(MASAxisType)axisType
                               title1:(NSString *)title1
                         actionBlock1:(void(^)(UIButton *bButton))actionBlock1
                               title2:(NSString *)title2
                         actionBlock2:(void(^)(UIButton *bButton))actionBlock2
                               title3:(NSString *)title3
                         actionBlock3:(void(^)(UIButton *bButton))actionBlock3
{
    NSArray *buttons = @[[CQTSButtonFactory themeBGButtonWithTitle:title1 actionBlock:actionBlock1],
                         [CQTSButtonFactory themeBGButtonWithTitle:title2 actionBlock:actionBlock2],
                         [CQTSButtonFactory themeBGButtonWithTitle:title3 actionBlock:actionBlock3],
    ];

    return [self containerViewAlongAxis:axisType withSubviews:buttons];
}


#pragma mark - 多视图的基础接口
+ (UIView *)containerViewAlongAxis:(MASAxisType)axisType
                      withSubviews:(NSArray<UIView *> *)subviews
{
    UIView *containerView = [[UIView alloc] init];
    for (UIView *view in subviews) {
        [containerView addSubview:view];
    }
    
    if (axisType == MASAxisTypeHorizontal) {
        [subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
        [subviews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(containerView);
        }];
        
    } else {
        [subviews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
        [subviews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(containerView);
        }];
    }
    
    return containerView;
}

@end
