//
//  CQAgeRangeSliderControl.m
//  CJUIKitDemo
//
//  Created by qian on 2020/11/9.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQAgeRangeSliderControl.h"
#import "CQShakeUtil.h"

@interface CQAgeRangeSliderControl () {
    
}
@property (nonatomic, copy) void(^chooseCompleteBlock)(NSInteger minAge, NSInteger maxAge);

@end

@implementation CQAgeRangeSliderControl

#pragma mark - Init
- (instancetype)initWithStartRangeAge:(NSInteger)startRangeAge
                          endRangeAge:(NSInteger)endRangeAge
                  chooseCompleteBlock:(void(^)(NSInteger minAge, NSInteger maxAge))chooseCompleteBlock
{
    return [self initWithMinRangeAge:16 maxRangeAge:60 startRangeAge:startRangeAge endRangeAge:endRangeAge chooseCompleteBlock:chooseCompleteBlock];
}

/*
 *  初始化
 *
 *  @param minRangeAge                  选择范围的最小值
 *  @param maxRangeAge                  选择范围的最大值
 *  @param startRangeAge                初始范围的起始值
 *  @param endRangeAge                  初始范围的结束值
 *  @param chooseCompleteBlock          选择结束，返回选择的最大和最小值
 *
 *  @param 年龄范围选择slider滑块视图
 */
- (instancetype)initWithMinRangeAge:(NSInteger)minRangeAge
                        maxRangeAge:(NSInteger)maxRangeAge
                      startRangeAge:(NSInteger)startRangeAge
                        endRangeAge:(NSInteger)endRangeAge
                chooseCompleteBlock:(void(^)(NSInteger minAge, NSInteger maxAge))chooseCompleteBlock
{
    self = [super initWithMinRangeValue:minRangeAge maxRangeValue:maxRangeAge startRangeValue:startRangeAge endRangeValue:endRangeAge createTrackViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:248/255.0f alpha:1.0];        // #F7F7F8
        return view;
    } createFrontViewBlock:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor colorWithRed:12/255.0f green:16/255.0f blue:27/255.0f alpha:1.0];            // #0C101B
        return view;
    } createPopoverViewBlock:^UIView *(BOOL left) {
        CGFloat popoverHeight = self.popoverSize.height;// 弹出框的高
        CGFloat popoverWidth = self.popoverSize.width;  // 弹出框的宽
        
        UILabel *popoverLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, popoverWidth, popoverHeight)];
        //popoverLabel.backgroundColor = [UIColor redColor];
        popoverLabel.font = [UIFont systemFontOfSize:22];
        popoverLabel.textColor = [UIColor colorWithRed:12/255.0 green:16/255.0 blue:27/255.0 alpha:1.0]; // #0C101B
        popoverLabel.textAlignment = NSTextAlignmentCenter;
        return popoverLabel;
    } valueChangedBlock:^(CJRangeSliderControl *bSlider, CJSliderValueChangeHappenType happenType, CGFloat leftThumbPercent, CGFloat rightThumbPercent, CGFloat leftPopoverNum, CGFloat rightPopoverNum) {
        [self __ageUpdateValueByHappenType:happenType
                              leftThumbNum:leftPopoverNum
                             rightThumbNum:rightPopoverNum];
        
    } gestureStateChangeBlock:^(CJSliderGRState gestureRecognizerState) {
        if (gestureRecognizerState == CJSliderGRStateThumbDragEnd || gestureRecognizerState == CJSliderGRStateTrackTouchEnd) {
            [CQShakeUtil shake];
        }
    }];
    if (self) {
        _chooseCompleteBlock = chooseCompleteBlock;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    
    self.trackHeight = 4;                       // 设置滑道高度
    self.popoverSize = CGSizeMake(28, 22);      // 设置弹出框大小
    self.popoverSpacing = 29;
    [self configThumbMoveMinXMargin:0
                      leftThumbSize:CGSizeMake(26, 26)
      trackViewMinXIsLeftThumbXType:CJThumbXTypeMid];
    [self configThumbMoveMaxXMargin:0
                     rightThumbSize:CGSizeMake(26, 26)
     trackViewMaxXIsRightThumbXType:CJThumbXTypeMid];

    
    UIImage *normalImage = [UIImage imageNamed:@"slider_range_start"];
    UIImage *highlightedImage = [UIImage imageNamed:@"slider_range_start"];
    [self.leftThumb setImage:normalImage forState:UIControlStateNormal];
    [self.leftThumb setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.rightThumb setImage:normalImage forState:UIControlStateNormal];
    [self.rightThumb setImage:highlightedImage forState:UIControlStateHighlighted];
    
//    self.leftThumb.alpha = 0.5;
//    self.rightThumb.alpha = 0.5;
//    [self.leftThumb setBackgroundColor:[UIColor purpleColor]];
//    [self.rightThumb setBackgroundColor:[UIColor brownColor]];
}

#pragma mark - Event
/*
 *  请求到网络数据后更新选择值
 *
 *  @param startRangeAge                初始范围的起始值
 *  @param endRangeAge                  初始范围的结束值
 */
- (void)updateStartRangeAge:(NSInteger)startRangeAge
                endRangeAge:(NSInteger)endRangeAge
{
    [super updateStartRangeValue:startRangeAge endRangeValue:endRangeAge];
}

#pragma mark - Private Method
/*
 *  根据选中的值更新popover上的值
 *
 *  @param happenInLeft         滑块上的值改变发生的事件来源类型
 *  @param leftThumbPercent     左边滑块中心点所在滑道的比例
 *  @param rightThumbPercent    右边滑块中心点所在滑道的比例
 */
- (void)__ageUpdateValueByHappenType:(CJSliderValueChangeHappenType)happenType
                        leftThumbNum:(CGFloat)leftPopoverNum
                       rightThumbNum:(CGFloat)rightPopoverNum
{
    BOOL shouldUpdateLeft = YES;
    BOOL shouldUpdateRight = YES;
    
    switch (happenType) {
        case CJSliderValueChangeHappenTypeInit: {
            shouldUpdateLeft = YES;
            shouldUpdateRight = YES;
            break;
        }
        case CJSliderValueChangeHappenTypeLeftMove: {
            shouldUpdateLeft = YES;
            shouldUpdateRight = NO;
            break;
        }
        case CJSliderValueChangeHappenTypeRightMove: {
            shouldUpdateLeft = NO;
            shouldUpdateRight = YES;
            break;
        }
        default:{
            shouldUpdateLeft = YES;
            shouldUpdateRight = YES;
            break;
        }
    }
    
    NSInteger startAge = (NSInteger)leftPopoverNum;
    NSInteger endAge = (NSInteger)rightPopoverNum;
    if (shouldUpdateLeft) {
        NSString *leftContent = [NSString stringWithFormat:@"%zd", startAge];
        [(UILabel *)self.leftPopover setText:leftContent];
    }
    
    if (shouldUpdateRight) {
        NSString *rightContent = [NSString stringWithFormat:@"%zd", endAge];
        [(UILabel *)self.rightPopover setText:rightContent];
    }
    //NSLog(@"age rangeSlider rangion:%f,%f", startAge, endAge);
    _startRangeAge = startAge;
    _endRangeAge = endAge;

    !_chooseCompleteBlock ?: _chooseCompleteBlock(startAge, endAge);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
