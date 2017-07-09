//
//  CJRangeSliderControl.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRangeSliderControl.h"

#import "CJSliderThumb.h"
#import "CJSliderPopover.h"

static CGFloat const kCJRangeSliderControlLeftPadding                         = 10.0f;
static CGFloat const kCJRangeSliderControlBackgroundImageViewHeight           = 15.0f;
static CGFloat const kCJRangeSliderControlThumbSizeWidth                      = 30.0f;
static CGFloat const kCJRangeSliderControlThumbSizeHeight                     = 30.0f;
static CGFloat const kCJRangeSliderControlPopoverWidth                        = 30.0f;
static CGFloat const kCJRangeSliderControlPopoverHeight                       = 32.0f;
static CGFloat const kCJRangeSliderControlBackgroundViewCornerRadius          = 8.0f;
static NSTimeInterval const kCJRangeSliderControlPopoverAnimationDuration     = 0.25f;
static NSTimeInterval const kMTRngeSliderDidTapSlidAnimationDuration   = 0.3f;

@interface CJRangeSliderControl ()

@property (nonatomic, assign) CGRect lastFrame;

@property (nonatomic, assign) CGPoint lastThumbPoint;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *frontImageView;

@property (nonatomic, strong) CJSliderThumb *leftThumb;

@property (nonatomic, strong) CJSliderThumb *rightThumb;

@property (nonatomic, strong) CJSliderPopover *leftPopover;

@property (nonatomic, strong) CJSliderPopover *rightPopover;
@end

@implementation CJRangeSliderControl


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
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.frontImageView];
    [self addSubview:self.leftThumb];
    [self addSubview:self.rightThumb];
    [self addSubview:self.leftPopover];
    [self addSubview:self.rightPopover];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //防止多次调用
    if (CGRectEqualToRect(self.lastFrame, self.frame)) {
        return;
    }
    
    self.lastFrame = self.frame;
    
    CGFloat backgroundImageViewY = self.bounds.size.height / 2 - kCJRangeSliderControlBackgroundImageViewHeight / 2;
    CGFloat backgroundImageViewWidth = self.bounds.size.width - kCJRangeSliderControlLeftPadding * 2;
    self.backgroundImageView.frame = CGRectMake(kCJRangeSliderControlLeftPadding, backgroundImageViewY,backgroundImageViewWidth,kCJRangeSliderControlBackgroundImageViewHeight);
    

    CGFloat leftThumbY = self.bounds.size.height / 2 - kCJRangeSliderControlThumbSizeHeight / 2;
    self.leftThumb.frame = CGRectMake(0, leftThumbY, kCJRangeSliderControlThumbSizeWidth, kCJRangeSliderControlThumbSizeHeight);
    
    CGFloat rightThumbX = self.bounds.size.width - kCJRangeSliderControlThumbSizeWidth;
    self.rightThumb.frame = CGRectMake(rightThumbX, leftThumbY, kCJRangeSliderControlThumbSizeWidth, kCJRangeSliderControlPopoverHeight);

    
    CGFloat popoverY = self.leftThumb.frame.origin.y - kCJRangeSliderControlPopoverHeight;
    self.leftPopover.frame = CGRectMake(0, popoverY, kCJRangeSliderControlPopoverWidth, kCJRangeSliderControlPopoverHeight);
    self.rightPopover.frame = CGRectMake(rightThumbX, popoverY, kCJRangeSliderControlThumbSizeWidth, kCJRangeSliderControlPopoverHeight);
    [self updateFrontImageView];
    
}

#pragma mark - Event
- (void)buttonDidDrag:(CJSliderThumb *)thumb withEvent:(UIEvent *)event {
    
    UITouch *touch    = [[event touchesForView:thumb] anyObject];
    CGPoint point     = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    
    //判断是否需要阻止leftThumb右移,阻止rightThumb左移
    BOOL stopDragThumb = [self thumbNeedsToStopDrag:thumb point:point lastPoint:lastPoint];
    if (stopDragThumb) {
        return;
    }
    
    BOOL isLeftThumb  = [self isLeftThumb:thumb];
    
    //移动Thumb
    [self dragThumb:thumb withPoint:point lastPoint:lastPoint];
    
    //更新进度区间
    [self updateFrontImageView];
    
    //更新thumb的显示
    [self updatePopover:isLeftThumb];
}


- (void)buttonEndDrag:(CJSliderThumb *)thumb {
    
    BOOL isLeftThumb = [self isLeftThumb:thumb];
    
    //更新Thumb状态
    [self updateEndDragThumbStatus:isLeftThumb];
    
    //隐藏Popover
    [self hidePopover:isLeftThumb];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    
    if (CGPointEqualToPoint(_lastThumbPoint, point)) {
        return;
    }
    
    _lastThumbPoint = point;
    
    //判断点击的位置与两个Thumb的距离，哪个比较近则移动哪一个Thumb
    BOOL isCloseLeftThumb = [self isCloseLeftThumbWithPoint:point];
    
    [UIView animateWithDuration:kMTRngeSliderDidTapSlidAnimationDuration animations:^{
        
        if (isCloseLeftThumb) {
            
            [self moveThumb:self.leftThumb withPoint:point];
        } else {
            
            [self moveThumb:self.rightThumb withPoint:point];
        }
        
        [self updateFrontImageView];
        
    } completion:^(BOOL finished) {
        
        [self updateEndDragThumbStatus:isCloseLeftThumb];
        [self updatePopover:isCloseLeftThumb];
        [self hidePopover:isCloseLeftThumb animationDuration:1.0f];
    }];
}

#pragma mark - Private

/**
 *  更新slider的进度
 */
- (void)updateFrontImageView {
    
    CGRect frontImageViewFrame = CGRectMake(self.leftThumb.center.x, self.backgroundImageView.frame.origin.y, self.rightThumb.center.x - self.leftThumb.center.x, self.backgroundImageView.bounds.size.height);
    self.frontImageView.frame = frontImageViewFrame;
}

/**
 *  更新Popover的显示
 *
 *  @param isLeftThumb 是否左边的Thumb
 */
- (void)updatePopover:(BOOL)isLeftThumb {
    
    CGFloat leftThumbPercent  = self.leftThumb.frame.origin.x / (self.bounds.size.width - kCJRangeSliderControlThumbSizeWidth);
    CGFloat rightThumbPercent = self.rightThumb.frame.origin.x / (self.bounds.size.width - kCJRangeSliderControlThumbSizeWidth);
    CGFloat leftPopoverNum    = leftThumbPercent  * (_maxValue - _minValue);
    CGFloat rightPopoverNum   = rightThumbPercent * (_maxValue - _minValue);
    if (isLeftThumb) {
        
        [self movePopover:self.leftPopover aboveThumb:self.leftThumb];
        
        [self showPopover:self.leftPopover content:leftPopoverNum];
        
        self.rightThumb.userInteractionEnabled = NO;
        
    } else {
        
        [self movePopover:self.rightPopover aboveThumb:self.rightThumb];
        
        [self showPopover:self.rightPopover content:rightPopoverNum];
        
        self.leftThumb.userInteractionEnabled = NO;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rangeSlider:didChangedMinValue:didChangedMaxValue:)]) {
        
        [self.delegate rangeSlider:self didChangedMinValue:leftPopoverNum didChangedMaxValue:rightPopoverNum];
    }
}
/**
 *  更新结束拖动时候Thumb的显示状态
 *
 *  @param isLeftThumb 是否左边的Thumb
 */
- (void)updateEndDragThumbStatus:(BOOL)isLeftThumb {
    
    self.rightThumb.userInteractionEnabled = YES;
    self.leftThumb.userInteractionEnabled = YES;
    self.leftThumb.isNormal = YES;
    self.rightThumb.isNormal = YES;
}

/**
 *  拖动Thumb调用这个方法
 *
 *  @param thumb     当前的thumb
 *  @param point     当前拖动的point
 *  @param lastPoint 上一次的点
 */
- (void)dragThumb:(CJSliderThumb *)thumb withPoint:(CGPoint)point lastPoint:(CGPoint)lastPoint {
    
    CGFloat moveToX = MIN(CGRectGetWidth(self.bounds) - CGRectGetWidth(thumb.bounds) / 2,
                          MAX(CGRectGetWidth(thumb.bounds) / 2,
                              thumb.center.x + (point.x - lastPoint.x)));
    thumb.center = CGPointMake(moveToX, thumb.center.y);
    thumb.isNormal = NO;
}


/**
 *  移动Thumb到对应的点
 *
 *  说明: 需要对传入的point进行处理
 *
 *  @param thumb 当前的thumb
 *  @param point 手指点击的位置
 */
- (void)moveThumb:(CJSliderThumb *)thumb withPoint:(CGPoint)point{
    
    CGPoint thumbPoint = CGPointMake(MIN(CGRectGetWidth(self.bounds) - CGRectGetWidth(thumb.bounds) / 2,
                                         MAX(CGRectGetWidth(thumb.bounds) / 2,
                                             point.x)), thumb.center.y);
    thumb.center = thumbPoint;
}

- (void)movePopover:(CJSliderPopover *)popover aboveThumb:(CJSliderThumb *)thumb{
    
    CGRect tempRect = popover.frame;
    tempRect.origin.x = thumb.frame.origin.x;
    popover.frame = tempRect;
}

- (void)showPopover:(CJSliderPopover *)popover content:(CGFloat)num {
    
    NSString *content = [NSString stringWithFormat:@"%.1f",num];
    [popover updatePopoverTextValue:content];
    [UIView animateWithDuration:kCJRangeSliderControlPopoverAnimationDuration animations:^{
        popover.alpha = 1.0;
    }];
    
}

- (void)hidePopover:(BOOL)isLeftPopover {
    
    [self hidePopover:isLeftPopover animationDuration:kCJRangeSliderControlPopoverAnimationDuration];
}

- (void)hidePopover:(BOOL)isLeftPopover animationDuration:(NSTimeInterval)duration {
    
    if (isLeftPopover) {
        
        [UIView animateWithDuration:duration animations:^{
            self.leftPopover.alpha = 0;
        }];
        
    } else {
        [UIView animateWithDuration:duration animations:^{
            self.rightPopover.alpha = 0;
        }];
    }
}


- (BOOL)thumbNeedsToStopDrag:(CJSliderThumb *)thumb point:(CGPoint)point lastPoint:(CGPoint)lastPoint {
    //判断是否左移
    BOOL isSlideToLeft = point.x - lastPoint.x < 0;
    
    //判断leftThumb和rightThumb是否相交
    BOOL isIntersect  = CGRectIntersectsRect(self.leftThumb.frame, self.rightThumb.frame);
    
    BOOL isLeftThumb  = ( thumb == self.leftThumb );
    
    //如果相交,阻止leftThumb有移,阻止rightThumb左移。
    if ( isLeftThumb && !isSlideToLeft && isIntersect) {
        
        return YES;
    }
    
    if (  !isLeftThumb && isSlideToLeft && isIntersect) {
        
        return YES;
    }
    
    return NO;
}

- (BOOL)isLeftThumb:(CJSliderThumb *)thumb {
    
    return (thumb == self.leftThumb);
}

- (BOOL)isCloseLeftThumbWithPoint:(CGPoint)point {
    
    return fabs(point.x - self.leftThumb.frame.origin.x) < fabs(point.x - self.rightThumb.frame.origin.x);
}

#pragma mark - Getter and Setter
-(UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        UIImage *backgroundImage = [UIImage imageNamed:@"slider_maximum_trackimage"];
        UIEdgeInsets insets = UIEdgeInsetsMake(3, 7, 3, 7);
        backgroundImage = [backgroundImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        _backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
        _backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView.layer.cornerRadius = kCJRangeSliderControlBackgroundViewCornerRadius;
        _backgroundImageView.layer.masksToBounds = YES;
        _backgroundImageView.alpha = 0.5;
    }
    return _backgroundImageView;
}

-(UIImageView *)frontImageView {
    
    if (!_frontImageView) {
        
        UIImage *frontImageView = [UIImage imageNamed:@"slider_minimum_trackimage"];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 0, 5);
        frontImageView = [frontImageView resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        _frontImageView = [[UIImageView alloc] initWithImage:frontImageView];
        _frontImageView.userInteractionEnabled = YES;
        _frontImageView.layer.cornerRadius = kCJRangeSliderControlBackgroundViewCornerRadius;
        _frontImageView.layer.masksToBounds = YES;
    }
    return _frontImageView;
}

-(CJSliderThumb *)leftThumb {
    
    if (!_leftThumb) {
        
        _leftThumb = [CJSliderThumb buttonWithType:UIButtonTypeCustom];
        _leftThumb.isNormal = YES;
        [_leftThumb addTarget:self
                   action:@selector(buttonDidDrag:withEvent:)
         forControlEvents:UIControlEventTouchDragInside];
        [_leftThumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        
    }
    return _leftThumb;
}

-(CJSliderThumb *)rightThumb {
    
    if (!_rightThumb) {
        
        _rightThumb = [CJSliderThumb buttonWithType:UIButtonTypeCustom];
        _rightThumb.isNormal = YES;
        [_rightThumb addTarget:self
                       action:@selector(buttonDidDrag:withEvent:)
             forControlEvents:UIControlEventTouchDragInside];

        [_rightThumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside|
         UIControlEventTouchUpOutside];
    }
    return _rightThumb;
}

- (CJSliderPopover *)leftPopover {
    
    if (!_leftPopover) {
        _leftPopover = [[CJSliderPopover alloc] initWithFrame:CGRectMake(0, 0, kCJRangeSliderControlPopoverWidth, kCJRangeSliderControlPopoverHeight)];
        _leftPopover.alpha = 0;
    }
    return _leftPopover;
}

-(CJSliderPopover *)rightPopover {
   
    if (!_rightPopover) {
        _rightPopover = [[CJSliderPopover alloc] initWithFrame:CGRectMake(0, 0, kCJRangeSliderControlPopoverWidth, kCJRangeSliderControlPopoverHeight)];
        _rightPopover.alpha = 0;
    }
    return _rightPopover;
}

@end
