//
//  CJSwitchSlider.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSliderControl.h"
#import "CJSwitchSliderStatusModel.h"

typedef NS_ENUM(NSUInteger, CJSwitchAnimatedType) {
    /**
     *  滑道右侧当当前步,则相应的滑道本身当下一步
     */
    CJSwitchAnimatedTypeCurrentStepInMaximumTrackImageView,
    
    /**
     *  滑道本身当当前步,则相应的滑道左侧当下一步，
     */
    CJSwitchAnimatedTypeCurrentStepInTrackImageView
};

@interface CJSwitchSlider : CJSliderControl {
    
}

@property (nonatomic, assign) CJSwitchAnimatedType switchAnimatedType;
@property (nonatomic, strong) NSMutableArray<CJSwitchSliderStatusModel *> *statusModels;  /**< 所有状态的模型 */
@property (nonatomic, assign, readonly) NSInteger currentStep;/**< 当前显示的步骤索引 */
@property (nonatomic, assign) CGFloat criticalValue;    /**< switch临界值(默认0.7) */

/**
 *  达到可以switch的值的回调
 *
 *  参数execStep 被执行的步骤
 */
@property (nonatomic, copy) void(^switchEventOccuBlock)(NSInteger execStep);


/**
 *  设置更新视图的方法
 *
 *  @param updateTrackViewBlock         更新自定义的滑道视图
 *  @param updateMinimumTrackViewBlock  更新自定义的主滑块左侧的视图
 *  @param updateMaximumTrackViewBlock  更新自定义的主滑块右侧的视图
 */
- (void)setupUpdateTrackViewBlock:(void (^)(UIView *trackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts))updateTrackViewBlock
      updateMinimumTrackViewBlock:(void (^)(UIView *trackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts))updateMinimumTrackViewBlock
      updateMaximumTrackViewBlock:(void (^)(UIView *trackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts))updateMaximumTrackViewBlock;

/**
 *  显示指定步骤的视图
 *
 *  @param step 指定的步骤
 */
- (void)showStep:(NSInteger)step;

@end
