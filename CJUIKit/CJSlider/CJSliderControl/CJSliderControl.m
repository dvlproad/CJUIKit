//
//  CJSliderControl.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSliderControl.h"
#import "CJSliderThumb.h"

#import "UIImage+CJCreate.h"
#import "UIImage+CJTransformSize.h"

static CGFloat const kCJSliderControlLeftPadding                         = 30.0f;
static NSTimeInterval const kCJSliderPopoverAnimationDuration     = 0.7f;
static NSTimeInterval const kCJSliderControlDidTapSlidAnimationDuration  = 0.3f;

@interface CJSliderControl () {
    CGFloat thumbMinimumOriginX;
    CGFloat thumbMaximumOriginX;
}

@property (nonatomic, assign) CGRect lastFrame;

@property (nonatomic, strong) UIImageView *trackImageView;
@property (nonatomic, strong) UIImageView *minimumTrackImageView;

@property (nonatomic, strong) UIButton *thumb;


@property (nonatomic, strong) UIImageView *baseImageView;


@property (nonatomic, strong) CJSliderPopover *popover;


@end

@implementation CJSliderControl

- (instancetype)initWithFrame:(CGRect)frame {
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

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"self.thumb.frame"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"self.thumb.frame"]) {
        [self updateMinimumTrackImageViewFrame];
    }
}

- (void)setupUI {
    self.backgroundColor = [UIColor cyanColor];
    
    [self addObserver:self forKeyPath:@"self.thumb.frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil]; //这里采用监听机制来优化,这样就不用每次self.thumb.frame改变的时候再去调用要执行的方法
    
    _trackHeight = 15;
    _thumbSize = CGSizeMake(30, 30);
    _popoverSize = CGSizeMake(30, 32);
    
    [self addSubview:self.trackImageView];
    [self addSubview:self.minimumTrackImageView];
    [self addSubview:self.thumb];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectEqualToRect(self.lastFrame, self.frame)) {
        return;
    }
    self.lastFrame = self.frame;
    
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    self.trackImageView.frame = trackRect;
    
    CGRect thumbRect = [self thumbRectForBounds:self.bounds trackRect:trackRect value:self.value thumbSize:self.thumbSize];
    self.thumb.frame = thumbRect;
    
    if (self.baseImageView) {
        CGSize baseThumbSize = CGSizeMake(self.thumbSize.width+10, self.thumbSize.height+10);
        CGRect baseThumbRect = [self baseThumbRectForBounds:self.bounds trackRect:trackRect value:self.baseValue thumbWidth:CGRectGetWidth(thumbRect) baseThumbSize:baseThumbSize];
        self.baseImageView.frame = baseThumbRect;
        self.baseImageView.alpha = 0.2;
    }
    
    if (self.popoverType != CJSliderPopoverDispalyTypeNone) {
        CGFloat popoverY = self.thumb.frame.origin.y - self.popoverSize.height;
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
    CGFloat trackImageViewHeight = self.trackHeight;
    CGFloat trackImageViewOriginY = CGRectGetHeight(bounds)/2 - trackImageViewHeight/2;
    
    CGFloat trackImageViewOriginX = kCJSliderControlLeftPadding;
    CGFloat trackImageViewWidth = CGRectGetWidth(bounds) - 2*trackImageViewOriginX;
    
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
    //计算该值在坐标上的X是多少
    CGFloat thumbImageViewWidth = thumbSize.width;
    
    CGFloat thumbCanMoveWidth = CGRectGetWidth(rect) - thumbImageViewWidth; //滑块可滑动的实际大小(要扣除滑块的大小0到总滑道减去滑块大小)
    CGFloat thumbImageViewOriginX = CGRectGetMinX(rect) + value*thumbCanMoveWidth;
    
    CGFloat thumbImageViewHeight = thumbSize.height;
    CGFloat thumbImageViewOriginY = CGRectGetHeight(bounds)/2 - thumbImageViewHeight/2;
    
    CGRect thumbRect = CGRectMake(thumbImageViewOriginX, thumbImageViewOriginY, thumbImageViewWidth, thumbImageViewHeight);
    
    return thumbRect;
}

/**
 *  通过滑道和滑块宽度获取指定值的X坐标
 *
 *  @param bounds           整个视图的bounds
 *  @param rect             滑道的frame
 *  @param value            要获取的滑块frame是value上的
 *  @param thumbWidth       滑块的宽度
 */
- (CGFloat)pointXForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value thumbWidth:(CGFloat)thumbWidth {
    CGFloat thumbCanMoveWidth = CGRectGetWidth(rect) - thumbWidth; //滑块可滑动的实际大小(要扣除滑块的大小0到总滑道减去滑块大小)
    CGFloat basePointX = CGRectGetMinX(rect) + value*thumbCanMoveWidth;
    
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
    CGFloat thumbCanMoveWidth = CGRectGetWidth(rect) - thumbWidth; //滑块可滑动的实际大小(要扣除滑块的大小0到总滑道减去滑块大小)
    CGFloat baseThumbImageViewOriginX = CGRectGetMinX(rect) + value*thumbCanMoveWidth;
    
    CGFloat baseThumbImageViewWidth = baseThumbSize.width;
    
    CGFloat baseThumbImageViewHeight = baseThumbSize.height;
    CGFloat baseThumbImageViewOriginY = CGRectGetHeight(bounds)/2 - baseThumbImageViewHeight/2;
    
    CGRect baseThumbRect = CGRectMake(baseThumbImageViewOriginX, baseThumbImageViewOriginY, baseThumbImageViewWidth, baseThumbImageViewHeight);
    
    return baseThumbRect;
}


- (void)setPopoverType:(CJSliderPopoverDispalyType)popoverType {
    if (popoverType != CJSliderPopoverDispalyTypeNone) {
        if (!self.popover) {
            [self addSubview:self.popover];
        }
    } else {
        if (self.popover) {
            [self.popover removeFromSuperview];
        }
    }
}

- (void)setValue:(CGFloat)value {
    _value = value;
}




#pragma mark - Private

/**
 *  更新slider的进度(每当滑块thumb的位置移动后都要执行此更新)
 */
- (void)updateMinimumTrackImageViewFrame {
    CGRect trackRect = self.trackImageView.frame;
    CGRect thumbRect = self.thumb.frame;
    
    CGFloat basePointX = [self pointXForBounds:self.bounds trackRect:trackRect value:self.baseValue thumbWidth:CGRectGetWidth(thumbRect)];
    
    CGFloat rangeOriginX = MIN(CGRectGetMinX(thumbRect), basePointX);
    CGFloat rangeWidth = ABS(CGRectGetMinX(thumbRect) - basePointX);
    CGFloat rangeHeight = CGRectGetHeight(trackRect);
    CGFloat rangeOriginY = CGRectGetMinY(trackRect);
    
    self.minimumTrackImageView.frame = CGRectMake(rangeOriginX, rangeOriginY, rangeWidth, rangeHeight);
    
    
    if (self.popoverType != CJSliderPopoverDispalyTypeNone) {
        CGRect popoverFrame = self.popover.frame;
        popoverFrame.origin.x = thumbRect.origin.x;
        self.popover.frame = popoverFrame;
    }
}


/**
 *  更新popover显示
 */
- (void)updatePopover {
    CGFloat percent = (self.thumb.frame.origin.x - self.trackImageView.frame.origin.x) / (self.trackImageView.frame.size.width - self.thumbSize.width);
    NSString *popoverText = @"";
    if (_popoverType == CJSliderPopoverDispalyTypePercent) {
        popoverText = [NSString stringWithFormat:@"%.1f%%", percent * 100]; //百分比显示
        
    } else if (self.popoverType == CJSliderPopoverDispalyTypeNum) {
        popoverText = [NSString stringWithFormat:@"%.1f", percent * (_maxValue - _minValue)];
    }
    self.value = [popoverText floatValue];
    [self.popover updatePopoverTextValue:popoverText];
    
    
    [self showPopoverAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(slider:didDargToValue:)]) {
        
        [self.delegate slider:self didDargToValue:self.value];
    }
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
/* 完整的描述请参见文件头部 */
- (void)hidePopover:(BOOL)isHidden {
    self.popover.hidden = isHidden;
}

- (void)buttonEndDrag:(UIButton *)button {
    [self hidePopoverAnimated:YES];
}

- (void)buttonDidDrag:(UIButton *)thumb withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:thumb] anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    CGFloat moveDistance = (point.x - lastPoint.x); //滑动的距离
    
    
    CGRect thumbFrame = thumb.frame;
    thumbFrame.origin.x += moveDistance;
    if (thumbFrame.origin.x < CGRectGetMinX(self.trackImageView.frame)) {
        thumbFrame.origin.x = CGRectGetMinX(self.trackImageView.frame);
    }
    if (thumbFrame.origin.x > CGRectGetMaxX(self.trackImageView.frame) - CGRectGetWidth(thumbFrame)) {
        thumbFrame.origin.x = CGRectGetMaxX(self.trackImageView.frame) - CGRectGetWidth(thumbFrame);
    }
    thumb.frame = thumbFrame;
    
    [self updatePopover];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.x < CGRectGetMinX(self.trackImageView.frame) ||
        point.x > CGRectGetMaxX(self.trackImageView.frame))
    {
        return;
    }
    
    [UIView animateWithDuration:kCJSliderControlDidTapSlidAnimationDuration animations:^{
        CGRect thumbFrame = self.thumb.frame;
        thumbFrame.origin.x = point.x - CGRectGetWidth(thumbFrame)/2;
        if (thumbFrame.origin.x < CGRectGetMinX(self.trackImageView.frame)) {
            thumbFrame.origin.x = CGRectGetMinX(self.trackImageView.frame);
        }
        if (thumbFrame.origin.x > CGRectGetMaxX(self.trackImageView.frame) - CGRectGetWidth(thumbFrame)) {
            thumbFrame.origin.x = CGRectGetMaxX(self.trackImageView.frame) - CGRectGetWidth(thumbFrame);
        }
        self.thumb.frame = thumbFrame;
        
    } completion:^(BOOL finished) {
    
        [self updatePopover];
        [self hidePopoverAnimated:YES];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidePopoverAnimated:YES];
}



#pragma mark - Getter and Setter
- (void)setBaseImage:(UIImage *)baseImage {
    if (!_baseImageView) {
        UIImage *baseImage = [UIImage imageNamed:@"slider_thumbImage"];
        _baseImageView = [[UIImageView alloc] initWithImage:baseImage];
        [self insertSubview:self.baseImageView aboveSubview:self.minimumTrackImageView];
    }
    [self.baseImageView setImage:baseImage];
}

- (void)setTrackHeight:(CGFloat)trackHeight {
    _trackHeight = trackHeight;
}

- (UIImageView *)trackImageView {
    if (!_trackImageView) {
        UIImage *backgroundImage = [UIImage imageNamed:@"slider_maximum_trackimage"];
        UIEdgeInsets insets = UIEdgeInsetsMake(3, 7, 3, 7);
        backgroundImage = [backgroundImage cj_resizableImageWithCapInsets:insets];
        _trackImageView = [[UIImageView alloc] initWithImage:backgroundImage];
//        _trackImageView.layer.cornerRadius = 8;
        _trackImageView.layer.masksToBounds = YES;
        _trackImageView.alpha = 0.5;
    }
    return _trackImageView;
}

- (UIImageView *)minimumTrackImageView {
    if (!_minimumTrackImageView) {
        UIImage *minimumTrackImageView = [UIImage imageNamed:@"slider_minimum_trackimage"];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 0, 5);
        minimumTrackImageView = [minimumTrackImageView cj_resizableImageWithCapInsets:insets];
        _minimumTrackImageView = [[UIImageView alloc] initWithImage:minimumTrackImageView];
//        _minimumTrackImageView.layer.cornerRadius = kCJSliderControlBackgroundViewCornerRadius;
        _minimumTrackImageView.layer.masksToBounds = YES;
    }
    return _minimumTrackImageView;
}

- (UIButton *)thumb {
    if (!_thumb) {
        _thumb = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thumb addTarget:self action:@selector(buttonDidDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_thumb addTarget:self action:@selector(buttonEndDrag:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
      
        
        _thumb.adjustsImageWhenHighlighted = NO;
        
//        UIImage *thumbImage = [UIImage imageNamed:@"slider_thumbImage"];
//        thumbImage = [thumbImage cj_transformImageToSize:CGSizeMake(kCJSliderThumbSizeWidth, kCJSliderThumbSizeHeight)];
//        [_thumb setImage:thumbImage forState:UIControlStateNormal];
        UIImage *colorImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(10, 10)];
        _thumb.alpha = 0.2;
//        [_thumb setImage:colorImage forState:UIControlStateNormal];
//        [_thumb setBackgroundImage:colorImage forState:UIControlStateNormal];
        [_thumb setBackgroundImage:[UIImage imageNamed:@"slider_thumbImage"] forState:UIControlStateNormal]; //注意①、不要使用setImage来设置图片，要使用setBackgroundImage来设置
        
//        [_thumb setImage:[UIImage imageNamed:@"slider_thumbImage"] forState:UIControlStateNormal];
//        [_thumb setImage:[UIImage imageNamed:@"slider_thumbImage"] forState:UIControlStateSelected];
        
//        [_thumb setImage:[UIImage imageNamed:@"slider_double_thumbImage_a"] forState:UIControlStateNormal];
//        [_thumb setImage:[UIImage imageNamed:@"slider_double_thumbImage_b"] forState:UIControlStateSelected];
    }
    return _thumb;
}

- (CJSliderPopover *)popover {
    
    if (!_popover) {
        _popover = [[CJSliderPopover alloc] initWithFrame:CGRectMake(0, 0, self.popoverSize.width, self.popoverSize.height)];
        _popover.alpha = 0;
    }
    return _popover;
}

-(void)setThumbImage:(UIImage *)thumbImage {
    
    [self.thumb setImage:thumbImage forState:UIControlStateNormal];
}

-(void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    UIImage *image = [UIImage cj_imageWithColor:minimumTrackTintColor size:self.thumbSize];
    self.trackImageView.image = image;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    UIImage *image = [UIImage cj_imageWithColor:maximumTrackTintColor size:self.thumbSize];
    self.minimumTrackImageView.image = image;
}




@end

