//
//  CJMultiColumnPhotoTableViewCell.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJMultiColumnPhotoTableViewCell.h"

@implementation CJMultiColumnPhotoTableViewCell

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit]; //cell页面布局
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat gridCellWidth = (CGRectGetWidth(self.frame) - 25) / 4;
    
    __weak typeof(self)weakSelf = self;
    for (int i = 0; i < 4; i++) {
        CJPhotoGridCell *photoGridCell = [[CJPhotoGridCell alloc] initWithFrame:CGRectZero];
        photoGridCell.tag = 1000+i; //设置tag(tag值不要从0开始，防止取tag为0的view时，取到的是自身)
        __weak typeof(photoGridCell)weakPhotoGridCell = photoGridCell;
        photoGridCell.imageButtonTapBlock = ^ (void) {
            [weakSelf imageButtonTap:weakPhotoGridCell];
        };
        photoGridCell.checkButtonTapBlock = ^ (void) {
            [weakSelf checkButtonTap:weakPhotoGridCell];
        };
        [self.contentView addSubview:photoGridCell];
        [photoGridCell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(5 * (i+1) + gridCellWidth * i);
            make.width.height.mas_equalTo(gridCellWidth);
        }];
    }
}

- (void)imageButtonTap:(CJPhotoGridCell *)photoGridCell {
    if (self.gridCellImageButtonTapBlock) {
        self.gridCellImageButtonTapBlock(photoGridCell);
    }
}

- (void)checkButtonTap:(CJPhotoGridCell *)photoGridCell {
    if (self.gridCellCheckButtonTapBlock) {
        self.gridCellCheckButtonTapBlock(photoGridCell);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
