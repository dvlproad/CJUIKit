//
//  TwoImageCompareView.m
//  CJUIKitDemo
//
//  Created by qian on 2021/1/13.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "TwoImageCompareView.h"
#import <Masonry/Masonry.h>

@interface TwoImageCompareView () {
    
}

@end

@implementation TwoImageCompareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        
        self.slider1.minimumValue = 0;
        self.slider1.maximumValue = 360;
        [self.slider1 addTarget:self action:@selector(sliderValueChange1:) forControlEvents:UIControlEventValueChanged];
        
        self.slider2.minimumValue = 0;
        self.slider2.maximumValue = 360;
        [self.slider2 addTarget:self action:@selector(sliderValueChange2:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)setupViews {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(20);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *sliderValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    sliderValueLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:sliderValueLabel];
    [sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(self).mas_offset(20);
        make.centerX.mas_equalTo(self);
    }];
    self.sliderValueLabel1 = sliderValueLabel;
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
    [self addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sliderValueLabel.mas_bottom);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self).mas_offset(20);
        make.centerX.mas_equalTo(self);
    }];
    self.slider1 = slider;
    
    
    UILabel *sliderValueLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    sliderValueLabel2.font = [UIFont systemFontOfSize:15];
    [self addSubview:sliderValueLabel2];
    [sliderValueLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(slider.mas_bottom);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(self).mas_offset(20);
        make.centerX.mas_equalTo(self);
    }];
    self.sliderValueLabel2 = sliderValueLabel2;
    
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectZero];
    [self addSubview:slider2];
    [slider2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sliderValueLabel2.mas_bottom);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self).mas_offset(20);
        make.centerX.mas_equalTo(self);
    }];
    self.slider2 = slider2;
    
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.backgroundColor = [UIColor greenColor];
    [self addSubview:imageView1];
    self.imageView1 = imageView1;
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.backgroundColor = [UIColor greenColor];
    [self addSubview:imageView2];
    self.imageView2 = imageView2;
    
    NSArray<UIView *> *imageViews = @[imageView1, imageView2];
    [imageViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:10];
    [imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(slider2.mas_bottom);
        make.bottom.mas_equalTo(self);
    }];
}

- (void)sliderValueChange1:(UISlider *)slider {
    !self.sliderValueChangeBlock ?: self.sliderValueChangeBlock(self);
}

- (void)sliderValueChange2:(UISlider *)slider {
    !self.sliderValueChangeBlock ?: self.sliderValueChangeBlock(self);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
