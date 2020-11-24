//
//  CJRangeSliderControl.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRangeSliderControl.h"

#import "CJSliderPopover.h"

static NSTimeInterval const kCJRangeSliderControlPopoverAnimationDuration     = 0.25f;
static NSTimeInterval const kMTRngeSliderDidTapSlidAnimationDuration   = 0.3f;

@interface CJRangeSliderControl () {
    
}
@property (nonatomic, assign, readonly) CGFloat thumbCanMoveWidth;  //滑块可滑动的实际大小

@property (nonatomic, assign) CGRect lastFrame;

@property (nonatomic, assign) CGPoint lastThumbPoint;

@property (nonatomic, strong) UIView *trackView;
@property (nonatomic, strong) UIView *frontView;

@property (nonatomic, strong) CJSliderPopover *leftPopover;
@property (nonatomic, strong) CJSliderPopover *rightPopover;

@property (nonatomic, copy) NSString *(^popoverTextTransBlock)(CGFloat percentValue, CGFloat realValue); /**< popover上的文本转换方法(默认使用realValue保留一位小数 ) */

@end



@implementation CJRangeSliderControl

/*
 *  初始化
 *
 *  @param minRangeValue                选择范围的最小值
 *  @param maxRangeValue                选择范围的最大值
 *  @param startRangeValue              初始范围的起始值
 *  @param endRangeValue                初始范围的结束值
 *  @param createTrackViewBlock             trackView的创建方法
 *  @param createFrontViewBlock         frontView的创建方法
 *  @param popoverTextTransBlock        popover上的文本转换方法(默认使用realValue保留一位小数 )
 *
 *  @param slider滑块视图
 */
- (instancetype)initWithMinRangeValue:(CGFloat)minRangeValue
                        maxRangeValue:(CGFloat)maxRangeValue
                      startRangeValue:(CGFloat)startRangeValue
                        endRangeValue:(CGFloat)endRangeValue
                 createTrackViewBlock:(UIView * (^)(void))createTrackViewBlock
                 createFrontViewBlock:(UIView *(^)(void))createFrontViewBlock
                popoverTextTransBlock:(NSString *(^)(CGFloat percentValue, CGFloat realValue))popoverTextTransBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _minValue = minRangeValue;
        _maxValue = maxRangeValue;
        _startRangeValue = startRangeValue;
        _endRangeValue = endRangeValue;
        _popoverTextTransBlock = popoverTextTransBlock;

        _trackViewMinXMargin = 10;
        _trackViewMaxXMargin = 10;
        
        [self setupViewWithStartRangeValue:startRangeValue
                             endRangeValue:endRangeValue
                      createTrackViewBlock:createTrackViewBlock
                      createFrontViewBlock:createFrontViewBlock];
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)coder {
//    self = [self initWithCreateTrackViewBlock:nil createFrontViewBlock:nil];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)setupViewWithStartRangeValue:(CGFloat)startRangeValue
                       endRangeValue:(CGFloat)endRangeValue
                createTrackViewBlock:(UIView * (^)(void))createTrackViewBlock
                createFrontViewBlock:(UIView * (^)(void))createFrontViewBlock
{
    if (!_trackView) {
        if (createTrackViewBlock) {
            _trackView = createTrackViewBlock();
        } else {
            UIImage *backgroundImage = [UIImage imageNamed:@"slider_maximum_trackimage"];
            UIEdgeInsets insets = UIEdgeInsetsMake(3, 7, 3, 7);
            backgroundImage = [backgroundImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
            _trackView = [[UIImageView alloc] initWithImage:backgroundImage];
            _trackView.userInteractionEnabled = YES;
            _trackView.layer.cornerRadius = 8.0f;
            _trackView.layer.masksToBounds = YES;
            _trackView.alpha = 0.5;
        }
    }
    
    
    if (!_frontView) {
        if (createFrontViewBlock) {
            _frontView = createFrontViewBlock();
        } else {
            UIImage *frontImage = [UIImage imageNamed:@"slider_minimum_trackimage"];
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 0, 5);
            frontImage = [frontImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
            _frontView = [[UIImageView alloc] initWithImage:frontImage];
            _frontView.userInteractionEnabled = YES;
            _frontView.layer.cornerRadius = 8.0f;
            _frontView.layer.masksToBounds = YES;
        }
    }
    
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.trackView];
    [self addSubview:self.frontView];
    [self addSubview:self.leftThumb];
    [self addSubview:self.rightThumb];
    [self addSubview:self.leftPopover];
    [self addSubview:self.rightPopover];
    
    _thumbSize = CGSizeMake(30, 30);
    _popoverSize = CGSizeMake(30, 32);
    
    CGFloat leftThumbPercent  = self.startRangeValue/(_maxValue - _minValue);;
    CGFloat leftPopoverNum    = self.startRangeValue;
    NSString *leftContent = [self __popoverTextWithPercentValue:leftThumbPercent realValue:leftPopoverNum];
    [self.leftPopover updatePopoverTextValue:leftContent];
    
    CGFloat rightThumbPercent = self.endRangeValue/(_maxValue - _minValue);
    CGFloat rightPopoverNum   = self.endRangeValue;
    NSString *rightContent = [self __popoverTextWithPercentValue:rightThumbPercent realValue:rightPopoverNum];
    [self.rightPopover updatePopoverTextValue:rightContent];
    
    self.popoverShowTimeType = CJSliderPopoverShowTimeTypeAll; // 有 Setter 方法
}


#pragma mark - Setter
- (void)setPopoverShowTimeType:(BOOL)popoverShowTimeType {
    _popoverShowTimeType = popoverShowTimeType;
    
    if (_popoverShowTimeType == CJSliderPopoverShowTimeTypeDrag) {
        self.leftPopover.alpha = 0;
        self.rightPopover.alpha = 0;
    } else {
        self.leftPopover.alpha = 1;
        self.rightPopover.alpha = 1;
    }
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectEqualToRect(self.lastFrame, self.frame)) {
        return; //防止多次调用
    }
    self.lastFrame = self.frame;
    
    [self reloadSlider];
}

/* 完整的描述请参见文件头部 */
- (void)reloadSlider {
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    self.trackView.frame = trackRect;
    
    
    
    CGFloat thumbWidth = self.thumbSize.width;
    CGFloat thumbHeight = self.thumbSize.height;
    CGFloat thumbY = CGRectGetHeight(self.bounds)/2 - thumbHeight/2;
    
    _thumbMoveMinX = 0 + self.thumbMoveMinXMargin;
    _thumbMoveMaxX = CGRectGetWidth(self.bounds) - self.thumbMoveMaxXMargin;
    _thumbCanMoveWidth = (self.thumbMoveMaxX-thumbWidth) - self.thumbMoveMinX; //滑块可滑动的实际大小
    
    //计算该值在坐标上的X是多少
    CGFloat leftPercent = self.startRangeValue /(self.maxValue - self.minValue);
    CGFloat leftThumbX = CGRectGetMinX(trackRect) + _thumbMoveMinX + leftPercent*self.thumbCanMoveWidth;
    CGRect leftThumbRect = CGRectMake(leftThumbX, thumbY, thumbWidth, thumbHeight);
    self.leftThumb.frame = leftThumbRect;
    
    CGFloat rightPercent = self.endRangeValue /(self.maxValue - self.minValue);
    CGFloat rightThumbX = CGRectGetMinX(trackRect) + _thumbMoveMinX + rightPercent*self.thumbCanMoveWidth;
    CGRect rightThumbRect = CGRectMake(rightThumbX, thumbY, thumbWidth, thumbHeight);
    self.rightThumb.frame = rightThumbRect;
    
    CGFloat popoverWidth = self.popoverSize.width;  // 弹出框的宽
    CGFloat popoverHeight = self.popoverSize.height;// 弹出框的高
    CGFloat popoverY = thumbY - popoverHeight;
    self.leftPopover.frame = CGRectMake(leftThumbX, popoverY, popoverWidth, popoverHeight);
    self.rightPopover.frame = CGRectMake(rightThumbX, popoverY, popoverWidth, popoverHeight);

    [self updateFrontImageView];
}

#pragma mark - 一些位置的获取
/**
 *  获取滑道的frame
 *
 *  @param bounds   整个视图的bounds
 */
- (CGRect)trackRectForBounds:(CGRect)bounds {
    if (self.trackHeight == 0 || self.trackHeight > CGRectGetHeight(bounds)) {
        //NSLog(@"修正trackHeight的高度");
        self.trackHeight = CGRectGetHeight(bounds);
    }
    CGFloat trackViewHeight = self.trackHeight;
    CGFloat trackViewOriginY = CGRectGetHeight(bounds)/2 - trackViewHeight/2;
    
    _trackViewMinX = 0 + self.trackViewMinXMargin;
    _trackViewMaxX = CGRectGetWidth(bounds) - self.trackViewMaxXMargin;
    CGFloat trackViewOriginX = self.trackViewMinX;
    CGFloat trackViewWidth = self.trackViewMaxX - self.trackViewMinX;
    
    return CGRectMake(trackViewOriginX, trackViewOriginY, trackViewWidth, trackViewHeight);
}

#pragma mark - Event
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
    CGRect frontViewFrame = CGRectMake(self.leftThumb.center.x, self.trackView.frame.origin.y, self.rightThumb.center.x - self.leftThumb.center.x, self.trackView.bounds.size.height);
    self.frontView.frame = frontViewFrame;
}

/**
 *  更新Popover的显示
 *
 *  @param isLeftThumb 是否左边的Thumb
 */
- (void)updatePopover:(BOOL)isLeftThumb {
    CGFloat leftThumbPercent  = [self __leftThumbPercent];
    CGFloat leftPopoverNum    = leftThumbPercent  * (_maxValue - _minValue);
    
    
    CGFloat rightThumbPercent = [self __rightThumbPercent];
    CGFloat rightPopoverNum   = rightThumbPercent * (_maxValue - _minValue);
    
    if (isLeftThumb) {
        [self movePopover:self.leftPopover aboveThumb:self.leftThumb];
        
        NSString *leftContent = [self __popoverTextWithPercentValue:leftThumbPercent realValue:leftPopoverNum];
        [self.leftPopover updatePopoverTextValue:leftContent];
        [self showPopover:self.leftPopover];
        
        self.rightThumb.userInteractionEnabled = NO;
        
    } else {
        [self movePopover:self.rightPopover aboveThumb:self.rightThumb];
        
        NSString *rightContent = [self __popoverTextWithPercentValue:rightThumbPercent realValue:rightPopoverNum];
        [self.rightPopover updatePopoverTextValue:rightContent];
        [self showPopover:self.rightPopover];
        
        self.leftThumb.userInteractionEnabled = NO;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rangeSlider:didChangedMinValue:didChangedMaxValue:)]) {
        [self.delegate rangeSlider:self didChangedMinValue:leftPopoverNum didChangedMaxValue:rightPopoverNum];
    }
}

- (CGFloat)__leftThumbPercent {
    CGFloat thumbWidth = self.thumbSize.width;      // 滑块的宽
    CGFloat leftThumbPercent  = self.leftThumb.frame.origin.x / (self.bounds.size.width - thumbWidth);
    return leftThumbPercent;
}

- (CGFloat)__rightThumbPercent {
    CGFloat thumbWidth = self.thumbSize.width;      // 滑块的宽
    CGFloat rightThumbPercent = self.rightThumb.frame.origin.x / (self.bounds.size.width - thumbWidth);
    return rightThumbPercent;
}

- (NSString *)__popoverTextWithPercentValue:(CGFloat)percentValue realValue:(CGFloat)realValue {
    if (self.popoverTextTransBlock) {
        return self.popoverTextTransBlock(percentValue, realValue);
    } else {
        return [NSString stringWithFormat:@"%.1f", realValue];
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
}

/**
 *  移动Thumb到对应的点
 *
 *  说明: 需要对传入的point进行处理
 *
 *  @param thumb 当前的thumb
 *  @param point 手指点击的位置
 */
- (void)moveThumb:(UIButton *)thumb withPoint:(CGPoint)point{
    
    CGPoint thumbPoint = CGPointMake(MIN(CGRectGetWidth(self.bounds) - CGRectGetWidth(thumb.bounds) / 2,
                                         MAX(CGRectGetWidth(thumb.bounds) / 2,
                                             point.x)), thumb.center.y);
    thumb.center = thumbPoint;
}

- (void)movePopover:(UIView *)popover aboveThumb:(UIButton *)thumb {
    CGRect tempRect = popover.frame;
    tempRect.origin.x = thumb.frame.origin.x;
    popover.frame = tempRect;
}

- (void)showPopover:(CJSliderPopover *)popover {
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

- (BOOL)__isLeftThumb:(UIButton *)thumb {
    return (thumb == self.leftThumb);
}

- (BOOL)isCloseLeftThumbWithPoint:(CGPoint)point {
    return fabs(point.x - self.leftThumb.frame.origin.x) < fabs(point.x - self.rightThumb.frame.origin.x);
}

#pragma mark - 拖动的事件
- (void)buttonEndDrag:(UIButton *)button {
    [self bringSubviewToFront:button]; // 移动结束后，将本次操作的滑块置顶，防止类型为RangeSlider的时候，如当左侧滑块和右侧滑块重合的时候，只能固定滑动某个，导致在都滑到最左/最右侧的时候，出现问题
    
    
    BOOL isLeftThumb = [self __isLeftThumb:button];
    
    //更新Thumb状态
    [self updateEndDragThumbStatus:isLeftThumb];
    
    if (self.popoverShowTimeType == CJSliderPopoverShowTimeTypeDrag) { // 只有Drag的时候才显示Popover
        [self hidePopover:isLeftThumb]; //隐藏Popover
    }
}

- (void)buttonDidDrag:(UIButton *)thumb withEvent:(UIEvent *)event {
    UITouch *touch      = [[event touchesForView:thumb] anyObject];
    CGPoint point       = [touch locationInView:self];
    CGPoint lastPoint   = [touch previousLocationInView:self];
    CGFloat moveDistance = (point.x - lastPoint.x); //滑动的距离
    if (moveDistance == 0) {
        return;
    }
    
    CGFloat oldThumbX = thumb.frame.origin.x;
    CGFloat newThumbX = [self newThumbXForThumb:thumb withMoveDistance:moveDistance];
    if (newThumbX == oldThumbX) {
        return;
    }
    
    //更新视图
    CGRect thumbFrame = thumb.frame;
    thumbFrame.origin.x = newThumbX;
    thumb.frame = thumbFrame;
    
    //更新完后的额外操作(如显示popover之类的)
    [self doSomethingWhenCompleteUpdateFrameForThumb:thumb];
}

/**
 *  更新slider的值显示
 */
- (void)doSomethingWhenCompleteUpdateFrameForThumb:(UIButton *)thumb {
    //更新进度区间
    [self updateFrontImageView];
    
    //更新thumb的显示
    BOOL isLeftThumb  = [self __isLeftThumb:thumb];
    [self updatePopover:isLeftThumb];
}

- (CGFloat)newThumbXForThumb:(UIButton *)thumb withMoveDistance:(CGFloat)moveDistance {
    CGFloat rightThumbMoveMinMidX = CGRectGetMidX(self.leftThumb.frame); //右侧滑块移动最小中心可到左侧滑块的中心
    CGFloat rightThumbMoveMaxMidX = self.thumbMoveMaxX - CGRectGetWidth(thumb.frame)/2; //右侧滑块移动最大中心可到的最大thumbMoveMaxX减去一半滑块宽
    
    CGFloat leftThumbMoveMaxMidX = CGRectGetMidX(self.rightThumb.frame); //左侧滑块移动最大中心可到右侧滑块的中心
    CGFloat leftThumbMoveMinMidX = self.thumbMoveMinX + CGRectGetWidth(thumb.frame)/2; //左侧滑块移动最小中心可到的最小thumbMoveMinX加上一半滑块宽
    
    BOOL isSlideToLeft = moveDistance < 0;      //判断是否左移(否，则是右移)
    BOOL isLeftThumb  = ( thumb == self.leftThumb );
    
//    /* newThumbX 的计算方法1 */
//    CGFloat validMoveDistance = moveDistance;
//    if (!isLeftThumb) {
//        if (isSlideToLeft) {    //右滑块向左滑时候
//            CGFloat canMaxMoveDistance = leftThumbMoveMaxMidX - rightThumbMoveMinMidX;
//            if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
//                validMoveDistance = -canMaxMoveDistance;
//            }
//
//        } else {                //右滑块向右滑时候
//            CGFloat canMaxMoveDistance = rightThumbMoveMaxMidX - leftThumbMoveMaxMidX;
//            if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
//                validMoveDistance = canMaxMoveDistance;
//            }
//        }
//
//    } else if (isLeftThumb) {
//        if (!isSlideToLeft) {   //左滑块向右滑时候
//            CGFloat canMaxMoveDistance = leftThumbMoveMaxMidX - rightThumbMoveMinMidX;
//            if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
//                validMoveDistance = canMaxMoveDistance;
//            }
//
//        } else {                //左滑块向左滑时候
//            CGFloat canMaxMoveDistance = rightThumbMoveMinMidX - leftThumbMoveMinMidX;
//            if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
//                validMoveDistance = -canMaxMoveDistance;
//            }
//        }
//    }
//    CGFloat newThumbX = thumb.frame.origin.x + validMoveDistance;
//    return newThumbX;
    
    /* newThumbX 的计算方法2 */
    CGFloat tempThumbMidX = thumb.center.x + moveDistance;
    if (!isLeftThumb) {
        CGFloat newThumbMidX;
        if (isSlideToLeft) {    //右滑块向左滑时候
            newThumbMidX = MAX(tempThumbMidX, rightThumbMoveMinMidX);
            
        } else {                //右滑块向右滑时候
            newThumbMidX = MIN(tempThumbMidX, rightThumbMoveMaxMidX);
        }
        return newThumbMidX-self.thumbSize.width/2;
    } else {
        CGFloat newThumbMidX;
        if (!isSlideToLeft) {   //左滑块向右滑时候
            newThumbMidX = MIN(tempThumbMidX, leftThumbMoveMaxMidX);
            
        } else {                //左滑块向左滑时候
            newThumbMidX = MAX(tempThumbMidX, leftThumbMoveMinMidX);
        }
        return newThumbMidX-self.thumbSize.width/2;
    }
}



#pragma mark - Getter and Setter
- (UIButton *)leftThumb {
    if (!_leftThumb) {
        _leftThumb = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftThumb addTarget:self action:@selector(buttonDidDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_leftThumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        
    }
    return _leftThumb;
}

- (UIButton *)rightThumb {
    if (!_rightThumb) {
        _rightThumb = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightThumb addTarget:self action:@selector(buttonDidDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_rightThumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside| UIControlEventTouchUpOutside];
    }
    return _rightThumb;
}

- (CJSliderPopover *)leftPopover {
    if (!_leftPopover) {
        CGFloat popoverHeight = self.popoverSize.height;// 弹出框的高
        CGFloat popoverWidth = self.popoverSize.width;  // 弹出框的宽
        _leftPopover = [[CJSliderPopover alloc] initWithFrame:CGRectMake(0, 0, popoverWidth, popoverHeight)];
    }
    return _leftPopover;
}

- (CJSliderPopover *)rightPopover {
    if (!_rightPopover) {
        CGFloat popoverHeight = self.popoverSize.height;// 弹出框的高
        CGFloat popoverWidth = self.popoverSize.width;  // 弹出框的宽
        _rightPopover = [[CJSliderPopover alloc] initWithFrame:CGRectMake(0, 0, popoverWidth, popoverHeight)];
    }
    return _rightPopover;
}

@end