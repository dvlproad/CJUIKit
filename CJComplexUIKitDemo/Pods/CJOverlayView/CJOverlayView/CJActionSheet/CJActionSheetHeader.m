//
//  CJActionSheetHeader.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJActionSheetHeader.h"
#import <Masonry/Masonry.h>
#import "CJBaseOverlayThemeManager.h"
#import "CJOverlayTextSizeUtil.h"

@interface CJActionSheetHeader () {
    
}
@property (nonatomic, strong) UILabel *topTitleLabel;       /**< sheet顶部标题（有时候有，有时候没有） */

@end

@implementation CJActionSheetHeader

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Update
/*
 *  更新标题，返回所占的高度
 *
 *  @param title        标题(可以为nil,为nil时候,高度为0)
 *  @param viewWidth    本header视图所占的宽度(常用于直接测试view显示时候使用)
 *
 *  @return 指定标题下本视图所占的高度
 */
- (CGFloat)updateTitle:(nullable NSString *)title withViewWidth:(CGFloat)viewWidth {
    CGFloat topTitleLabelWidth = viewWidth - 2 *[self topTitleLeftMargin_ifExsitTitle];
    CGFloat titleLabelHeight = [self topTitleHeightForTitle:title withViewWidth:topTitleLabelWidth];
    CGFloat topTitleViewHeight = 0;
    if (titleLabelHeight > 0) {
        // 确定最小高度
        CGFloat topTitleMinHeight = [CJBaseOverlayThemeManager sheetThemeModel].topViewMinHeight_ifExsitTitle;
        NSAssert(topTitleMinHeight != 0, @"要显示title的时候，其高度的最小值不能为0");
        // 计算最后的准确高度
        CGFloat topMarign = [CJBaseOverlayThemeManager sheetThemeModel].topTitleBottomMargin_ifExsitTitle;
        [self.topTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(titleLabelHeight);
        }];
        topTitleViewHeight = MAX(topTitleMinHeight, topTitleMinHeight+2*topMarign);
        
    } else {
        [self.topTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        topTitleViewHeight = 0;
    }
    
    self.topTitleLabel.text = title;
    
    return topTitleViewHeight;
}

#pragma mark - Get Method: ViewHeight
/// 获取视图的高度（已自适应promptTitle多行的情况）
- (CGFloat)topTitleHeightForTitle:(nullable NSString *)promptTitle
                    withViewWidth:(CGFloat)viewWidth
{
    if (promptTitle.length == 0) {
        return 0;
    }
    
    CGFloat promptTitleMaxWidth = viewWidth - 2 * [self topTitleLeftMargin_ifExsitTitle];
    UIFont *promptTitleFont = self.topTitleLabel.font;
    CGSize maxSize = CGSizeMake(promptTitleMaxWidth, CGFLOAT_MAX);
    CGSize textSize = [CJOverlayTextSizeUtil getTextSizeFromString:promptTitle withFont:promptTitleFont maxSize:maxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:nil];
    CGFloat topTextHeight = MAX(18, textSize.height) + 2;
    return topTextHeight;
}


#pragma mark - Get Method
- (CGFloat)topTitleLeftMargin_ifExsitTitle {
    return [CJBaseOverlayThemeManager sheetThemeModel].topTitleLeftMargin_ifExsitTitle;
}


#pragma mark - SetupViews & Lazy
- (void)setupViews {
    [self addSubview:self.topTitleLabel];
    [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset([self topTitleLeftMargin_ifExsitTitle]);
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(0);
    }];
    
#if CQConstraintTest_Overlay==1
    UIColor *randomColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    self.backgroundColor = [randomColor colorWithAlphaComponent:0.3];
    self.topTitleLabel.backgroundColor = [randomColor colorWithAlphaComponent:0.31];
#endif
}

- (UILabel *)topTitleLabel {
    if (_topTitleLabel == nil) {
        _topTitleLabel = [[UILabel alloc] init];
        _topTitleLabel.backgroundColor = [UIColor clearColor];
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
        _topTitleLabel.textColor = [UIColor colorWithRed:182/255.0 green:183/255.0 blue:186/255.0 alpha:1]; // B6B7BA
        _topTitleLabel.font = [UIFont systemFontOfSize:14];
        if ([CJBaseOverlayThemeManager sheetThemeModel].topTitleLabelConfigBlock != nil) {
            [CJBaseOverlayThemeManager sheetThemeModel].topTitleLabelConfigBlock(_topTitleLabel);
        }
    }
    return _topTitleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
