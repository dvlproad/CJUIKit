//
//  CJActionSheetTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJActionSheetTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+CJHex.h"
#import "CJThemeManager.h"

@interface CJActionSheetTableViewCell () {
    
}
@property (nonatomic, strong) UIView *bottomLineView;   /**< cell的底部横线 */

@end


@implementation CJActionSheetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showBottomLine = YES;
        [self setupViews];
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
    self.bottomLineView.hidden = !showBottomLine;
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    // 主标题
    [self.contentView addSubview:self.mainTitleLabel];
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    
    // 副标题
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.mainTitleLabel.mas_right).offset(3);
    }];
    
    // cell的底部横线
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(3);
        make.right.equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.7);
    }];
}

/// 主标题
- (UILabel *)mainTitleLabel {
    if (_mainTitleLabel == nil) {
        _mainTitleLabel = [[UILabel alloc] init];
        _mainTitleLabel.textAlignment = NSTextAlignmentCenter;
        _mainTitleLabel.font = [UIFont systemFontOfSize:14];
        _mainTitleLabel.textColor = CJColorFromHexString([CJThemeManager serviceThemeModel].textMainColor);
    }
    return _mainTitleLabel;
}

/// 副标题
- (UILabel *)subTitleLabel {
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:10];
        _subTitleLabel.textColor = CJColorFromHexString(@"#999999");
    }
    return _subTitleLabel;
}

/// cell的底部横线
- (UIView *)bottomLineView {
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLineView.backgroundColor = CJColorFromHexString(@"#dddddd");
    }
    return _bottomLineView;
}

@end
