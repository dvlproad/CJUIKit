//
//  WelcomeView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/7/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "WelcomeView.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImage+GIF.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerLayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVFAudio.h>

@interface WelcomeView () {
    AVPlayerItem *playerItem;
    AVPlayer *player;
}
@property (nonatomic, strong) UILabel *welcomTextLabel;
@property (nonatomic, strong) UILabel *copyrightLabel;
@property (nonatomic, strong) UIButton *skipButton;             /**< 跳过按钮 */

@property (nonatomic, strong) UIImageView *welcomeImageView;    /**< 欢迎页的图片 */
@property (nonatomic, strong) AVPlayerLayer *playerLayer;       /**< 欢迎页视频图层 */

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeSecond;     /**< 倒计时时间 */
@property (nonatomic, copy) void(^showCompleteBlock)(void);     /**< 欢迎页显示完毕的回调 */

@end


@implementation WelcomeView

- (void)dealloc {
    if (playerItem) {
        @try {
            [playerItem removeObserver:self forKeyPath:@"status"];
        } @catch (NSException *exception) {
            NSLog(@"\n-----------------exception---------------------\n%s\n%@\n----------------------------------------------------\n", __func__, exception);
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  初始化
 *
 *  @param imageURL             图片地址
 *  @param imageType            图片类型(静图png/jpg、动图gif)
 *  @param movieURL             视频地址
 *  @param isImageFirst         是否图片优先
 *
 *  @return 欢迎页
 */
- (instancetype)initWithImageURL:(NSURL *)imageURL
                       imageType:(WelcomeImageType)imageType
                        movieURL:(NSURL *)movieURL
                    isImageFirst:(BOOL)isImageFirst
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        
        // 使用上次数据来显示，防止本次加载太久造成的卡顿
        NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"welcomeImageDataKey"];
        WelcomeImageType imageType = (WelcomeImageType)[[[NSUserDefaults standardUserDefaults] objectForKey:@"welcomeImageTypeKey"] integerValue];
        UIImage *image = nil;
        if (imageType == WelcomeImageTypeGif) {
            image = [UIImage sd_imageWithGIFData:imageData];
        } else {
            image = [UIImage imageWithData:imageData];
        }
        [self setupViewsWithImage:image movieURL:movieURL isImageFirst:isImageFirst];
        
        
        // 保持本次信息，用于下次使用
        [[NSUserDefaults standardUserDefaults] setObject:@(imageType) forKey:@"welcomeImageTypeKey"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"welcomeImageDataKey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        });
    }
    return self;
}


#pragma mark - Event
/**
 *  显示欢迎页
 *
 *  @param duration             欢迎页展示的期望时长
 *  @param showCompleteBlock    欢迎页展示完毕的回调
 */
- (void)showWithDuration:(NSInteger)duration
       showCompleteBlock:(void(^)(void))showCompleteBlock
{
    AppDelegate *delegate = ((AppDelegate*)[UIApplication sharedApplication].delegate);
    [delegate.window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(delegate.window);
    }];
    
    
    _timeSecond = duration;
    if (_timeSecond < 1) {
        _timeSecond = 3;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownTime) userInfo:nil repeats:YES];
    [self.timer fire];
    
    _showCompleteBlock = showCompleteBlock;
}


- (void)countdownTime {
    NSString *title = [NSString stringWithFormat:@"跳过\n%lds", (long)_timeSecond];
    [self.skipButton setTitle:title forState:UIControlStateNormal];
    _timeSecond --;
    if (_timeSecond < 0) {
        [self endAd];
    }
}

- (void)endAd {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    !self.showCompleteBlock ?: self.showCompleteBlock();
    [self removeFromSuperview];
}


- (void)observeValueForKeyPath:(NSString *)path ofObject:(id)object change:(NSDictionary *)change  context:(void *)context {
    if (context == @"AVPlayerStatus") {
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
                case AVPlayerStatusReadyToPlay: {
                    [player play];
                    player.rate = 1.5f;
                }
                break;
            default: {
//                [self endAd];
            }
        }
    }
}

- (void)itemDidFinishPlaying:(NSNotification*)noti{
    NSLog(@"欢迎页视频播放结束");
//    [self endAd];
}

#pragma mark - SetupView & Lazy
/**
 *  为图片欢迎页添加视图
 *
 *  @param image                图片
 *  @param movieURL             视频地址
 *  @param isImageFirst         是否图片优先
 */
- (void)setupViewsWithImage:(UIImage *)image
                   movieURL:(NSURL *)movieURL
               isImageFirst:(BOOL)isImageFirst
{
    if (image) {
        NSLog(@"有欢迎页图片，则播放欢迎页图片");
        [self addSubview:self.welcomeImageView];
        [self.welcomeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        self.welcomeImageView.image = image;
    } else {
        NSLog(@"没有欢迎页图片，则播放欢迎页视频");
        playerItem = [AVPlayerItem playerItemWithURL:movieURL];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew  context:@"AVPlayerStatus"];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error: nil];
        player = [AVPlayer playerWithPlayerItem:playerItem];
        
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        self.playerLayer.frame = self.frame;
        [self.layer addSublayer:self.playerLayer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        
        [self addSubview:self.copyrightLabel];
        [self.copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).mas_offset(-40);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self).mas_offset(0);
            make.centerX.mas_equalTo(self);
        }];
        self.copyrightLabel.text = self.copyright;
    }
    
    [self setupCommonViews];
}

- (void)setupCommonViews {
    if (self.welcomeText) {
        [self addSubview:self.welcomTextLabel];
        [self.welcomTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(100);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(30);
        }];
        
        self.welcomTextLabel.text = self.welcomeText;
        self.welcomTextLabel.textColor = self.welcomeTextColor;
    }
    
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarHeight = CGRectGetHeight(statusBarFrame);
    [self addSubview:self.skipButton];
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(statusBarHeight);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}

- (UIImageView *)welcomeImageView {
    if (!_welcomeImageView) {
        _welcomeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _welcomeImageView.backgroundColor = [UIColor clearColor];
    }
    return _welcomeImageView;
}

- (UILabel *)copyrightLabel {
    if (!_copyrightLabel) {
        _copyrightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _copyrightLabel.backgroundColor = [UIColor clearColor];
        _copyrightLabel.textAlignment = NSTextAlignmentCenter;
        _copyrightLabel.textColor = [UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f];
        _copyrightLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    }
    return _copyrightLabel;
}

- (UILabel *)welcomTextLabel {
    if (!_welcomTextLabel) {
        _welcomTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _welcomTextLabel.textAlignment = NSTextAlignmentCenter;
        _welcomTextLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:15];
    }
    return _welcomTextLabel;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.numberOfLines = 2;
        _skipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _skipButton.layer.masksToBounds = YES;
        _skipButton.layer.cornerRadius = 20;
        [_skipButton addTarget:self action:@selector(endAd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}


@end
