//
//  BBXShimmeringSwitchSlider.m
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BBXShimmeringSwitchSlider.h"

@interface BBXShimmeringSwitchSlider ()

@property (nonatomic, strong) CJSwitchSlider *switchSlider;

@end


@implementation BBXShimmeringSwitchSlider

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

- (void)setStatusModels:(NSMutableArray<CJSwitchSliderStatusModel *> *)statusModels {
    _statusModels = statusModels;
    
    self.switchSlider.statusModels = statusModels;
    
    [self.switchSlider showStep:0];
}

- (void)setSwitchEventOccuBlock:(void (^)(NSInteger))switchEventOccuBlock {
    _switchEventOccuBlock = switchEventOccuBlock;
    
    self.switchSlider.switchEventOccuBlock = switchEventOccuBlock;
}

- (void)commonInit {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    
    self.shimmering = YES;
    self.shimmeringOpacity = 1;
    self.shimmeringAnimationOpacity = 0.6;
    self.shimmeringPauseDuration = 2;
    
    self.shimmeringSpeed = 100;
    
    self.shimmeringBeginFadeDuration = 0.3;
    self.shimmeringEndFadeDuration = 2;
    
    self.switchSlider = [[CJSwitchSlider alloc] initWithFrame:CGRectZero];
    [self commonSetupToSwitchSlider:self.switchSlider];
    [self cj_makeView:self addSubView:self.switchSlider withEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    ((FBShimmeringLayer *)self.layer).contentLayer = self.switchSlider.layer;
}

- (void)commonSetupToSwitchSlider:(CJSwitchSlider *)switchSlider {
    UIView * (^createTrackViewBlock)(void) = ^(void) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        //label.backgroundColor = [UIColor clearColor];
        //label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.font = [UIFont systemFontOfSize:19];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        return label;
    };
    
    UIView * (^createMinimumTrackViewBlock)(void) = ^(void) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        //label.backgroundColor = [UIColor clearColor];
        //label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.font = [UIFont systemFontOfSize:19];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        return label;
    };
    
    
    UIView * (^createMaximumTrackViewBlock)(void) = ^(void) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        //label.backgroundColor = [UIColor clearColor];
        //label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.font = [UIFont systemFontOfSize:19];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        return label;
    };
    
    void(^updateMaximumTrackViewBlock)(UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL useDragingStauts) = ^ (UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts) {
        if (!isDragingStauts) {
            UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
            [c_maximumTrackView setText:statusModel.normalText];
            [c_maximumTrackView setBackgroundColor:statusModel.normalColor];
            
        } else {
            UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
            [c_maximumTrackView setText:statusModel.dragingText];
            [c_maximumTrackView setBackgroundColor:statusModel.dragingColor];
        }
    };
    
    void(^updateTrackViewBlock)(UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL useDragingStauts) = ^ (UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts) {
        if (!isDragingStauts) {
            UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
            [c_maximumTrackView setText:statusModel.normalText];
            [c_maximumTrackView setBackgroundColor:statusModel.normalColor];
            
        } else {
            UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
            [c_maximumTrackView setText:statusModel.dragingText];
            [c_maximumTrackView setBackgroundColor:statusModel.dragingColor];
        }
    };
    [switchSlider setupViewWithCreateTrackViewBlock:createTrackViewBlock
                        createMinimumTrackViewBlock:createMinimumTrackViewBlock
                        createMaximumTrackViewBlock:createMaximumTrackViewBlock];
    [switchSlider setupUpdateTrackViewBlock:updateTrackViewBlock
                updateMinimumTrackViewBlock:nil
                updateMaximumTrackViewBlock:updateMaximumTrackViewBlock];
    
    
    UIImage *mainThumbImage = [UIImage imageNamed:@"btn_hd.png"];
    [switchSlider.mainThumb setImage:mainThumbImage forState:UIControlStateNormal];
    [switchSlider.mainThumb setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0 ,0 )];
    [switchSlider.mainThumb setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    switchSlider.trackHeight = 45;
    switchSlider.criticalValue = 0.3;
    switchSlider.thumbSize = CGSizeMake(350, 88);
    
    switchSlider.moveType = CJSliderMoveTypeMaximumTrackImageViewWidthAspectFit;
    switchSlider.switchAnimatedType = CJSwitchAnimatedTypeCurrentStepInMaximumTrackImageView;
    switchSlider.thumbMoveMaxXMargin = -switchSlider.thumbSize.width;
}

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
