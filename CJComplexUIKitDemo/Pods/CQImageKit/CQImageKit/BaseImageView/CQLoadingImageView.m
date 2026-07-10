//
//  CQLoadingImageView.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQLoadingImageView.h"
#import <Masonry/Masonry.h>
#import "UIImageView+CQUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CQLoadingImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        
        self.hudView.hidden = YES;
    }
    return self;
}

- (void)setupViews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.imageView = imageView;
    
    
    CJIndicatorProgressHUDView *hudView = [[CJIndicatorProgressHUDView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    hudView.layer.masksToBounds = YES;
    hudView.layer.cornerRadius = 0.0;
    [self addSubview:hudView];
    [hudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(imageView);
    }];
    self.hudView = hudView;
}

- (void)setImageWithUrl:(NSString *)imageUrl {
    NSURL *mImageURL = [NSURL URLWithString:imageUrl];
    UIImage *placeholderImage = [UIImage imageNamed:@"img_error_default"];
    
    self.hudView.hidden = NO;
    
    __weak typeof(self)weakSelf = self;
    [self.imageView sd_setImageWithURL:mImageURL placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        /* 正常逻辑
        weakSelf.hudView.hidden = YES;
        
        if (error) {
            weakSelf.imageView.image = [UIImage imageNamed:@"img_error_default"];
            return;
        }
        */
        
        // 本产品逻辑，成功才关闭hud，失败了仍然显示hud，而不给张失败的图片
        if (error) {
            weakSelf.hudView.hidden = NO;
            return;
        }
        weakSelf.hudView.hidden = YES;
    }];
}

- (void)setImageWithUrl:(NSString *)imageUrl imageStatus:(CQImageStatus)imageStatus {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
