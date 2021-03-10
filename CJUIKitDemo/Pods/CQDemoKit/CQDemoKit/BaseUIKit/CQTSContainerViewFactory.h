//
//  CQTSContainerViewFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSContainerViewFactory : NSObject

#pragma mark - 多按钮视图
+ (UIView *)twoButtonsViewAlongAxis:(MASAxisType)axisType
                             title1:(NSString *)title1
                       actionBlock1:(void(^)(UIButton *bButton))actionBlock1
                             title2:(NSString *)title2
                       actionBlock2:(void(^)(UIButton *bButton))actionBlock2;


+ (UIView *)threeButtonsViewAlongAxis:(MASAxisType)axisType
                               title1:(NSString *)title1
                         actionBlock1:(void(^)(UIButton *bButton))actionBlock1
                               title2:(NSString *)title2
                         actionBlock2:(void(^)(UIButton *bButton))actionBlock2
                               title3:(NSString *)title3
                         actionBlock3:(void(^)(UIButton *bButton))actionBlock3;


#pragma mark - 多视图的基础接口
+ (UIView *)containerViewAlongAxis:(MASAxisType)axisType
                      withSubviews:(NSArray<UIView *> *)subviews
                      fixedSpacing:(CGFloat)fixedSpacing;


@end

NS_ASSUME_NONNULL_END
