//
//  CJSwitchSlider.h
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSliderControl.h"
#import "CJSliderStatusModel.h"

@interface CJSwitchSlider : CJSliderControl {
    
}

/**
 *  成功switch的回调
 *
 *  参数step 被完成的步骤
 */
@property (nonatomic, copy) void(^switchSuccessBlock)(NSInteger step);

@property (nonatomic, strong) NSMutableArray<CJSliderStatusModel *> *statusModels;  /**< 所有状态的模型 */
@property (nonatomic, assign, readonly) NSInteger currentStep;

/**
 *  为当前步骤更新视图
 *
 *  @param index 当前的步骤
 */
- (void)updateStateForIndex:(NSInteger)index;

@end
