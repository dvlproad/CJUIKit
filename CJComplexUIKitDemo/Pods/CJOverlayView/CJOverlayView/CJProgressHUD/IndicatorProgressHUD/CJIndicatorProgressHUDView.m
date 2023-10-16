//
//  CJIndicatorProgressHUDView.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJIndicatorProgressHUDView.h"
#import "CJOverlayTextSizeUtil.h"

@interface CJIndicatorProgressHUDView () {
    
}
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, assign) CGRect lastFrame;

@end


@implementation CJIndicatorProgressHUDView

/**
 *  创建单例
 *
 *  @return 单例
 */
+ (CJIndicatorProgressHUDView *)sharedInstance {
    static CJIndicatorProgressHUDView *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectEqualToRect(self.lastFrame, self.frame)) {
        return; //防止多次调用
    }
    self.lastFrame = self.frame;
    
    [self reloadHudView];
}

- (void)reloadHudView {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    // activityIndicatorView  和 imageView 的位置(二者只会显示一个)
    CGFloat indicatorWidth = 37;
    CGFloat indicatorHeight = 37;
    CGFloat indicatorX = (width - indicatorWidth)/2;
    CGFloat indicatorY;
    
    // 有文字消息
    NSString *message = self.messageLabel.text;
    if(message.length == 0) {
        indicatorY = (height - indicatorHeight)/2;
        
    } else {
        CGFloat messageX = 10;
        CGFloat messageWidth = width - messageX * 2;
        
        UIFont *messageFont = self.messageLabel.font;
        CGSize textSize = [CJOverlayTextSizeUtil sizeOfText:message WithMaxSize:CGSizeMake(messageWidth, MAXFLOAT) font:messageFont];
        CGFloat messageHeight = textSize.height;
        
        // indicatorY + (indicatorHeight + 10 + messageHeight)/2 = height/2; //原始算式
        indicatorY = height/2 - (indicatorHeight + 10 + messageHeight)/2; // 得到的算法
        CGFloat messageY = indicatorY + indicatorHeight + 10; // message与indicator间距10
        
        
        self.messageLabel.frame = CGRectMake(messageX, messageY, messageWidth, messageHeight);
        //self.messageLabel.backgroundColor = [UIColor redColor];
    }

    CGRect indicatorFrame = CGRectMake(indicatorX, indicatorY, indicatorWidth, indicatorHeight);
    self.activityIndicatorView.frame = indicatorFrame;
    self.imageView.frame = indicatorFrame;
}

#pragma mark - Event
- (void)reloadWithLoadingAndMessage:(NSString *)message {
    self.messageLabel.text = message;
    
    self.activityIndicatorView.hidden = NO;
    self.imageView.hidden = YES;
    
    [self reloadHudView];
}


- (void)reloadWithMessage:(NSString *)message image:(UIImage *)image {
    self.messageLabel.text = message;
    
    self.activityIndicatorView.hidden = YES;
    self.imageView.hidden = NO;
    self.imageView.image = image;
    
    [self reloadHudView];
}

#pragma mark - Setter
- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    if (hidden) {
        [self.activityIndicatorView stopAnimating];
    } else {
        [self.activityIndicatorView startAnimating];
    }
    
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    self.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 20.0;
    
    [self addSubview:self.activityIndicatorView];
    [self addSubview:self.imageView];
    [self addSubview:self.messageLabel];
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_activityIndicatorView startAnimating];
        _activityIndicatorView.color = [UIColor whiteColor];
    }
    return _activityIndicatorView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont boldSystemFontOfSize:14];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

@end
