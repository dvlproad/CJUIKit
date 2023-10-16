//
//  CJActionSheetTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJActionSheetTableViewCell.h"
#import <Masonry/Masonry.h>
#import "CJActionSheetCellContainer.h"
#import "CJBaseOverlayThemeManager.h"

@interface CJActionSheetTableViewCell () {
    
}
@property (nonatomic, strong) CJActionSheetCellContainer *cellContainer;

@end


@implementation CJActionSheetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.showBottomLine = YES;  // 会执行set方法
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter
/// 设置是否显示cell的底部横线
- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    self.cellContainer.showBottomLine = showBottomLine;
}

- (void)setIsDangerCell:(BOOL)isDangerCell {
    if (isDangerCell == self.isDangerCell) { // 不用重新绘制
        return;
    }
    
    _isDangerCell = isDangerCell;
    if ([CJBaseOverlayThemeManager sheetThemeModel].dangerCellConfigBlock != nil) {
        [CJBaseOverlayThemeManager sheetThemeModel].dangerCellConfigBlock(self, isDangerCell);
    }
}

#pragma mark - Get Method
/// 主标题
- (UILabel *)mainTitleLabel {
    return self.cellContainer.mainTitleLabel;
}

/// 副标题
- (UILabel *)subTitleLabel {
    return self.cellContainer.subTitleLabel;
}

#pragma mark - Update
/*
 *  更新主标题前的图片
 *
 *  @param image 图片(图片为nil时候也会自动居中)
 */
- (void)updateTitleImage:(nullable UIImage *)image {
    [self.cellContainer updateTitleImage:image];
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    // 主标题
    [self.contentView addSubview:self.cellContainer];
    [self.cellContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-0);
    }];
    
#if CQConstraintTest_Overlay==1
    UIColor *randomColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    self.backgroundColor = [randomColor colorWithAlphaComponent:0.3];
    self.cellContainer.backgroundColor = [randomColor colorWithAlphaComponent:0.31];
#endif
}

- (CJActionSheetCellContainer *)cellContainer {
    if (_cellContainer == nil) {
        _cellContainer = [[CJActionSheetCellContainer alloc] initWithFrame:CGRectZero];
    }
    return _cellContainer;
}


@end
