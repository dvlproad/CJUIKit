//
//  CJScreenBottomTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJScreenBottomTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+CJHex.h"
#import "CJThemeManager.h"

@interface CJScreenBottomTableViewCell () {
    
}
@property (nonatomic, strong) UIView *bottomLineView;   /**< cell的底部横线 */

@end


@implementation CJScreenBottomTableViewCell

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

- (CGFloat)screenBottomHeight {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL isScreenFull = screenHeight >= 812 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;  // 是否是全面屏
    CGFloat screenBottomHeight = isScreenFull ?  34.0 : 0.0;    // 屏幕底部
    return screenBottomHeight;
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    // 主标题
    [self.contentView addSubview:self.mainTitleLabel];
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).mas_offset(-[self screenBottomHeight]/2);
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
        _subTitleLabel.textColor = CJColorFromHexString([CJThemeManager serviceThemeModel].textAssistColor);
    }
    return _subTitleLabel;
}

/// cell的底部横线
- (UIView *)bottomLineView {
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLineView.backgroundColor = CJColorFromHexString([CJThemeManager serviceThemeModel].separateLineColor);
    }
    return _bottomLineView;
}

@end
