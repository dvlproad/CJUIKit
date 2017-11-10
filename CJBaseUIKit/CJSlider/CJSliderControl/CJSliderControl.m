//
//  CJSliderControl.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSliderControl.h"
#import "CJSliderThumb.h"

static NSTimeInterval const kCJSliderPopoverAnimationDuration     = 0.7f;
static NSTimeInterval const kCJSliderControlDidTapSlidAnimationDuration  = 0.3f;

@interface CJSliderControl () {
    CGFloat thumbMinimumOriginX;
    CGFloat thumbMaximumOriginX;
}
@property (nonatomic, assign, readonly) CGFloat thumbCanMoveWidth;  //滑块可滑动的实际大小

@property (nonatomic, assign) CGRect lastFrame;

@property (nonatomic, strong) CJSliderPopover *popover;


@end

@implementation CJSliderControl

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

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    
//    [self commonInit];
//}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"self.mainThumb.frame"];
    [self removeObserver:self forKeyPath:@"self.value"];
    
    if (self.leftThumb) {
        [self removeObserver:self forKeyPath:@"self.leftThumb.frame"];
        [self removeObserver:self forKeyPath:@"self.baseValue"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"self.mainThumb.frame"]) {
        [self updateIndicateValueForThumb:self.mainThumb];
        
    } else if ([keyPath isEqualToString:@"self.value"]) {
        [self reloadSlider];
        
    } else if ([keyPath isEqualToString:@"self.leftThumb.frame"]) {
        [self updateIndicateValueForThumb:self.leftThumb];
        
    } else if ([keyPath isEqualToString:@"self.baseValue"]) {
//        [self reloadSlider];
        
    }
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    //注册通知：self.mainThumb.frame更新的时候需要去更新选中区域 以及 value
    //这里采用监听机制来优化,这样就不用每次self.mainThumb.frame\self.value改变的时候再去调用要执行的方法
    [self addObserver:self forKeyPath:@"self.mainThumb.frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"self.value" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    _minValue = 0;
    _maxValue = 1;
    _thumbSize = CGSizeMake(30, 30);
    _popoverSize = CGSizeMake(30, 32);
    
    if (!_trackImageView) {
        _trackImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _trackImageView.backgroundColor = [UIColor clearColor];
        _trackImageView.layer.masksToBounds = YES;
        [self addSubview:_trackImageView];
    }
    
    
    if (!_minimumTrackImageView) {
        _minimumTrackImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _minimumTrackImageView.backgroundColor = [UIColor clearColor];
        _minimumTrackImageView.layer.masksToBounds = YES;
        [self addSubview:_minimumTrackImageView];
    }
    
    
    if (!_maximumTrackImageView) {
        _maximumTrackImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _maximumTrackImageView.backgroundColor = [UIColor clearColor];
        _maximumTrackImageView.layer.masksToBounds = YES;
        [self addSubview:_maximumTrackImageView];
    }
    
    [self addSubview:self.mainThumb];
}

#pragma mark - Lazy
- (UIButton *)mainThumb {
    if (!_mainThumb) {
        _mainThumb = [self createThumb];
    }
    return _mainThumb;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectEqualToRect(self.lastFrame, self.frame)) {
        return;
    }
    self.lastFrame = self.frame;
    
    [self reloadSlider];
}

/* 完整的描述请参见文件头部 */
- (void)reloadSlider {
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    self.trackImageView.frame = trackRect;
    
    CGRect thumbRect = [self thumbRectForBounds:self.bounds trackRect:trackRect value:self.value thumbSize:self.thumbSize];
    self.mainThumb.frame = thumbRect;
    
    if (self.leftThumb) {
        CGSize baseThumbSize = CGSizeMake(self.thumbSize.width-10, self.thumbSize.height-10);
        
        CGRect baseThumbRect = [self baseThumbRectForBounds:self.bounds trackRect:trackRect value:self.baseValue thumbWidth:CGRectGetWidth(thumbRect) baseThumbSize:baseThumbSize];
        self.leftThumb.frame = baseThumbRect;
    }
    
    if (self.popoverType != CJSliderPopoverDispalyTypeNone) {
        CGFloat popoverY = self.mainThumb.frame.origin.y - self.popoverSize.height;
        self.popover.frame = CGRectMake(0, popoverY, self.popoverSize.width, self.popoverSize.height);
    }
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
    CGFloat trackImageViewHeight = self.trackHeight;
    CGFloat trackImageViewOriginY = CGRectGetHeight(bounds)/2 - trackImageViewHeight/2;
    
    CGFloat trackImageViewOriginX = self.trackViewMinX;
    
    _trackViewMinX = 0 + self.trackViewMinXMargin;
    _trackViewMaxX = CGRectGetWidth(bounds) - self.trackViewMaxXMargin;
    CGFloat trackImageViewWidth = self.trackViewMaxX - self.trackViewMinX;
    
    return CGRectMake(trackImageViewOriginX, trackImageViewOriginY, trackImageViewWidth,trackImageViewHeight);
}

/**
 *  通过滑块的thumbSize获取在滑块在指定值时的完整坐标frame(x,y,w,h)
 *
 *  @param bounds       整个视图的bounds
 *  @param rect         滑道的frame
 *  @param value        要获取的滑块frame是value上的
 *  @param thumbSize    滑块的大小
 */
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value thumbSize:(CGSize)thumbSize {
    CGFloat percent = value /(self.maxValue - self.minValue);
    
    //计算该值在坐标上的X是多少
    CGFloat thumbImageViewWidth = thumbSize.width;
    
    CGFloat thumbImageViewHeight = thumbSize.height;
    CGFloat thumbImageViewOriginY = CGRectGetHeight(bounds)/2 - thumbImageViewHeight/2;
    
    _thumbMoveMinX = 0 + self.thumbMoveMinXMargin;
    _thumbMoveMaxX = CGRectGetWidth(bounds) - self.thumbMoveMaxXMargin;
    _thumbCanMoveWidth = (self.thumbMoveMaxX-thumbImageViewWidth) - self.thumbMoveMinX; //滑块可滑动的实际大小
    CGFloat thumbImageViewOriginX = CGRectGetMinX(rect) + percent*self.thumbCanMoveWidth;
    
    CGRect thumbRect = CGRectMake(thumbImageViewOriginX, thumbImageViewOriginY, thumbImageViewWidth, thumbImageViewHeight);
    return thumbRect;
}

/**
 *  通过滑道宽度获取指定值的X坐标
 *
 *  @param bounds           整个视图的bounds
 *  @param rect             滑道的frame
 *  @param value            要获取的滑块frame是value上的
 */
- (CGFloat)pointXForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    CGFloat percent = value /(self.maxValue - self.minValue);
    
    CGFloat basePointX = CGRectGetMinX(rect) + percent*self.thumbCanMoveWidth;
    
    return basePointX;
}

/**
 *  通过基准块的baseThumbSize获取在基准块在指定值时的完整坐标frame(x,y,w,h)
 *
 *  @param bounds           整个视图的bounds
 *  @param rect             滑道的frame
 *  @param value            要获取的滑块frame是value上的
 *  @param thumbWidth       滑块的宽度
 *  @param baseThumbSize    基准块的大小
 */
- (CGRect)baseThumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value thumbWidth:(CGFloat)thumbWidth baseThumbSize:(CGSize)baseThumbSize {
    
    CGFloat basePointX = [self pointXForBounds:self.bounds trackRect:rect value:value];
    CGFloat baseThumbImageViewOriginX = basePointX;
    
    CGFloat baseThumbImageViewWidth = baseThumbSize.width;
    
    CGFloat baseThumbImageViewHeight = baseThumbSize.height;
    CGFloat baseThumbImageViewOriginY = CGRectGetHeight(bounds)/2 - baseThumbImageViewHeight/2;
    
    CGRect baseThumbRect = CGRectMake(baseThumbImageViewOriginX, baseThumbImageViewOriginY, baseThumbImageViewWidth, baseThumbImageViewHeight);
    
    return baseThumbRect;
}


- (void)setPopoverType:(CJSliderPopoverDispalyType)popoverType {
    _popoverType = popoverType;
    if (popoverType != CJSliderPopoverDispalyTypeNone) {
        if (!_popover) {
            _popover = [[CJSliderPopover alloc] initWithFrame:CGRectMake(0, 0, self.popoverSize.width, self.popoverSize.height)];
            _popover.alpha = 0;
            [self addSubview:_popover];
        }
    } else {
        if (_popover) {
            [_popover removeFromSuperview];
        }
    }
}




#pragma mark - Private

/**
 *  更新对应thumb指示的值(每当滑块thumb的位置移动后都要执行此更新，并记得同时得当前选中的区域)
 */
- (void)updateIndicateValueForThumb:(UIButton *)thumb {
    CGRect trackRect = self.trackImageView.frame;
    CGRect thumbRect = thumb.frame;
    
    //value
    NSAssert(self.thumbCanMoveWidth != 0, @"除数不能为0");
    CGFloat percent = (CGRectGetMinX(thumbRect) - self.thumbMoveMinX) / self.thumbCanMoveWidth;
    
    CGFloat value = percent * (self.maxValue - self.minValue);
    if (thumb == self.mainThumb) {
        _value = value;
        
    } else if (thumb == self.leftThumb) {
        _baseValue = value;
        
    } else {
        NSAssert(NO, @"Error:CJSliderControl发生错误了!");
    }
    
    
    //minimumTrackImageView.frame
    CGFloat basePointX = [self pointXForBounds:self.bounds trackRect:trackRect value:self.baseValue];
    
    
    CGFloat rangeMinX = 0;
    CGFloat rangeWidth = 0;
    switch (self.rangeType) {
        case CJSliderRangeTypeMinToMin:
        {
            rangeMinX = MIN(CGRectGetMinX(self.mainThumb.frame), basePointX);
            rangeWidth = ABS(CGRectGetMinX(self.mainThumb.frame) - basePointX);
            break;
        }
        default:
        {
            rangeMinX = MIN(CGRectGetMidX(self.mainThumb.frame), basePointX);
            rangeWidth = ABS(CGRectGetMidX(self.mainThumb.frame) - basePointX);
            break;
        }
    }
    
    CGFloat rangeHeight = CGRectGetHeight(trackRect);
    CGFloat rangeOriginY = CGRectGetMinY(trackRect);
    
    CGFloat rangeMaxX = rangeMinX+rangeWidth;
    self.minimumTrackImageView.frame = CGRectMake(rangeMinX, rangeOriginY, rangeWidth, rangeHeight);
    self.maximumTrackImageView.frame = CGRectMake(rangeMaxX, rangeOriginY, CGRectGetMaxX(trackRect)-rangeMaxX, rangeHeight);
    
    //popover
    if (self.popoverType != CJSliderPopoverDispalyTypeNone) {
        CGRect popoverFrame = self.popover.frame;
        popoverFrame.origin.x = thumbRect.origin.x;
        self.popover.frame = popoverFrame;
    }
}


/**
 *  更新slider的值显示
 */
- (void)doSomethingWhenCompleteUpdateFrameForThumb:(UIButton *)thumb {
    CGFloat percent = 0;
    if (thumb == _mainThumb) {
        percent = self.value /(_maxValue - _minValue);
    } else {
        percent = self.baseValue /(_maxValue - _minValue);
    }
    
    if (self.popoverType != CJSliderPopoverDispalyTypeNone) {
        [self showPopoverTextWithPercentValue:percent animated:YES];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(slider:didDargToValue:)]) {
        if (thumb == self.mainThumb) {
            [self.delegate slider:self didDargToValue:self.value];
            
        } else if (thumb == self.leftThumb) {
            [self.delegate slider:self didDargToValue:self.baseValue];
        }
        
    }
}

- (void)showPopoverTextWithPercentValue:(CGFloat)percent animated:(BOOL)animated {
    NSString *popoverText = @"";
    if (self.popoverType == CJSliderPopoverDispalyTypePercent) {
        popoverText = [NSString stringWithFormat:@"%.1f%%", percent * 100]; //百分比显示
        
    } else if (self.popoverType == CJSliderPopoverDispalyTypeNum) {
        popoverText = [NSString stringWithFormat:@"%.1f", percent * (_maxValue - _minValue)];
    }
    
    [self.popover updatePopoverTextValue:popoverText];
    
    if (animated) {
        if (animated) {
            [UIView animateWithDuration:kCJSliderPopoverAnimationDuration animations:^{
                self.popover.alpha = 1.0;
            }];
        } else {
            self.popover.alpha = 1.0;
        }
        
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
/* 完整的描述请参见文件头部 */
- (void)hidePopover:(BOOL)isHidden {
    self.popover.hidden = isHidden;
}


#pragma mark - 点击的事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.allowTouchChangeValue == NO) {
        return;
    }
    
    [self hidePopoverAnimated:YES];
    
    if (self.adsorbInfos) {
        [self adsorbToValue];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (self.allowTouchChangeValue == NO) {
        return;
    }
    
    if (self.leftThumb) { //TODO:如果是range效果，暂不支持touch来选中值的效果
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.x < CGRectGetMinX(self.trackImageView.frame) ||
        point.x > CGRectGetMaxX(self.trackImageView.frame))
    {
        return;
    }
    
    [UIView animateWithDuration:kCJSliderControlDidTapSlidAnimationDuration animations:^{
        CGRect thumbFrame = self.mainThumb.frame;
        thumbFrame.origin.x = point.x - CGRectGetWidth(thumbFrame)/2;
        if (thumbFrame.origin.x < CGRectGetMinX(self.trackImageView.frame)) {
            thumbFrame.origin.x = CGRectGetMinX(self.trackImageView.frame);
        }
        if (thumbFrame.origin.x > CGRectGetMaxX(self.trackImageView.frame) - CGRectGetWidth(thumbFrame)) {
            thumbFrame.origin.x = CGRectGetMaxX(self.trackImageView.frame) - CGRectGetWidth(thumbFrame);
        }
        self.mainThumb.frame = thumbFrame;
        
    } completion:^(BOOL finished) {
        
        [self doSomethingWhenCompleteUpdateFrameForThumb:self.mainThumb];
        [self hidePopoverAnimated:YES];
    }];
}

#pragma mark - 拖动的事件
- (void)buttonEndDrag:(UIButton *)button {
    [self hidePopoverAnimated:YES];
    
    if (self.adsorbInfos) {
        [self adsorbToValue];
    }
}

- (void)buttonDidDrag:(UIButton *)thumb withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:thumb] anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    CGFloat moveDistance = (point.x - lastPoint.x); //滑动的距离
    if (moveDistance == 0) {
        return;
    }
    
    //判断是否需要阻止leftThumb右移,阻止rightThumb左移
    CGFloat validMoveDistance = [self validMoveDistanceForThumb:thumb withMoveDistance:moveDistance];
    if (validMoveDistance == 0) {
        return;
    }
    
    //更新视图
    CGRect thumbFrame = thumb.frame;
    thumbFrame.origin.x += validMoveDistance;
    thumb.frame = thumbFrame;
    
    //更新完后的额外操作(如显示popover之类的)
    [self doSomethingWhenCompleteUpdateFrameForThumb:thumb];
}

- (CGFloat)validMoveDistanceForThumb:(UIButton *)thumb withMoveDistance:(CGFloat)moveDistance {
    CGFloat validMoveDistance = moveDistance;
    //判断是否左移(否，则是右移)
    BOOL isSlideToLeft = moveDistance < 0;
    if (self.leftThumb == nil) { //如果不是range类型的
        if (isSlideToLeft) {
            CGFloat canMaxMoveDistance = CGRectGetMinX(self.mainThumb.frame) - self.thumbMoveMinX;
            
            if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
                validMoveDistance = -canMaxMoveDistance;
            }
            
        } else {
            CGFloat canMaxMoveDistance = self.thumbMoveMaxX - CGRectGetMaxX(self.mainThumb.frame);
            
            if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
                validMoveDistance = canMaxMoveDistance;
            }
        }
        return validMoveDistance;
        
    } else {
        BOOL isLeftThumb  = ( thumb == self.leftThumb );
        if (!isLeftThumb) {
            if (isSlideToLeft) { //主滑块向左滑时候
                CGFloat rightThumbMoveMinMidX = CGRectGetMidX(self.leftThumb.frame); //右侧滑块移动可到的最小MidX
                CGFloat canMaxMoveDistance = CGRectGetMidX(self.mainThumb.frame) - rightThumbMoveMinMidX;
                
                if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
                    validMoveDistance = -canMaxMoveDistance;
                }
                
            } else { //主滑块向右滑时候
                CGFloat rightThumbMoveMaxMidX = self.thumbMoveMaxX - CGRectGetWidth(thumb.frame)/2; //右侧滑块移动可到的最大中心
                CGFloat canMaxMoveDistance = rightThumbMoveMaxMidX - CGRectGetMidX(self.mainThumb.frame);
                
                if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
                    validMoveDistance = canMaxMoveDistance;
                }
            }
            
        } else if (isLeftThumb) {
            if (!isSlideToLeft) { //左滑块向右滑时候
                CGFloat leftThumbMoveMaxMidX = CGRectGetMidX(self.mainThumb.frame); //左侧滑块移动可到的最小MidX
                CGFloat canMaxMoveDistance = leftThumbMoveMaxMidX - CGRectGetMidX(self.leftThumb.frame);
                
                if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
                    validMoveDistance = canMaxMoveDistance;
                }
                
            } else { //左滑块向左滑时候
                CGFloat leftThumbMoveMinMidX = self.thumbMoveMinX + CGRectGetWidth(thumb.frame)/2; //右侧滑块移动可到的最大中心
                CGFloat canMaxMoveDistance = CGRectGetMidX(self.leftThumb.frame) - leftThumbMoveMinMidX;
                
                if (ABS(moveDistance) > ABS(canMaxMoveDistance)) {
                    validMoveDistance = -canMaxMoveDistance;
                }
            }
        }
        
        return validMoveDistance;
    }
}



#pragma mark - Getter and Setter
- (void)setSliderType:(CJSliderType)sliderType {
    if (sliderType == CJSliderTypeNormal) {
        if (!_leftThumb) {
            [_leftThumb removeFromSuperview];
        }
        
    } else if (sliderType == CJSliderTypeRange) {
        if (!_leftThumb) {
            _leftThumb = [self createThumb];
            [self insertSubview:_leftThumb aboveSubview:self.minimumTrackImageView];
            
            //注册通知：self.leftThumb.frame更新的时候需要去更新选中区域 以及 value
            //这里采用监听机制来优化,这样就不用每次self.leftThumb.frame\self.value改变的时候再去调用要执行的方法
            [self addObserver:self forKeyPath:@"self.leftThumb.frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
            [self addObserver:self forKeyPath:@"self.baseValue" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        }
    }
}


- (UIButton *)createThumb {
    UIButton *thumb = [UIButton buttonWithType:UIButtonTypeCustom];
    [thumb addTarget:self action:@selector(buttonDidDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [thumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    
    thumb.adjustsImageWhenHighlighted = NO;
    
    return thumb;
}



#pragma mark - 增加吸附功能模块
/**
 *  设置吸附信息
 *
 *  @param adsorbInfos 吸附信息(含吸附区间及该区间要吸附到什么值)
 */
- (void)setAdsorbInfos:(NSMutableArray<CJAdsorbModel *> *)adsorbInfos {
    _adsorbInfos = adsorbInfos;
    
    [self addTarget:self action:@selector(adsorbToValue) forControlEvents:UIControlEventTouchUpInside];
}


/**
 *  拖动结束后进行吸附判断及吸附到指定值
 */
- (void)adsorbToValue {
    CGFloat curValue = self.value;
    
    for (CJAdsorbModel *adsorbInfo in self.adsorbInfos) {
        if (curValue > adsorbInfo.adsorbMin && curValue <= adsorbInfo.adsorbMax) {
            [self setValue:adsorbInfo.adsorbToValue animated:YES];
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            if (self.delegate && [self.delegate respondsToSelector:@selector(slider:adsorbToValue:animatedDuration:)]) {
                [self.delegate slider:self adsorbToValue:adsorbInfo.adsorbToValue animatedDuration:0.3];
            }
            break;
        }
    }
}

- (void)setValue:(float)value animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.value = value;
        }];
        
    } else {
        self.value = value; //调用self.value这样才能触发之前设置的KVO
    }
}


@end

