//
//  CQHorizontalAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQHorizontalAlertView.h"
#import <Masonry/Masonry.h>

@interface CQHorizontalAlertView () {
    
}
@property (nullable, nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *operateButton;
@property (nonatomic, copy, readonly) void(^operateEventBlock)(void);

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, copy, readonly) void(^closeHandle)(void);

@end


@implementation CQHorizontalAlertView


- (instancetype)initWithImage:(nullable UIImage *)image
                        title:(NSString *)title
             operateEventText:(NSString *)operateEventText
            operateEventBlock:(void(^)(void))operateEventBlock
                   closeImage:(UIImage *)closeImage
                  closeHandle:(void(^)(void))closeHandle
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self updateWithImage:image title:title operateEventText:operateEventText operateEventBlock:operateEventBlock closeImage:closeImage closeHandle:closeHandle];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupViews];
    }
    return self;
}

/// topAlert有时候会公用（比如选择不同类型表信息/里信息，顶部alert更新对应数据）
- (void)updateWithImage:(nullable UIImage *)image
                  title:(NSString *)title
       operateEventText:(NSString *)operateEventText
      operateEventBlock:(void(^)(void))operateEventBlock
             closeImage:(UIImage *)closeImage
            closeHandle:(void(^)(void))closeHandle
{
    self.imageView.image = image;
    if (image) {
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(16);
            make.width.mas_equalTo(30);
        }];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).mas_offset(4);
        }];
    } else {
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(0);
            make.width.mas_equalTo(0);
        }];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(16);
        }];
    }
    
    self.titleLabel.text = title;
    
    [self.operateButton setTitle:operateEventText forState:UIControlStateNormal];
    _operateEventBlock = operateEventBlock;
    
    [self.closeButton setImage:closeImage forState:UIControlStateNormal];
    _closeHandle = closeHandle;
}

- (void)setupViews {
    self.backgroundColor = [UIColor colorWithRed:12/255.0 green:16/255.0 blue:27/255.0 alpha:1.0];  //0C101B
    self.layer.masksToBounds = YES;
    
    // 右侧的 closeButton 和 operateButton
    UIButton *closeButton = [UIButton new];
    [closeButton addTarget:self action:@selector(clickCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-4);
        make.width.height.mas_equalTo(42);
        make.centerY.mas_equalTo(self);
    }];
    self.closeButton = closeButton;
    
    UIButton *operateButton = [UIButton new];
    [operateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    operateButton.backgroundColor = [UIColor colorWithRed:59/255.0 green:70/255.0 blue:245/255.0 alpha:1.0];  //3B46F6
    operateButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    operateButton.layer.masksToBounds = YES;
    operateButton.layer.cornerRadius = 13;
    [operateButton addTarget:self action:@selector(clickOperateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:operateButton];
    [operateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(closeButton.mas_left);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(26);
    }];
    self.operateButton = operateButton;
    
    // 左侧的图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(16);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(30);
    }];
    self.imageView = imageView;
    
    // 剩余的文字
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(operateButton.mas_left).mas_offset(-4);
        make.left.mas_equalTo(imageView.mas_right).mas_offset(4);
    }];
    self.titleLabel = titleLabel;
}



- (void)clickOperateAction:(UIButton *)sender {
    !self.operateEventBlock ?: self.operateEventBlock();

}

- (void)clickCloseAction:(UIButton *)sender {
    !self.closeHandle ?: self.closeHandle();
}

@end
