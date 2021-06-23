//
//  CJRangeSliderControl.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRangeSliderControl.h"
#import "CJSliderThumb.h"

static NSTimeInterval const kCJRangeSliderControlPopoverAnimationDuration     = 0.25f;
static NSTimeInterval const kMTRngeSliderDidTapSlidAnimationDuration   = 0.3f;

@interface CJRangeSliderControl () {
    
}
@property (nonatomic, assign, readonly) CGFloat thumbCanMoveWidth;  //滑块可滑动的实际大小

@property (nonatomic, assign) CGRect lastFrame;

@property (nonatomic, assign) CGPoint lastThumbPoint;

@property (nonatomic, strong) UIView *trackView;
@property (nonatomic, strong) UIView *frontView;


//@property (nonatomic, copy, readonly) NSString *(^textFormatBlock)(CGFloat value);  /**< 将浮点型value格式化的方法（比如将value显示为整数），默认nil，表示使用原值显示 */
@property (nonatomic, copy) void(^valueChangedBlock)(CJRangeSliderControl *bSlider, CJSliderValueChangeHappenType happenType, CGFloat leftThumbPercent, CGFloat rightThumbPercent, CGFloat leftPopoverNum, CGFloat rightPopoverNum); /**< 选择的值发生变化的回调（happenType:滑块上的值改变发生的事件来源类型;leftThumbPercent:左边滑块中心点所在滑道的比例;rightThumbPercent:右边滑块中心点所在滑道的比例） */

@property (nonatomic, copy) void(^gestureStateChangeBlock)(CJSliderGRState gestureRecognizerState); /**< slider手势变化的回调（有时候会需要在某种结束后做震动处理） */

@end



@implementation CJRangeSliderControl

/*
 *  初始化
 *
 *  @param minRangeValue                选择范围的最小值
 *  @param maxRangeValue                选择范围的最大值
 *  @param startRangeValue              初始范围的起始值
 *  @param endRangeValue                初始范围的结束值
 *  @param createTrackViewBlock         trackView的创建方法（会默认创建）
 *  @param createFrontViewBlock         frontView的创建方法（会默认创建）
 *  @param createPopoverViewBlock       popoverView的创建方法（会默认创建）（目前仅支持悬浮气泡在滑条的上面区域）
 *  @param textFormatBlock              将浮点型value格式化的方法（比如将value显示为整数），默认nil，表示使用原值显示
 *  @param valueChangedBlock            选择的值发生变化的回调（happenType:滑块上的值改变发生的事件来源类型;leftThumbPercent:左边滑块中心点所在滑道的比例;rightThumbPercent:右边滑块中心点所在滑道的比例）
 *  @param gestureStateChangeBlock      slider手势变化的回调（有时候会需要在某种结束后做震动处理）
 *
 *  @param slider滑块视图
 */
- (instancetype)initWithMinRangeValue:(CGFloat)minRangeValue
                        maxRangeValue:(CGFloat)maxRangeValue
                      startRangeValue:(CGFloat)startRangeValue
                        endRangeValue:(CGFloat)endRangeValue
                 createTrackViewBlock:(UIView * (^)(void))createTrackViewBlock
                 createFrontViewBlock:(UIView *(^)(void))createFrontViewBlock
               createPopoverViewBlock:(UIView * (^)(BOOL left))createPopoverViewBlock
//                      textFormatBlock:(NSString *(^ _Nullable)(CGFloat value))textFormatBlock
                    valueChangedBlock:(void(^)(CJRangeSliderControl *bSlider, CJSliderValueChangeHappenType happenType, CGFloat leftThumbPercent, CGFloat rightThumbPercent, CGFloat leftPopoverNum, CGFloat rightPopoverNum))valueChangedBlock
              gestureStateChangeBlock:(void(^)(CJSliderGRState gestureRecognizerState))gestureStateChangeBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _minValue = minRangeValue;
        _maxValue = maxRangeValue;

        _trackViewMinXMargin = 10;
        _trackViewMaxXMargin = 10;
        
//        _textFormatBlock = textFormatBlock;
        _valueChangedBlock = valueChangedBlock;
        _gestureStateChangeBlock = gestureStateChangeBlock;
        
        [self setupViewWithStartRangeValue:startRangeValue
                             endRangeValue:endRangeValue
                      createTrackViewBlock:createTrackViewBlock
                      createFrontViewBlock:createFrontViewBlock
                    createPopoverViewBlock:createPopoverViewBlock];
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
              createPopoverViewBlock:(UIView * (^)(BOOL left))createPopoverViewBlock
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
    
    if (!_leftPopover) {
        if (createPopoverViewBlock) {
            _leftPopover = createPopoverViewBlock(YES);
        } else {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:22];
            label.textColor = [UIColor colorWithRed:12/255.0 green:16/255.0 blue:27/255.0 alpha:1.0]; // #0C101B
            label.textAlignment = NSTextAlignmentCenter;
            _leftPopover = label;
        }
    }
    if (!_rightPopover) {
        if (createPopoverViewBlock) {
            _rightPopover = createPopoverViewBlock(NO);
        } else {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:22];
            label.textColor = [UIColor colorWithRed:12/255.0 green:16/255.0 blue:27/255.0 alpha:1.0]; // #0C101B
            label.textAlignment = NSTextAlignmentCenter;
            _rightPopover = label;
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
    
    CGFloat leftThumbPercent  = [self __leftThumbPercentByValue:startRangeValue];
    CGFloat rightThumbPercent = [self __rightThumbPercentByValue:endRangeValue];
    [self __updateValueByCodeSetHappenType:CJSliderValueChangeHappenTypeInit
                          leftThumbPercent:leftThumbPercent
                         rightThumbPercent:rightThumbPercent
                            leftThumbValue:startRangeValue
                           rightThumbValue:endRangeValue];
    
    self.popoverShowTimeType = CJSliderPopoverShowTimeTypeAll; // 有 Setter 方法
}

#pragma mark - Config
/*
 *  设置左侧滑块和滑道
 *
 *  @param thumbMoveMinXMargin              滑块(假设是个点)可移动到的最小X值离bound的边缘距离
 *  @param leftThumbSize                    左滑块大小
 *  @param trackViewMinXIsLeftThumbXType    滑道的最小值是对齐左滑块的哪个x(min/mid/max，默认mid)
 */
- (void)configThumbMoveMinXMargin:(CGFloat)thumbMoveMinXMargin
                    leftThumbSize:(CGSize)leftThumbSize
    trackViewMinXIsLeftThumbXType:(CJThumbXType)trackViewMinXIsLeftThumbXType
{
    _thumbMoveMinXMargin = thumbMoveMinXMargin;
    _thumbSize = leftThumbSize;
    if (trackViewMinXIsLeftThumbXType == CJThumbXTypeMid) {
        _trackViewMinXMargin = thumbMoveMinXMargin + leftThumbSize.width/2;
    } else {
        _trackViewMinXMargin = thumbMoveMinXMargin + leftThumbSize.width/2;
    }
}

/*
 *  设置左侧滑块和滑道
 *
 *  @param thumbMoveMaxXMargin              滑块(假设是个点)可移动到的最大X值离bound的边缘距离
 *  @param rightThumbSize                   右滑块大小
 *  @param trackViewMinXIsLeftThumbXType    滑道的最大值是对齐右滑块的哪个x(min/mid/max，默认mid)
 */
- (void)configThumbMoveMaxXMargin:(CGFloat)thumbMoveMaxXMargin
                    rightThumbSize:(CGSize)rightThumbSize
    trackViewMaxXIsRightThumbXType:(CJThumbXType)trackViewMaxXIsRightThumbXType
{
    _thumbMoveMaxXMargin = thumbMoveMaxXMargin;
    _thumbSize = rightThumbSize;
    if (trackViewMaxXIsRightThumbXType == CJThumbXTypeMid) {
        _trackViewMaxXMargin = thumbMoveMaxXMargin + rightThumbSize.width/2;
    } else {
        _trackViewMaxXMargin = thumbMoveMaxXMargin + rightThumbSize.width/2;
    }
}

#pragma mark - Event
/*
 *  请求到网络数据后更新选择值
 *
 *  @param startRangeValue              初始范围的起始值
 *  @param endRangeValue                初始范围的结束值
 */
- (void)updateStartRangeValue:(CGFloat)startRangeValue
                endRangeValue:(CGFloat)endRangeValue
{
    CGFloat leftThumbPercent  = [self __leftThumbPercentByValue:startRangeValue];
    CGFloat rightThumbPercent = [self __rightThumbPercentByValue:endRangeValue];
    [self __updateValueByCodeSetHappenType:CJSliderValueChangeHappenTypeUpdateFromRequest
                          leftThumbPercent:leftThumbPercent
                         rightThumbPercent:rightThumbPercent
                            leftThumbValue:startRangeValue
                           rightThumbValue:endRangeValue];
}



- (CGFloat)__leftThumbPercentByValue:(CGFloat)startRangeValue {
    CGFloat leftThumbPercent  = (startRangeValue-self.minValue)/(_maxValue - _minValue);
    return leftThumbPercent;
}

- (CGFloat)__rightThumbPercentByValue:(CGFloat)endRangeValue {
    CGFloat rightThumbPercent = (endRangeValue-self.minValue)/(_maxValue - _minValue);
    return rightThumbPercent;
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


/*
 *  更新范围(如果你更新了startRangeValue和endRangeValue，请确保调用此方法前为_startRangeValue和_endRangeValue赋值了)
 *
 */
- (void)reloadSlider
{
    [self __reloadSliderWithStartRangeValue:self.startRangeValue endRangeValue:self.endRangeValue];
}

/*
 *  更新范围
 *
 *  @param startRangeValue              初始范围的起始值
 *  @param endRangeValue                初始范围的结束值
 */
- (void)__reloadSliderWithStartRangeValue:(CGFloat)startRangeValue
                            endRangeValue:(CGFloat)endRangeValue
{
    CGFloat thumbWidth = self.thumbSize.width;
    CGFloat thumbHeight = self.thumbSize.height;
    CGFloat thumbY = CGRectGetHeight(self.bounds) - thumbHeight;    // UI布局之可拖动的滑块的底部与本视图的底部对齐
    //CGFloat thumbY = CGRectGetHeight(self.bounds)/2 - thumbHeight/2;// UI布局之可拖动的滑块的中心与本视图的中心对齐

    CGRect trackRect = [self trackRectForBounds:self.bounds thumbCenterY:thumbY+thumbHeight/2];
    self.trackView.frame = trackRect;
    
    
    _thumbMoveMinX = 0 + self.thumbMoveMinXMargin;
    _thumbMoveMaxX = CGRectGetWidth(self.bounds) - self.thumbMoveMaxXMargin;
    _thumbCanMoveWidth = (self.thumbMoveMaxX-thumbWidth) - self.thumbMoveMinX; //滑块可滑动的实际大小
    
    //计算该值在坐标上的X是多少
    CGFloat leftThumbPercent  = [self __leftThumbPercentByValue:startRangeValue];
    CGFloat rightThumbPercent = [self __rightThumbPercentByValue:endRangeValue];
    
    // 由percent获取到X的方法
    CGFloat leftThumbMidX = CGRectGetMinX(trackRect) + _thumbMoveMinX + leftThumbPercent*self.thumbCanMoveWidth;
    CGFloat leftThumbX = leftThumbMidX - thumbWidth/2;
    CGRect leftThumbRect = CGRectMake(leftThumbX, thumbY, thumbWidth, thumbHeight);
    self.leftThumb.frame = leftThumbRect;
    
    CGFloat rightThumbMidX = CGRectGetMinX(trackRect) + _thumbMoveMinX + rightThumbPercent*self.thumbCanMoveWidth;
    CGFloat rightThumbX = rightThumbMidX - thumbWidth/2;
    CGRect rightThumbRect = CGRectMake(rightThumbX, thumbY, thumbWidth, thumbHeight);
    self.rightThumb.frame = rightThumbRect;
    
    CGFloat popoverWidth = self.popoverSize.width;  // 弹出框的宽
    CGFloat popoverHeight = self.popoverSize.height;// 弹出框的高
    CGFloat popoverY = thumbY - self.popoverSpacing - popoverHeight;    // 悬浮气泡在滑条的上面区域
    CGFloat leftPopoverX = leftThumbMidX - popoverWidth/2;
    CGFloat rightPopoverX = rightThumbMidX - popoverWidth/2;
//    popoverY = thumbY - 0 - popoverHeight;
//    self.leftThumb.backgroundColor = [UIColor redColor];
//    self.rightThumb.backgroundColor = [UIColor redColor];
//    self.leftPopover.backgroundColor = [UIColor redColor];
//    self.rightPopover.backgroundColor = [UIColor redColor];
    self.leftPopover.frame = CGRectMake(leftPopoverX, popoverY, popoverWidth, popoverHeight);
    self.rightPopover.frame = CGRectMake(rightPopoverX, popoverY, popoverWidth, popoverHeight);

    [self updateFrontImageView];
}

#pragma mark - 一些位置的获取
/*
 *  获取滑道的frame
 *
 *  @param bounds           整个视图的bounds
 *  @param thumbCenterY     可拖动的滑块的竖直中心Y值（用于通过对齐来确认到滑条的竖直中心位置）
 */
- (CGRect)trackRectForBounds:(CGRect)bounds thumbCenterY:(CGFloat)thumbCenterY {
    if (self.trackHeight == 0 || self.trackHeight > CGRectGetHeight(bounds)) {
        //NSLog(@"修正trackHeight的高度");
        self.trackHeight = CGRectGetHeight(bounds);
    }
    CGFloat trackViewHeight = self.trackHeight;
    CGFloat trackViewOriginY = thumbCenterY - trackViewHeight/2;   // UI布局之滑条的竖直中心位置与可拖动的滑块的竖直中心位置对齐
    
    _trackViewMinX = 0 + self.trackViewMinXMargin;
    _trackViewMaxX = CGRectGetWidth(bounds) - self.trackViewMaxXMargin;
    CGFloat trackViewOriginX = self.trackViewMinX;
    CGFloat trackViewWidth = self.trackViewMaxX - self.trackViewMinX;
    
    return CGRectMake(trackViewOriginX, trackViewOriginY, trackViewWidth, trackViewHeight);
}

#pragma mark - 点击的事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    !self.gestureStateChangeBlock ?: self.gestureStateChangeBlock(CJSliderGRStateTrackTouchBegin);
    
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
        [self updateEndDragThumbStatus:isCloseLeftThumb isTouch:YES];
        
        CJSliderValueChangeHappenType happenType;
        if (isCloseLeftThumb) {
            happenType = CJSliderValueChangeHappenTypeTouchTrackCloseThumbLeft;
        } else {
            happenType = CJSliderValueChangeHappenTypeTouchTrackCloseThumbRight;
        }
        [self updatePopover:isCloseLeftThumb happenType:happenType];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    !self.gestureStateChangeBlock ?: self.gestureStateChangeBlock(CJSliderGRStateTrackTouchEnd);
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
- (void)updatePopover:(BOOL)isLeftThumb
           happenType:(CJSliderValueChangeHappenType)happenType
{
    if (isLeftThumb) {
        [self movePopover:self.leftPopover aboveThumb:self.leftThumb];
        
        [self showPopover:self.leftPopover];
        
        self.rightThumb.userInteractionEnabled = NO;
        
    } else {
        [self movePopover:self.rightPopover aboveThumb:self.rightThumb];
        
        [self showPopover:self.rightPopover];
        
        self.leftThumb.userInteractionEnabled = NO;
    }
    
    [self __updateValueByPeopleGRHappenType:happenType];
}

/*
 *  根据选中的值更新popover上的值(代码设置：1初始化，2更新)
 *
 *  @param happenInLeft         滑块上的值改变发生的事件来源类型
 *  @param leftThumbPercent     左边滑块中心点所在滑道的比例
 *  @param rightThumbPercent    右边滑块中心点所在滑道的比例
 *  @param leftThumbValue       左边滑块数值
 *  @param rightThumbValue      右边滑块数值
 */
- (void)__updateValueByCodeSetHappenType:(CJSliderValueChangeHappenType)happenType
                        leftThumbPercent:(CGFloat)leftThumbPercent
                       rightThumbPercent:(CGFloat)rightThumbPercent
                          leftThumbValue:(CGFloat)leftThumbValue
                         rightThumbValue:(CGFloat)rightThumbValue
{
    _startRangeValue = leftThumbValue;
    _endRangeValue = rightThumbValue;
    if (happenType == CJSliderValueChangeHappenTypeInit) {
        // do nothing (会自动调用layoutSubviews，然后触发reloadSlider)
    } else if (happenType == CJSliderValueChangeHappenTypeUpdateFromRequest) {
        [self reloadSlider];    // 无法触发layoutSubviews中的reloadSlider，所以这里手动调用
    }
    
    [self __valueChangeCompleteWithHappenType:happenType
                             leftThumbPercent:leftThumbPercent
                            rightThumbPercent:rightThumbPercent
                               leftThumbValue:leftThumbValue
                              rightThumbValue:rightThumbValue];
}

/*
 *  根据选中的值更新popover上的值(人为手势：1点击滑块上的点；2拖动滑块)
 *
 *  @param happenInLeft         滑块上的值改变发生的事件来源类型
 *  @param leftThumbPercent     左边滑块中心点所在滑道的比例
 *  @param rightThumbPercent    右边滑块中心点所在滑道的比例
 */
- (void)__updateValueByPeopleGRHappenType:(CJSliderValueChangeHappenType)happenType
{
    // 由percent获取到X的方法
    //CGFloat leftThumbMidX = CGRectGetMinX(trackRect) + _thumbMoveMinX + leftThumbPercent*self.thumbCanMoveWidth;
    //CGFloat rightThumbMidX = CGRectGetMinX(trackRect) + _thumbMoveMinX + rightThumbPercent*self.thumbCanMoveWidth;
    // 由X获取到percent的方法
    CGFloat leftThumbMidX = self.leftThumb.center.x;
    CGFloat trackMinX = CGRectGetMinX(self.trackView.frame);
    CGFloat leftThumbPercent  = (leftThumbMidX-trackMinX-self.thumbMoveMinX) / self.thumbCanMoveWidth;
    CGFloat rightThumbMidX = self.rightThumb.center.x;
    CGFloat rightThumbPercent = (rightThumbMidX-trackMinX-self.thumbMoveMinX) / self.thumbCanMoveWidth;
    
//    CGFloat thumbWidth = self.thumbSize.width;      // 滑块的宽
//    CGFloat leftThumbPercent  = self.leftThumb.frame.origin.x / (self.bounds.size.width - thumbWidth);
//    CGFloat rightThumbPercent  = self.rightThumb.frame.origin.x / (self.bounds.size.width - thumbWidth);

    
    CGFloat leftThumbValue    = self.minValue + leftThumbPercent  * (self.maxValue - self.minValue);
    CGFloat rightThumbValue   = self.minValue + rightThumbPercent * (self.maxValue - self.minValue);
    
    [self __valueChangeCompleteWithHappenType:happenType
                             leftThumbPercent:leftThumbPercent
                            rightThumbPercent:rightThumbPercent
                               leftThumbValue:leftThumbValue
                              rightThumbValue:rightThumbValue];
}

- (void)__valueChangeCompleteWithHappenType:(CJSliderValueChangeHappenType)happenType
                           leftThumbPercent:(CGFloat)leftThumbPercent
                          rightThumbPercent:(CGFloat)rightThumbPercent
                             leftThumbValue:(CGFloat)leftThumbValue
                            rightThumbValue:(CGFloat)rightThumbValue
{
    _startRangeValue = leftThumbValue;
    _endRangeValue = rightThumbValue;
    
    //NSLog(@"leftThumbPercent = %.2f, rightThumbPercent = %.2f, leftThumbValue = %.2f, rightThumbValue = %.2f", leftThumbPercent, rightThumbPercent, leftThumbValue, rightThumbValue);
    !self.valueChangedBlock ?: self.valueChangedBlock(self, happenType, leftThumbPercent, rightThumbPercent, leftThumbValue, rightThumbValue);
}


/*
 *  更新结束拖动时候Thumb的显示状态
 *
 *  @param isLeftThumb      是否是移动左滑块/靠近左滑块的Thumb
 *  @param isTouch          是否是点击操作(否,则即代表是按住滑块的拖动动作)
 */
- (void)updateEndDragThumbStatus:(BOOL)isLeftThumb isTouch:(BOOL)isTouch {
    if (self.popoverShowTimeType == CJSliderPopoverShowTimeTypeDrag) { // 只有Drag的时候才显示Popover
        if (isTouch) {
            [self hidePopover:isLeftThumb animationDuration:1.0f];
        } else {
            [self hidePopover:isLeftThumb];
        }
    }
    
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
    CGPoint popoverCenter = popover.center;
    popoverCenter.x = thumb.center.x;
    popover.center = popoverCenter;
}

- (void)showPopover:(UIView *)popover {
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
- (void)buttonStartDrag:(UIButton *)button {
    // 特别注意：如果本RangeSlider所在的视图中添加了其他的Pan手势（常见于你为了关闭侧滑，而不小心添加了Pan），则会导致此控制器响应不灵敏
    // 特别注意：如果本RangeSlider所在的视图中添加了其他的Pan手势（常见于你为了关闭侧滑，而不小心添加了Pan），则会导致此控制器响应不灵敏
    // 特别注意：如果本RangeSlider所在的视图中添加了其他的Pan手势（常见于你为了关闭侧滑，而不小心添加了Pan），则会导致此控制器响应不灵敏
    //NSLog(@"buttonStartDrag");
    !self.gestureStateChangeBlock ?: self.gestureStateChangeBlock(CJSliderGRStateThumbDragBegin);
    
    BOOL isLeftThumb = [self __isLeftThumb:button];
    [self __bringSubviewToFront:isLeftThumb];
}

- (void)__bringSubviewToFront:(BOOL)bringLeft {
    // 移动结束后,将本次操作的滑块置顶。防止类型为RangeSlider的时候,如当左侧滑块和右侧滑块重合的时候,只能固定滑动某个，导致在都滑到最左/最右侧的时候，出现问题
    if (bringLeft) {
        [self bringSubviewToFront:self.leftThumb];
        [self bringSubviewToFront:self.leftPopover];
    } else {
        [self bringSubviewToFront:self.rightThumb];
        [self bringSubviewToFront:self.rightPopover];
    }
}

- (void)buttonEndDrag:(UIButton *)button {
    //NSLog(@"buttonEndDrag!");
    !self.gestureStateChangeBlock ?: self.gestureStateChangeBlock(CJSliderGRStateThumbDragEnd);
    
    BOOL isLeftThumb = [self __isLeftThumb:button];
    
    //更新Thumb状态
    [self updateEndDragThumbStatus:isLeftThumb isTouch:NO];
}

- (void)buttonDidDrag:(UIButton *)thumb withEvent:(UIEvent *)event {
    //NSLog(@"buttonDidDrag...");
    !self.gestureStateChangeBlock ?: self.gestureStateChangeBlock(CJSliderGRStateThumbDraging);
    
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
    [self doSomethingWhenCompleteUpdateFrameForThumb:thumb isDraging:YES];
}

/**
 *  更新slider的值显示
 */
- (void)doSomethingWhenCompleteUpdateFrameForThumb:(UIButton *)thumb isDraging:(BOOL)isDraging {
    //更新进度区间
    [self updateFrontImageView];
    
    //更新thumb的显示
    
    BOOL isLeftThumb  = [self __isLeftThumb:thumb];
    
    CJSliderValueChangeHappenType happenType;
    if (isLeftThumb) {
        happenType = CJSliderValueChangeHappenTypeLeftMove;
    } else {
        happenType = CJSliderValueChangeHappenTypeRightMove;
    }
    [self updatePopover:isLeftThumb happenType:happenType];
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

#pragma mark - Get Method
/// 获取要显示下本视图中的所有视图所需要的最小高度
- (CGFloat)minViewHeight {
    return self.thumbSize.height + self.popoverSpacing + self.popoverSize.height;
}

#pragma mark - Lazy
- (UIButton *)leftThumb {
    if (!_leftThumb) {
        _leftThumb = [CJSliderThumb buttonWithType:UIButtonTypeCustom]; // 直接使用UIButton易引起无法拖动的bug
        [_leftThumb addTarget:self action:@selector(buttonDidDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_leftThumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [_leftThumb addTarget:self action:@selector(buttonStartDrag:) forControlEvents:UIControlEventTouchDown];
    }
    return _leftThumb;
}

- (UIButton *)rightThumb {
    if (!_rightThumb) {
        _rightThumb = [CJSliderThumb buttonWithType:UIButtonTypeCustom]; // 直接使用UIButton易引起无法拖动的bug
        [_rightThumb addTarget:self action:@selector(buttonDidDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_rightThumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside| UIControlEventTouchUpOutside];
        [_rightThumb addTarget:self action:@selector(buttonStartDrag:) forControlEvents:UIControlEventTouchDown];
    }
    return _rightThumb;
}

@end
