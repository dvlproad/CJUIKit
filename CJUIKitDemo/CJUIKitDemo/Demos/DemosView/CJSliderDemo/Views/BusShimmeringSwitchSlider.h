//
//  BusShimmeringSwitchSlider.h
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJSwitchSlider.h"
#import <Shimmer/FBShimmeringView.h>
#import <Shimmer/FBShimmeringLayer.h>

//@class BusShimmeringSwitchSlider;
//@protocol BusShimmeringSwitchSliderDelegate <NSObject>
//
//- (void)switchOKOnBusShimmeringSwitchSlider:(BusShimmeringSwitchSlider *)switchSlider;
//
//@end


@interface BusShimmeringSwitchSlider : FBShimmeringView

@property (nonatomic, strong) NSMutableArray<CJSwitchSliderStatusModel *> *statusModels;  /**< 所有状态的模型 */

@property (nonatomic, assign) NSInteger stautsValue;

@end
