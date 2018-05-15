//
//  BusShimmeringSwitchSlider.m
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BusShimmeringSwitchSlider.h"
#import "CJLabel.h"

@interface BusShimmeringSwitchSlider ()

@property (nonatomic, strong) CJSwitchSlider *switchSlider;

@end


@implementation BusShimmeringSwitchSlider

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
    self.layer.cornerRadius = 30;
    
    self.shimmering = YES;
    self.shimmeringOpacity = 1;
    self.shimmeringAnimationOpacity = 0.6;
    self.shimmeringPauseDuration = 2;
    
    self.shimmeringSpeed = 100;
    
    self.shimmeringBeginFadeDuration = 0.3;
    self.shimmeringEndFadeDuration = 2;
    
    
    self.switchSlider = [[CJSwitchSlider alloc] initWithFrame:CGRectZero];
    [self commonSetupUIToSwitchSlider:self.switchSlider];
    [self cj_makeView:self addSubView:self.switchSlider withEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    ((FBShimmeringLayer *)self.layer).contentLayer = self.switchSlider.layer;
}

- (void)commonSetupUIToSwitchSlider:(CJSwitchSlider *)switchSlider {
    UIView * (^createTrackViewBlock)(void) = ^(void) {
        CJLabel *label = [[CJLabel alloc] initWithFrame:CGRectZero];
        //label.backgroundColor = [UIColor clearColor];
        label.insets = UIEdgeInsetsMake(0, 57, 0, 0);
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 27;
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        return label;
    };
    
    UIView * (^createMinimumTrackViewBlock)(void) = ^(void) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        //label.backgroundColor = [UIColor clearColor];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 27;
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        return label;
    };
    
    UIView * (^createMaximumTrackViewBlock)(void) = ^(void) {
        CJLabel *label = [[CJLabel alloc] initWithFrame:CGRectZero];
        //label.backgroundColor = [UIColor clearColor];
        label.insets = UIEdgeInsetsMake(0, 57, 0, 0);
        label.minimumScaleFactor = 0.5;
        label.adjustsFontSizeToFitWidth = YES;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 27;
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        return label;
    };
    
    void(^configureMaximumTrackViewBlock)(UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL useDragingStauts) = ^ (UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts) {
        UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
        [c_maximumTrackView setText:statusModel.normalText];
        [c_maximumTrackView setBackgroundColor:statusModel.normalColor];
    };
    
    void(^configureTrackViewBlock)(UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL useDragingStauts) = ^ (UIView *maximumTrackView, CJSwitchSliderStatusModel *statusModel, BOOL isDragingStauts) {
        UILabel *c_maximumTrackView = (UILabel *)maximumTrackView;
        [c_maximumTrackView setText:statusModel.normalText];
        [c_maximumTrackView setBackgroundColor:statusModel.normalColor];
    };
    [switchSlider setupViewWithCreateTrackViewBlock:createTrackViewBlock
                        createMinimumTrackViewBlock:createMinimumTrackViewBlock
                        createMaximumTrackViewBlock:createMaximumTrackViewBlock];
    switchSlider.configureMaximumTrackViewBlock = configureMaximumTrackViewBlock;
    switchSlider.configureTrackViewBlock = configureTrackViewBlock;
    
    
    UIImage *mainThumbImage = [UIImage imageNamed:@"details_icon_huadong"];
    [switchSlider.mainThumb setImage:mainThumbImage forState:UIControlStateNormal];
    [switchSlider.mainThumb setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0 ,0 )];
    [switchSlider.mainThumb setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    switchSlider.trackHeight = 55;
    switchSlider.criticalValue = 0.3;
    switchSlider.thumbSize = CGSizeMake(57, 47);
    
    switchSlider.moveType = CJSliderMoveTypeMaximumTrackImageViewWidthNoChange;
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
