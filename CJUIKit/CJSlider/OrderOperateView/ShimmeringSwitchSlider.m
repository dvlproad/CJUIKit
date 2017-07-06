//
//  ShimmeringSwitchSlider.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ShimmeringSwitchSlider.h"

@implementation ShimmeringSwitchSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.shimmering = YES;
    self.shimmeringOpacity = 1;
    self.shimmeringBeginFadeDuration = 0.3;
    self.shimmeringEndFadeDuration = 2;
    self.shimmeringAnimationOpacity = 0.6;
    
//    self.textLabel.text = @"路漫漫其修远兮";
    //    self.contentView = self.textLabel; //这里由于使用xib，导致textLabel重复被addSubview了
    
    
    
    self.switchSlider = [[CJSwitchSlider alloc] initWithFrame:CGRectZero];
    [self cj_makeView:self addSubView:self.switchSlider withEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    ((FBShimmeringLayer *)self.layer).contentLayer = self.switchSlider.layer;
}

//- (void)setModel:(OrderListModel *)model {
//    _model = model;
//    
//    if (model.order_status == Order_state_sended) {
//        [self.switchSlider showFromIndex:0];
//    } else if (model.order_status == Order_state_get_on) {
//        [self.switchSlider showFromIndex:1];
//    }
//}

#pragma mark - addSubView
- (void)cj_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}


@end
