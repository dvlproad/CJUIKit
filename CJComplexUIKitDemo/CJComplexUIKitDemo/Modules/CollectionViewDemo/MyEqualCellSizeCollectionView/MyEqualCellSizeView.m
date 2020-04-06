//
//  MyEqualCellSizeView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeView.h"
#import "CJFullBottomCollectionViewCell.h"

@interface MyEqualCellSizeView () <UICollectionViewDataSource>

@end


@implementation MyEqualCellSizeView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text = @"测试";
    [self addSubview:label];
    
    self.equalCellSizeCollectionView = [[CQFilesLookCollectionView alloc] init];
    self.equalCellSizeCollectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.equalCellSizeCollectionView];
    [self.equalCellSizeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(20);
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
}

- (void)setDataModels:(NSMutableArray<NSString *> *)dataModels {
    _dataModels = dataModels;
    self.equalCellSizeCollectionView.dataModels = dataModels;
    [self.equalCellSizeCollectionView reloadData];
}


@end
