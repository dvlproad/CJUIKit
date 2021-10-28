//
//  TwoImageCompareView.h
//  CJUIKitDemo
//
//  Created by qian on 2021/1/13.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoImageCompareView : UIView {
    
}
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *sliderValueLabel1;
@property (nonatomic, strong) UISlider *slider1;
@property (nonatomic, strong) UILabel *sliderValueLabel2;
@property (nonatomic, strong) UISlider *slider2;

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;

@property (nonatomic, copy) void(^sliderValueChangeBlock)(TwoImageCompareView *bSelfView);

@end

NS_ASSUME_NONNULL_END
