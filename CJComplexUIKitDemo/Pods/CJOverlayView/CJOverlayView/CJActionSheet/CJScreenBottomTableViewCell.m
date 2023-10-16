//
//  CJScreenBottomTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJScreenBottomTableViewCell.h"
#import <Masonry/Masonry.h>
#import "CJActionSheetCellContainer.h"
#import "CJBaseOverlayThemeManager.h"

@interface CJScreenBottomTableViewCell () {
    
}
@property (nonatomic, strong) CJActionSheetCellContainer *cellContainer;

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
        
//        self.cell
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

- (CGFloat)screenBottomHeight {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL isScreenFull = screenHeight >= 812 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;  // 是否是全面屏
    CGFloat screenBottomHeight = isScreenFull ?  34.0 : 0.0;    // 屏幕底部
    return screenBottomHeight;
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

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    // 主标题
    [self.contentView addSubview:self.cellContainer];
    [self.cellContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-[self screenBottomHeight]);
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
        [_cellContainer updateTitleImage:nil];
    }
    return _cellContainer;
}

@end
