//
//  CJSliderControl.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSliderControl.h"
#import "CJSliderThumb.h"

static CGFloat const kCJSliderControlLeftPadding                         = 10.0f;
static CGFloat const kCJSliderControlBackgroundImageViewHeight           = 15.0f;
static CGFloat const kCJSliderThumbSizeWidth                      = 30.0f;
static CGFloat const kCJSliderThumbSizeHeight                     = 30.0f;
static CGFloat const kCJSliderPopoverWidth                        = 30.0f;
static CGFloat const kCJSliderPopoverHeight                       = 32.0f;
static CGFloat const kCJSliderControlBackgroundViewCornerRadius          = 8.0f;
static NSTimeInterval const kCJSliderPopoverAnimationDuration     = 0.7f;
static NSTimeInterval const kCJSliderControlDidTapSlidAnimationDuration  = 0.3f;

@interface CJSliderControl ()

@property (nonatomic, assign) CGRect lastFrame;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *frontImageView;

@property (nonatomic, strong) UIImageView *baseImageView;

@property (nonatomic, strong) CJSliderThumb *thumb;

@property (nonatomic, strong) CJSliderPopover *popover;

@property (nonatomic, assign, readwrite) CGFloat currentValue;


@end

@implementation CJSliderControl

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _lineThick = kCJSliderControlBackgroundImageViewHeight;
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.frontImageView];
    [self addSubview:self.thumb];
    [self addSubview:self.popover];
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (CGRectEqualToRect(self.lastFrame, self.frame)) {
        return;
    }
    
    self.lastFrame = self.frame;
    
    CGFloat backgroundImageViewY = self.bounds.size.height / 2 - _lineThick / 2;
    CGFloat backgroundImageViewWidth = self.bounds.size.width - kCJSliderControlLeftPadding * 2;
    self.backgroundImageView.frame = CGRectMake(kCJSliderControlLeftPadding, backgroundImageViewY,backgroundImageViewWidth,_lineThick);
    
    //CGFloat thumbX = 0;
    CGFloat backX = CGRectGetMinX(self.backgroundImageView.frame);
    CGFloat backWidth = CGRectGetWidth(self.backgroundImageView.bounds);
    CGFloat baseCenterX = backX + _baseValue * backWidth;
    
    CGFloat baseImageViewWidth = self.backgroundImageView.frame.size.height + 10;
    self.baseImageView.frame = CGRectMake(0, 0, baseImageViewWidth, baseImageViewWidth);
    self.baseImageView.center = CGPointMake(baseCenterX, CGRectGetHeight(self.frame)/2);
    
    CGFloat thumbWidth = kCJSliderThumbSizeWidth;
    CGFloat thumbX = baseCenterX - thumbWidth/2;
    CGFloat thumbY = self.bounds.size.height / 2 - kCJSliderThumbSizeHeight / 2;
    self.thumb.frame = CGRectMake(thumbX, thumbY, kCJSliderThumbSizeWidth, kCJSliderThumbSizeHeight);
    
    CGFloat popoverY = self.thumb.frame.origin.y - kCJSliderPopoverHeight;
    self.popover.frame = CGRectMake(0, popoverY, kCJSliderPopoverWidth, kCJSliderPopoverHeight);
    [self updateFrontImageView];
}


#pragma mark - Private

/**
 *  更新slider的进度
 */
- (void)updateFrontImageView {
    CGFloat backX = CGRectGetMinX(self.backgroundImageView.frame);
    CGFloat backY = CGRectGetMinY(self.backgroundImageView.frame);
    CGFloat backWidth = CGRectGetWidth(self.backgroundImageView.bounds);
    CGFloat backHeight = CGRectGetHeight(self.backgroundImageView.bounds);
    
    CGFloat frontY = backY;
    CGFloat frontHeight = backHeight;
    /*
    CGFloat frontX = backX;
    CGFloat frontWidth = CGRectGetMaxX(self.thumb.frame) - backX * 2;
    */
    
    CGFloat baseCenterX = backX + _baseValue * backWidth;
    
    CGFloat thumbX = CGRectGetMinX(self.thumb.frame);
    CGFloat thumbWidth = CGRectGetWidth(self.thumb.frame);
    CGFloat frontX = thumbX + thumbWidth/2;
    CGFloat frontWidth = baseCenterX - frontX;
    NSLog(@"thumbWidth = %f, frontWidth = %f", thumbWidth, frontWidth);
    
    CGRect frontImageViewFrame = CGRectMake(frontX, frontY, frontWidth, frontHeight);
    self.frontImageView.frame = frontImageViewFrame;
}


/**
 *  更新popover显示
 */
- (void)updatePopover {
    
    NSString *popoverText = [self popoverText];
    _currentValue = [popoverText floatValue];
    [self.popover updatePopoverTextValue:popoverText];
    
    CGRect tempRect = self.popover.frame;
    tempRect.origin.x = self.thumb.frame.origin.x;
    self.popover.frame = tempRect;
    [self showPopoverAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(slider:didDargToValue:)]) {
        
        [self.delegate slider:self didDargToValue:_currentValue];
    }
}

/**
 *  获取popover需要显示的内容
 *  
 *  @return 百分比或者数值
 */
- (NSString *)popoverText {
    
    CGFloat percent = self.thumb.frame.origin.x / (self.bounds.size.width - kCJSliderThumbSizeWidth);
    NSString *popoverText = @"";
    if (_popoverType == CJSliderPopoverDispalyTypePercent) {
        //百分比显示
        popoverText = [NSString stringWithFormat:@"%.1f%%",percent * 100];
        
    } else {
        
        popoverText = [NSString stringWithFormat:@"%.1f",percent * (_maxValue - _minValue)];
    }
    return popoverText;
}

- (void)showPopoverAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:kCJSliderPopoverAnimationDuration animations:^{
            self.popover.alpha = 1.0;
        }];
    } else {
        self.popover.alpha = 1.0;
    }
}

- (void)hidePopoverAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:kCJSliderPopoverAnimationDuration animations:^{
            self.popover.alpha = 0;
        }];
    } else {
        self.popover.alpha = 0;
    }
}


#pragma mark - Event
/** 完整的描述请参见文件头部 */
- (void)hidePopover:(BOOL)isHidden {
    self.popover.hidden = isHidden;
}

- (void)buttonDidDrag:(UIButton *)button withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat buttonWidth = CGRectGetWidth(button.bounds);
    CGFloat buttonCenterY = button.center.y;
    
    /*
    CGFloat buttonCenterX = button.center.x;
    CGFloat newButtonCenterX = MIN(width - buttonWidth / 2,
                                   MAX(buttonWidth / 2, buttonCenterX + (point.x - lastPoint.x)));
     */
    CGFloat newButtonX = button.frame.origin.x + (point.x - lastPoint.x);
    if (newButtonX < 0) {
        newButtonX = 0;
    }
    if (newButtonX > width - buttonWidth) {
        newButtonX = width - buttonWidth;
    }
    CGFloat newButtonCenterX = newButtonX + buttonWidth / 2;
    CGFloat newButtonCenterY = buttonCenterY;
    
    button.center = CGPointMake(newButtonCenterX, newButtonCenterY);
    
    [self updateFrontImageView];
    [self updatePopover];
}


- (void)buttonEndDrag:(UIButton *)button {
    
    [self hidePopoverAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    
    [UIView animateWithDuration:kCJSliderControlDidTapSlidAnimationDuration animations:^{
        self.thumb.center = CGPointMake(MIN(CGRectGetWidth(self.bounds) - CGRectGetWidth(self.thumb.bounds) / 2,
                                            MAX(CGRectGetWidth(self.thumb.bounds) / 2,
                                                point.x)), self.thumb.center.y);
        [self updateFrontImageView];
    } completion:^(BOOL finished) {
    
        [self updatePopover];
        [self hidePopoverAnimated:YES];
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hidePopoverAnimated:YES];
}



#pragma mark - Getter and Setter
- (void)setBaseValue:(CGFloat)baseValue {
    _baseValue = baseValue;
    
    if (_baseValue) {
        [self insertSubview:self.baseImageView aboveSubview:self.frontImageView];
        [self hidePopover:YES];
    }
}

- (UIImageView *)baseImageView {
    if (!_baseImageView) {
        UIImage *baseImage = [UIImage imageNamed:@"slider_thumbImage"];
        _baseImageView = [[UIImageView alloc] initWithImage:baseImage];
    }
    return _baseImageView;
}

- (void)setBaseImage:(UIImage *)baseImage {
    [self.baseImageView setImage:baseImage];
}

- (void)setLineThick:(CGFloat)lineThick {
    _lineThick = lineThick;
}

-(UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        UIImage *backgroundImage = [UIImage imageNamed:@"slider_maximum_trackimage"];
        UIEdgeInsets insets = UIEdgeInsetsMake(3, 7, 3, 7);
        backgroundImage = [backgroundImage cj_resizableImageWithCapInsets:insets];
        _backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
        _backgroundImageView.layer.cornerRadius = kCJSliderControlBackgroundViewCornerRadius;
        _backgroundImageView.layer.masksToBounds = YES;
        _backgroundImageView.alpha = 0.5;
    }
    return _backgroundImageView;
}

-(UIImageView *)frontImageView {
    
    if (!_frontImageView) {
        
        UIImage *frontImageView = [UIImage imageNamed:@"slider_minimum_trackimage"];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 0, 5);
        frontImageView = [frontImageView cj_resizableImageWithCapInsets:insets];
        _frontImageView = [[UIImageView alloc] initWithImage:frontImageView];
        _frontImageView.layer.cornerRadius = kCJSliderControlBackgroundViewCornerRadius;
        _frontImageView.layer.masksToBounds = YES;
    }
    return _frontImageView;
}


-(CJSliderThumb *)thumb {
    
    if (!_thumb) {
        
        _thumb = [CJSliderThumb buttonWithType:UIButtonTypeCustom];
        UIImage *thumbImage = [UIImage imageNamed:@"slider_thumbImage"];
        thumbImage = [thumbImage cj_transformImageToSize:CGSizeMake(kCJSliderThumbSizeWidth, kCJSliderThumbSizeHeight)];
        [_thumb setImage:thumbImage forState:UIControlStateNormal];
        [_thumb addTarget:self
                   action:@selector(buttonDidDrag:withEvent:)
         forControlEvents:UIControlEventTouchDragInside];
        [_thumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
      
    }
    return _thumb;
}

- (CJSliderPopover *)popover {
    
    if (!_popover) {
        _popover = [[CJSliderPopover alloc] initWithFrame:CGRectMake(0, 0, kCJSliderPopoverWidth, kCJSliderPopoverHeight)];
        _popover.alpha = 0;
    }
    return _popover;
}

-(void)setThumbImage:(UIImage *)thumbImage {
    
    [self.thumb setImage:thumbImage forState:UIControlStateNormal];
}

-(void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    
    UIImage *image = [UIImage cj_imageWithColor:minimumTrackTintColor size:CGSizeMake(kCJSliderThumbSizeWidth, kCJSliderThumbSizeHeight)];
    self.backgroundImageView.image = image;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    
    UIImage *image = [UIImage cj_imageWithColor:maximumTrackTintColor size:CGSizeMake(kCJSliderThumbSizeWidth, kCJSliderThumbSizeHeight)];
    self.frontImageView.image = image;
}

@end

