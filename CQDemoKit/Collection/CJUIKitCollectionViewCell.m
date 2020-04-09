//
//  CJUIKitCollectionViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJUIKitCollectionViewCell.h"

@implementation CJUIKitCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.layer.masksToBounds = YES;
    
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0].CGColor; // #f2f2f2
    
    UIView *parentView = self.contentView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [parentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(30);
        make.centerX.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(10);
        make.height.mas_equalTo(imageView.mas_width);
    }];
    self.imageView = imageView;
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:17];
    textLabel.minimumScaleFactor = 0.4;
    textLabel.textColor = [UIColor blackColor];
    [parentView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(10);
        make.right.mas_equalTo(parentView).mas_offset(-10);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
    self.textLabel = textLabel;
    
    
    
}

@end
