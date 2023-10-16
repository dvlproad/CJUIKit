//
//  CJActionSheetCellContainer.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJActionSheetCellContainer.h"
#import <Masonry/Masonry.h>
#import "CJBaseOverlayThemeManager.h"

@interface CJActionSheetCellContainer () {
    
}
@property (nullable, nonatomic, strong) UIImageView *titleImageView;/**< 主标题前的图片视图 */
@property (nonatomic, strong) UIView *bottomLineView;   /**< cell的底部横线 */

@end


@implementation CJActionSheetCellContainer

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.showBottomLine = YES;  // 会执行set方法
    }
    return self;
}

#pragma mark - Setter
/// 设置是否显示cell的底部横线
- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    self.bottomLineView.hidden = !showBottomLine;
}

#pragma mark - Update
/*
 *  更新主标题前的图片
 *
 *  @param image 图片(图片为nil时候也会自动居中)
 */
- (void)updateTitleImage:(nullable UIImage *)image {
    if (image == nil) {
        [self __updateIconHeight:0 iconTitleSpacing:0];
    } else {
        CGFloat iconHeight = [CJBaseOverlayThemeManager sheetThemeModel].iconHeight;
        CGFloat iconTitleSpacing = [CJBaseOverlayThemeManager sheetThemeModel].iconTitleSpacing;
        [self __updateIconHeight:iconHeight iconTitleSpacing:iconTitleSpacing];
    }
}
/*
 *  更新主标题前的图片视图的大小和间距
 *
 *  @param iconHeight                   icon的宽和高(1:1)
 *  @param iconTitleSpacing             icon与右视图的间距
 */
- (void)__updateIconHeight:(CGFloat)iconHeight
          iconTitleSpacing:(CGFloat)iconTitleSpacing
{
    // 在本视图中居中排列：图片在左，文字在图片的右边
    // 主标题
    [self.mainTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self).offset((iconHeight+iconTitleSpacing)/2);
    }];
    
    // 主标题前的图片视图
    [self.titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(iconHeight);
        make.right.mas_equalTo(self.mainTitleLabel.mas_left).mas_offset(-iconTitleSpacing);
    }];
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    // 主标题
    [self addSubview:self.mainTitleLabel];
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self).offset(0);
    }];
    // 主标题前的图片视图
    CGFloat iconHeight = [CJBaseOverlayThemeManager sheetThemeModel].iconHeight;
    CGFloat iconTitleSpacing = [CJBaseOverlayThemeManager sheetThemeModel].iconTitleSpacing;
    [self addImageViewWithIconHeight:iconHeight iconTitleSpacing:iconTitleSpacing];
    
    // 副标题
    [self addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainTitleLabel.mas_right).offset(3);
    }];
    
    // cell的底部横线
    NSInteger cellBottomLineHeight = [CJBaseOverlayThemeManager sheetThemeModel].bottomLineHeight;
    [self addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(3);
        make.right.equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(cellBottomLineHeight);
    }];
    
#if CQConstraintTest_Overlay==1
    _titleImageView.backgroundColor = [UIColor redColor];
    _mainTitleLabel.backgroundColor = [UIColor greenColor];
    _subTitleLabel.backgroundColor = [UIColor blueColor];
    _bottomLineView.backgroundColor = [UIColor redColor];
#endif
}

/*
 *  在主标题前添加图片视图，并完成指定的布局
 *
 *  @param iconHeight                   icon的宽和高(1:1)
 *  @param iconTitleSpacing             icon与右视图的间距
 */
- (void)addImageViewWithIconHeight:(CGFloat)iconHeight
                  iconTitleSpacing:(CGFloat)iconTitleSpacing
{
    // 在本视图中居中排列：图片在左，文字在图片的右边
    // 主标题
    [self.mainTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self).offset((iconHeight+iconTitleSpacing)/2);
    }];
    
    // 主标题前的图片视图
    [self addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(iconHeight);
        make.right.mas_equalTo(self.mainTitleLabel.mas_left).mas_offset(-iconTitleSpacing);
    }];
}

- (UIImageView *)titleImageView {
    if (_titleImageView == nil) {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _titleImageView;
}


/// 主标题
- (UILabel *)mainTitleLabel {
    if (_mainTitleLabel == nil) {
        _mainTitleLabel = [[UILabel alloc] init];
        _mainTitleLabel.textAlignment = NSTextAlignmentCenter;
        _mainTitleLabel.font = [UIFont systemFontOfSize:14];
        _mainTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];  // (@"#333333");
        
        if ([CJBaseOverlayThemeManager sheetThemeModel].mainTitleLabelConfigBlock != nil) {
            [CJBaseOverlayThemeManager sheetThemeModel].mainTitleLabelConfigBlock(_mainTitleLabel, NO);
        }
    }
    return _mainTitleLabel;
}

/// 副标题
- (UILabel *)subTitleLabel {
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:10];
        _subTitleLabel.textColor = [UIColor colorWithRed:144/255.0f green:144/255.0f blue:144/255.0f alpha:1.0];  // (@"#999999");;
        
        if ([CJBaseOverlayThemeManager sheetThemeModel].subTitleLabelConfigBlock != nil) {
            [CJBaseOverlayThemeManager sheetThemeModel].subTitleLabelConfigBlock(_subTitleLabel);
        }
    }
    return _subTitleLabel;
}

/// cell的底部横线
- (UIView *)bottomLineView {
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0];  // (@"#E5E5E5");
        if ([CJBaseOverlayThemeManager sheetThemeModel].bottomLineColor != nil) {
            _bottomLineView.backgroundColor = [CJBaseOverlayThemeManager sheetThemeModel].bottomLineColor;
        }
    }
    return _bottomLineView;
}

@end
