//
//  BBXShimmeringSwitchSlider.h
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJSwitchSlider.h"
#import <Shimmer/FBShimmeringView.h>
#import <Shimmer/FBShimmeringLayer.h>

@interface BBXShimmeringSwitchSlider : FBShimmeringView

@property (nonatomic, strong) NSMutableArray<CJSwitchSliderStatusModel *> *statusModels;  /**< 所有状态的模型 */

/**
 *  达到可以switch的值的回调
 *
 *  参数execStep 被执行的步骤
 */
@property (nonatomic, copy) void(^switchEventOccuBlock)(NSInteger execStep);

@property (nonatomic, assign) NSInteger stautsValue;

@end
