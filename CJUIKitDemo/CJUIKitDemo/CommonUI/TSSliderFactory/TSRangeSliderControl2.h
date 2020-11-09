//
//  TSRangeSliderControl2.h
//  CJUIKitDemo
//
//  Created by qian on 2020/11/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJRangeSliderControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSRangeSliderControl2 : CJRangeSliderControl {
    
}
/*
 *  初始化
 *
 *  @param chooseCompleteBlock 选择结束，返回选择的最大和最小值
 *
 *  @param slider滑块视图
 */
- (instancetype)initWithChooseCompleteBlock:(void(^)(CGFloat minValue, CGFloat maxValue))chooseCompleteBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
