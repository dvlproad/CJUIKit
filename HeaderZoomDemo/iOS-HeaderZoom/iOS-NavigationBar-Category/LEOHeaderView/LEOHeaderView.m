//
//  LEOHeaderView.m
//  iOS-NavigationBar-Category
//
//  Created by 雷亮 on 16/7/29.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LEOHeaderView.h"
#import "UIView+leoAdd.h"

#define kSelfWidth  self.bounds.size.width
#define kSelfHeight self.bounds.size.height
#define kKeyWindow [[UIApplication sharedApplication] keyWindow]

#ifndef BLOCK_EXE
#define BLOCK_EXE(block, ...) \
if (block) { \
    block(__VA_ARGS__); \
} 
#endif

static CGFloat const kHeaderWidth = 100; // 头像宽度
static CGFloat const kHeaderMinWidth = 40; // 头像在顶部时的宽度

@interface LEOHeaderView ()

@property (nonatomic, copy) ReachtopBlock block;
@property (nonatomic, copy) PressHeaderBlock pressBlock;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *label;
/**
 * @property navigationBarHeaderImageView: 当滚动视图滚动到顶部的时候如果有navigationBar则将这个视图添加到navigationBar上
 */
@property (nonatomic, strong) UIImageView *navigationBarHeaderImageView;
/**
 * @property aboveHeaderView: 覆盖在headerImageView上的透明视图, 在上面添加点击手势
 */
@property (nonatomic, strong) UIView *aboveHeaderView;

@end

@implementation LEOHeaderView

#pragma mark -
#pragma mark - external calling methods
- (void)setBackgroundImage:(UIImage *)image {
    self.backgroundImageView.image = image;
}

- (void)setHeaderImage:(UIImage *)image text:(NSString *)text {
    self.headerImageView.image = image;
    self.label.text = text;
}

- (void)reloadWithScrollView:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + kSelfHeight - kNavigationBarHeight;
    if (offsetY < 0) {
        // 下拉
        // 图片放大
        CGFloat centerX = kSelfWidth / 2;
        CGFloat centerY = (kSelfHeight - offsetY) / 2;
        CGFloat kScale = (kSelfHeight - offsetY) / kSelfHeight;
        self.backgroundImageView.center = CGPointMake(centerX, centerY);
        self.backgroundImageView.transform = CGAffineTransformMakeScale(kScale, kScale);
    } else if (offsetY > 0 && offsetY <= kSelfHeight - kNavigationBarHeight) {
        // 上拉
        // 改变背景图的位置
        self.top = -offsetY / 2;
        // 每移动1像素需要改变的比例
        CGFloat kEachPixel = (1 - kHeaderMinWidth / kHeaderWidth) / (kSelfHeight - kNavigationBarHeight);
        CGFloat kScale = 1 - offsetY * kEachPixel;
        self.headerImageView.transform = CGAffineTransformMakeScale(kScale, kScale);
    }

    BOOL reachtop = scrollView.contentOffset.y > 0 ? YES : NO;
    BLOCK_EXE(_block, reachtop)
    
    [self fixHeaderImageViewWithReachtop:reachtop];
    [self resetAboveHeaderViewFrame];
}

- (void)pressHeaderImageWithBlock:(PressHeaderBlock)block {
    self.navigationBarHeaderImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressHeaderAction:)];
    tap.numberOfTapsRequired = 1;
    [self.navigationBarHeaderImageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressHeaderAction:)];
    tap1.numberOfTapsRequired = 1;
    [self.aboveHeaderView addGestureRecognizer:tap1];
    [kKeyWindow addSubview:self.aboveHeaderView];
    
    self.pressBlock = block;
}

- (void)scrollViewStateChangeWithBlock:(ReachtopBlock)block {
    self.block = block;
}

#pragma mark -
#pragma mark - 临界值调整headerImageView
- (void)fixHeaderImageViewWithReachtop:(BOOL)reachtop {
    if (self.viewController.navigationController) {
        if (reachtop) {
            self.aboveHeaderView.hidden = YES;
            self.headerImageView.hidden = YES;
            // 移到navigationBar上
            UIView *titleView = [[UIView alloc] init];
            titleView.size = CGSizeMake(kHeaderMinWidth, kHeaderMinWidth);
            titleView.backgroundColor = [UIColor clearColor];
            self.navigationBarHeaderImageView.centerY = kHeaderMinWidth / 2 - 3;
            [titleView addSubview:self.navigationBarHeaderImageView];
            self.viewController.navigationItem.titleView = titleView;
        } else {
            self.aboveHeaderView.hidden = NO;
            self.headerImageView.hidden = NO;
            // 从navigationBar上移除
            [self.navigationBarHeaderImageView removeFromSuperview];
            self.viewController.navigationItem.titleView = nil;
        }
    }
}

- (void)resetAboveHeaderViewFrame {
    if (!self.aboveHeaderView.superview) {
        [kKeyWindow addSubview:self.aboveHeaderView];
    }
    CGRect frameOnWindow = [self.headerImageView convertRect:self.headerImageView.bounds toView:nil];
    if (frameOnWindow.origin.x != 0) {
        self.aboveHeaderView.frame = frameOnWindow;
    }
}

#pragma mark -
#pragma mark - getter methods
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.frame = CGRectMake(0, 0, kSelfWidth, kSelfHeight);
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        _backgroundImageView.clipsToBounds = YES;
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.backgroundColor = [UIColor clearColor];
        _headerImageView.size = CGSizeMake(kHeaderWidth, kHeaderWidth);
        _headerImageView.center = CGPointMake(kSelfWidth / 2, kSelfHeight / 2);
        _headerImageView.layer.cornerRadius = kHeaderWidth / 2;
        _headerImageView.clipsToBounds = YES;
        [self addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = 1;
        _label.size = CGSizeMake(kSelfWidth, 20);
        _label.centerY = kSelfWidth / 2;
        _label.top = self.headerImageView.bottom + 15;
        [self addSubview:_label];
    }
    return _label;
}

- (UIImageView *)navigationBarHeaderImageView {
    if (!_navigationBarHeaderImageView) {
        _navigationBarHeaderImageView = [[UIImageView alloc] init];
        _navigationBarHeaderImageView.backgroundColor = [UIColor clearColor];
        _navigationBarHeaderImageView.image = [_headerImageView.image copy];
        _navigationBarHeaderImageView.size = CGSizeMake(kHeaderMinWidth, kHeaderMinWidth);
        _navigationBarHeaderImageView.layer.cornerRadius = kHeaderMinWidth / 2;
        _navigationBarHeaderImageView.clipsToBounds = YES;
    }
    return _navigationBarHeaderImageView;
}

- (UIView *)aboveHeaderView {
    if (!_aboveHeaderView) {
        _aboveHeaderView = [[UIView alloc] init];
        _aboveHeaderView.backgroundColor = [UIColor clearColor];
        _aboveHeaderView.size = CGSizeMake(kHeaderWidth, kHeaderWidth);
        _aboveHeaderView.center = CGPointMake(kSelfWidth / 2, kSelfHeight / 2);
    }
    return _aboveHeaderView;
}

#pragma mark -
#pragma mark - 点击方法
- (void)pressHeaderAction:(UITapGestureRecognizer *)sender {
    BLOCK_EXE(_pressBlock);
}

- (void)dealloc {
    if (_aboveHeaderView) {
        [_aboveHeaderView removeFromSuperview];
        _aboveHeaderView = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
