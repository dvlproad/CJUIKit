//
//  CQAgeRangeSliderControl.h
//  CJUIKitDemo
//
//  Created by qian on 2020/11/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJRangeSliderControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQAgeRangeSliderControl : CJRangeSliderControl {
    
}
@property (nonatomic, assign, readonly) NSInteger startRangeAge;/**< 选择后的最小年龄 */
@property (nonatomic, assign, readonly) NSInteger endRangeAge;  /**< 选择后的最小年龄 */

#pragma mark - Init
- (instancetype)initWithStartRangeAge:(NSInteger)startRangeAge
                          endRangeAge:(NSInteger)endRangeAge
                  chooseCompleteBlock:(void(^)(NSInteger minAge, NSInteger maxAge))chooseCompleteBlock;
/*
 *  初始化
 *
 *  @param minRangeAge                  选择范围的最小值
 *  @param maxRangeAge                  选择范围的最大值
 *  @param startRangeAge                初始范围的起始值
 *  @param endRangeAge                  初始范围的结束值
 *  @param chooseCompleteBlock          选择结束，返回选择的最大和最小值
 *
 *  @param 年龄范围选择slider滑块视图
 */
- (instancetype)initWithMinRangeAge:(NSInteger)minRangeAge
                        maxRangeAge:(NSInteger)maxRangeAge
                      startRangeAge:(NSInteger)startRangeAge
                        endRangeAge:(NSInteger)endRangeAge
                chooseCompleteBlock:(void(^)(NSInteger minAge, NSInteger maxAge))chooseCompleteBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithMinRangeValue:(CGFloat)minRangeValue
                        maxRangeValue:(CGFloat)maxRangeValue
                      startRangeValue:(CGFloat)startRangeValue
                        endRangeValue:(CGFloat)endRangeValue
                 createTrackViewBlock:(UIView * (^)(void))createTrackViewBlock
                 createFrontViewBlock:(UIView *(^)(void))createFrontViewBlock
               createPopoverViewBlock:(UIView * (^)(BOOL left))createPopoverViewBlock
                    valueChangedBlock:(void(^)(CJRangeSliderControl *bSlider, CJSliderValueChangeHappenType happenType, CGFloat leftThumbPercent, CGFloat rightThumbPercent))valueChangedBlock
              gestureStateChangeBlock:(void(^)(CJSliderGRState gestureRecognizerState))gestureStateChangeBlock NS_UNAVAILABLE;


#pragma mark - Event
/*
 *  请求到网络数据后更新选择值
 *
 *  @param startRangeAge                初始范围的起始值
 *  @param endRangeAge                  初始范围的结束值
 */
- (void)updateStartRangeAge:(NSInteger)startRangeAge
                endRangeAge:(NSInteger)endRangeAge;

- (void)updateStartRangeValue:(CGFloat)startRangeValue
                endRangeValue:(CGFloat)endRangeValue NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
