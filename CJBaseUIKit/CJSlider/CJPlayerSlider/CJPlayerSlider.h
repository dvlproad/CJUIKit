//
//  CJPlayerSlider.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/3/21.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJPlayerSlider;
@protocol CJPlayerSliderDelegate <NSObject>

/** 开始滑动slider */
- (void)cjPlayerSliderTouchDown:(CJPlayerSlider *)playerSlider;

/** 结束滑动slider */
- (void)cjPlayerSliderTouchUp:(CJPlayerSlider *)playerSlider;

/** slider值的变化 */
- (void)cjPlayerSliderValueChanged:(CJPlayerSlider *)playerSlider;

@end



@interface CJPlayerSlider : UISlider {
    
}
@property (nonatomic, weak) id <CJPlayerSliderDelegate> delegate;

@property (nonatomic) BOOL enableTip;//是否需要提示
@property (nonatomic) BOOL isNeedAutoAdsorb;//是否需要自动调整滑杆值
@property (nonatomic, assign, readonly, getter = isDragging) BOOL dragging;

- (void)valueChanged;
- (void)touchUp;
- (void)touchDown;

/**
 *@brief:隐藏提示视图
 */
- (void)hideTipView;

@end
