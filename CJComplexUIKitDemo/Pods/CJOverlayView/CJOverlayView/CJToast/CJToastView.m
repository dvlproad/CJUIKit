//
//  CJToastView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJToastView.h"
#import <Masonry/Masonry.h>
#import "CJOverlayTextSizeUtil.h"

@interface CJToastView () {
    
}
@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation CJToastView

- (instancetype)initWithMessage:(NSString *)message {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupViews];
        
        self.titleLabel.text = message;
    }
    return self;
}

#pragma mark - SetupViews
- (void)setupViews {
    self.backgroundColor = [UIColor colorWithRed:12/255.0 green:16/255.0 blue:27/255.0 alpha:0.8];  //0C101B, 80%
    self.layer.cornerRadius = 23;
    self.layer.masksToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.height.greaterThanOrEqualTo(@46);
    }];
    self.titleLabel = titleLabel;
}


#pragma mark - Private
/// 计算 toastView 的大小
+ (CGSize)sizeWithMessage:(NSString *)message
          messageMaxWidth:(CGFloat)messageMaxWidth
{
    UIFont *hudLabelFont = [UIFont systemFontOfSize:16];
    CGSize maxSize = CGSizeMake(messageMaxWidth, CGFLOAT_MAX);
    CGSize textSize = [CJOverlayTextSizeUtil getTextSizeFromString:message withFont:hudLabelFont maxSize:maxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:nil];
    
    CGFloat width = textSize.width + 2*10;
    width = MAX(width, 180);
    
    CGFloat height = textSize.height + 2*10;
    height = MAX(height, 46);
    
    return CGSizeMake(width, height);
}

@end
