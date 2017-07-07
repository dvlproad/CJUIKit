//
//  CJSwitchSlider.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSliderControl.h"
#import "CJSwitchSliderStatusModel.h"

@interface CJSwitchSlider : CJSliderControl {
    
}
@property (nonatomic, strong) NSMutableArray<CJSwitchSliderStatusModel *> *statusModels;  /**< 所有状态的模型 */
@property (nonatomic, assign, readonly) NSInteger currentStep;/**< 当前显示的步骤索引 */


/**
 *  达到可以switch的值的回调
 *
 *  参数execStep 被执行的步骤
 */
@property (nonatomic, copy) void(^switchEventOccuBlock)(NSInteger execStep);


/**
 *  显示指定步骤的视图
 *
 *  @param step 指定的步骤
 */
- (void)showStep:(NSInteger)step;

@end
