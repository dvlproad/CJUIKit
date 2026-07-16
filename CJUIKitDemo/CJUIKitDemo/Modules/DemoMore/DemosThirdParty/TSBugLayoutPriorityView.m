//
//  TSBugLayoutPriorityView.m
//  CJUIKitDemo
//
//  Created by qian on 2021/4/9.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "TSBugLayoutPriorityView.h"
#import "TSLayoutPriorityView.h"
#import <CQDemoKit/CQTSButtonFactory.h>
#import <CQDemoKit/CQTSContainerViewFactory.h>

@interface TSBugLayoutPriorityView () {
    
}
@property (nonatomic, strong) TSLayoutPriorityView *priorityView;
@property (nonatomic, strong) UIView *buttonContainerView;

@end

@implementation TSBugLayoutPriorityView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    __weak typeof(self)weakSelf = self;
    UIButton *constraintButton1 = [CQTSButtonFactory submitButtonWithSubmitTitle:@"原始frame" editTitle:@"缩短frame：mas_updateConstraints" showEditTitle:YES clickSubmitTitleHandle:^(UIButton * _Nonnull button) {
        button.selected = !button.selected;
        [self.priorityView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-100);
        }];
    } clickEditTitleHandle:^(UIButton * _Nonnull button) {
        button.selected = !button.selected;
        [self.priorityView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-0);
        }];
    }];
    UIButton *constraintButton2 = [CQTSButtonFactory submitButtonWithSubmitTitle:@"原始frame" editTitle:@"缩短frame：mas_remakeConstraints" showEditTitle:YES clickSubmitTitleHandle:^(UIButton * _Nonnull button) {
        button.selected = !button.selected;
        [weakSelf remakeConstraints_rightOffset:-100];
    } clickEditTitleHandle:^(UIButton * _Nonnull button) {
        button.selected = !button.selected;
        [weakSelf remakeConstraints_rightOffset:-0];
    }];
    
    NSArray<UIView *> *subViews = @[constraintButton1, constraintButton2];
    UIView *containerView = [CQTSContainerViewFactory containerViewAlongAxis:MASAxisTypeVertical withSubviews:subViews fixedSpacing:10];
    [self addSubview:containerView];
    CGFloat containerViewHeight = 44*2+1*10;
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(20);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(@(containerViewHeight));
    }];
    self.buttonContainerView = containerView;
    
    TSLayoutPriorityView *priorityView = [[TSLayoutPriorityView alloc] initWithFrame:CGRectZero];
    [self addSubview:priorityView];
    [priorityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-0);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self.buttonContainerView.mas_top);
    }];
    self.priorityView = priorityView;
}

#pragma mark - Event
- (void)updateName:(NSString *)name withRecognizePass:(BOOL)isRecognizePass {
    [self.priorityView updateName:name withRecognizePass:isRecognizePass];
}

- (void)remakeConstraints_rightOffset:(CGFloat)rightOffset {
    [self.priorityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(rightOffset);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self.buttonContainerView.mas_top);
    }];
    [self.priorityView layoutIfNeeded];
}

- (void)updateConstraints_rightOffset:(CGFloat)rightOffset {
    
}

#pragma mark - Class Method
+ (CGFloat)viewHeight {
    return 50 + 10 + 44*2+1*10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
