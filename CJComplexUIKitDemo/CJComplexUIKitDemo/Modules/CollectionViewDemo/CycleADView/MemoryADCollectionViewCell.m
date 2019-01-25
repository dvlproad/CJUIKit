//
//  MemoryADCollectionViewCell.m
//  MemoryTrainingDemo
//
//  Created by ciyouzen on 2018/5/28.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "MemoryADCollectionViewCell.h"

@implementation MemoryADCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        
    }
    return self;
}

- (void)setupViews {
    UIView *parentView = self.contentView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [parentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(parentView);
    }];
    self.imageView = imageView;
}

@end
