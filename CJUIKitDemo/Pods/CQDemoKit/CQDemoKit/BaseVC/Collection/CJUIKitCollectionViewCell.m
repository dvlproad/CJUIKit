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
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0;
    self.selected = NO;
    
    UIView *parentView = self.contentView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [parentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(parentView);
    }];
    self.imageView = imageView;
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:17];
    textLabel.minimumScaleFactor = 0.4;
    textLabel.textColor = [UIColor blackColor];
    [parentView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(parentView);
    }];
    self.textLabel = textLabel;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    UIView *parentView = self.contentView;
    parentView.layer.masksToBounds = YES;
    UIColor *borderColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    if (selected) {
        parentView.layer.borderColor = [borderColor colorWithAlphaComponent:1.0].CGColor;
        parentView.layer.borderWidth = 2;
    } else {
        parentView.layer.borderColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0].CGColor; // #999999
        parentView.layer.borderWidth = 2;
    }
}


@end
