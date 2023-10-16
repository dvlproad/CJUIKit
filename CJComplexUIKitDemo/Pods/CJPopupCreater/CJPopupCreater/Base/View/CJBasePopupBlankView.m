//
//  CJBasePopupBlankView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "CJBasePopupBlankView.h"

@interface CJBasePopupBlankView () {
    
}
@property (nonatomic, copy) void(^ _Nullable tapBlankHandle)(CJBasePopupBlankView *bSelf);

@end




@implementation CJBasePopupBlankView

- (void)dealloc {
#if DEBUG
    NSLog(@"dealloc -[%@ dealloc], 地址%p", NSStringFromClass([self class]), self);       // 用于检测循环引用
#endif
}

#pragma mark - Init
/*
 *  初始化
 *
 *  @param tapBlock             点击视图的回调（每一个弹窗的背景点击回调都不一样）
 *
 *  @return 完整弹出框的容器视图blankContainer
 */
- (instancetype)initWithTapBlankHandle:(void(^ _Nullable)(CJBasePopupBlankView *bSelf))tapBlankHandle
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
#if DEBUG
        NSLog(@"init -[%@ init], 地址%p", NSStringFromClass([self class]), self);       // 用于检测循环引用
#endif
        _tapBlankHandle = tapBlankHandle;
        
        //UIColor *randomColor = [UIColor colorWithRed:arc4random()%255/256.0f green:arc4random()%255/256.0f blue:arc4random()%255/256.0f alpha:0.6f];
        //self.backgroundColor = randomColor;
        
        // 为了解决bug:将手势改为button，防止弹出的视图上有tableView或collectionView的时候，点击上面的cell会无法响应cell的点击事件，而变成响应tap的事件的bug
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:popupView action:@selector(cj_TapBlankViewAction:)];
//        [blankView addGestureRecognizer:tapGesture];
        UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //tapButton.backgroundColor = randomColor;
        [tapButton addTarget:self action:@selector(cj_TapBlankViewAction) forControlEvents:UIControlEventTouchUpInside];
        
        [CJBasePopupBlankView cjPopup_makeView:self addSubView:tapButton withEdgeInsets:UIEdgeInsetsZero];
    }
    return self;
}


#pragma mark - Private Method
- (void)cj_TapBlankViewAction {
    !self.tapBlankHandle ?: self.tapBlankHandle(self);
}


+ (void)cjPopup_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
