//
//  CommentsPopView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/05/10.
//  Copyright © 2019年 dvlproad. All rights reserved.
//

#import "CQCommentsPopView.h"
#import "UIView+CJPanAction.h"

#define RGBA(r, g, b,a)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]



@interface CQCommentsPopView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView                           *container;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
//当前正在拖拽的是否是tableView
@property (nonatomic, assign) BOOL isDragScrollView;
@property (nonatomic, strong) UIScrollView *scrollerView;
//向下拖拽最后时刻的位移
@property (nonatomic, assign) CGFloat lastDrapDistance;


@end


@implementation CQCommentsPopView

+ (instancetype)commentsPopViewWithFrame:(CGRect)frame commentBackView:(UIView *)commentBackView {
    CQCommentsPopView *view = [[CQCommentsPopView alloc] initWithFrame:frame commentBackView:commentBackView];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame commentBackView:(UIView *)commentBackView {
    self = [super initWithFrame:frame];
    if (self) {
        self.isDragScrollView = NO;
        self.lastDrapDistance = 0.0;
        self.frame = frame;
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)];
        self.tapGestureRecognizer = tapGestureRecognizer;
        tapGestureRecognizer.delegate = self;
        
        [self addGestureRecognizer:tapGestureRecognizer];
        
        self.container  = commentBackView;
        self.container.frame = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height * 3 / 4);
        [self addSubview:self.container];
        
        //添加拖拽手势
        [self.container cj_addPanWithPanCompleteDismissBlock:^{
            [self dismiss];
        }];
    }
    return self;
}


#pragma mark - Action

//update method
- (void)showToView:(UIView *)view{
    [self removeFromSuperview];
    [view addSubview:self];
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = self.container.frame;
        frame.origin.y = frame.origin.y - frame.size.height;
        self.container.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame = self.container.frame;
        frame.origin.y = frame.origin.y + frame.size.height;
        self.container.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


//点击手势
- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point] && sender.view == self) {
        [self dismiss];
        return;
    }
}

@end









