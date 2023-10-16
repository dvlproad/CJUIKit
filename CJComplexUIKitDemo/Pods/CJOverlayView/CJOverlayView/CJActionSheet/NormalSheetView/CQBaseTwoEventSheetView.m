//
//  CQBaseTwoEventSheetView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQBaseTwoEventSheetView.h"
#import <Masonry/Masonry.h>
#import "CJBaseOverlayThemeManager.h"
#import "CJOverlayTextSizeUtil.h"

@interface CQBaseTwoEventSheetView () {
    
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy, readonly) void(^item2EventBlock)(void);
@property (nonatomic, copy, readonly) void(^item1EventBlock)(void);

@end

@implementation CQBaseTwoEventSheetView


#pragma mark - Init
/*
 *  初始化
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param item1EventText       操作事项1的文字（危险操作下常见的标题有：删除）
 *  @param item1EventBlock      操作事项1的点击回调
 *  @param item1EventIsDanger   操作事项1是否是危险操作（如果是，则文字颜色会变红）
 *  @param item2EventText       操作事项2的文字
 *  @param item2EventBlock      操作事项2的点击回调
 *
 *  @return  有两个操作事项的视图
 */
- (instancetype)initWithPromptTitle:(NSString *)promptTitle
                     item1EventText:(NSString *)item1EventText
                 item1EventIsDanger:(BOOL)item1EventIsDanger
                    item1EventBlock:(void(^)(void))item1EventBlock
                     item2EventText:(NSString *)item2EventText
                    item2EventBlock:(void(^)(void))item2EventBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _item2EventBlock = item2EventBlock;
        _item1EventBlock = item1EventBlock;
        
        [self setupViews];
        
        self.titleLabel.text = promptTitle;
        [self.deleteButton setTitle:item1EventText forState:UIControlStateNormal];
        [self.deleteButton.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:16]];
        [self.cancelButton setTitle:item2EventText forState:UIControlStateNormal];
        [self.cancelButton.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:16]];
        
        // 设置主题色
        CJOverlayCommonThemeModel *commonThemeModel = [CJBaseOverlayThemeManager serviceThemeModel].commonThemeModel;
        // 标题颜色
        self.titleLabel.textColor = commonThemeModel.text666Color;
        
        // 按钮颜色
        UIColor *safeTextColor = commonThemeModel.textMainColor;
        UIColor *dangerTextColor = commonThemeModel.textDangerColor;
        NSAssert(dangerTextColor != nil, @"危险颜色不能为空,请先设置");
        
        [self.cancelButton setTitleColor:safeTextColor forState:UIControlStateNormal];
        if (item1EventIsDanger) {
            [self.deleteButton setTitleColor:dangerTextColor forState:UIControlStateNormal];
        } else {
            [self.deleteButton setTitleColor:safeTextColor forState:UIControlStateNormal];
        }
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 30;
    self.layer.masksToBounds = YES;
    
    
    
    CGFloat screenBottomHeight = [self __screenBottomHeight];
    CGFloat buttonHeight = 62;
    
    // 取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-screenBottomHeight);
        make.height.equalTo(@(buttonHeight));
    }];
    self.cancelButton = cancelButton;
    
    // 删除按钮
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(cancelButton.mas_top).offset(0);
        make.height.equalTo(@(buttonHeight));
    }];
    self.deleteButton = deleteButton;
    
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    //titleLabel.text = @"删除前的确认视图标题";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(32);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.bottom.equalTo(deleteButton.mas_top).mas_equalTo(-20);
    }];
    self.titleLabel = titleLabel;
}


#pragma mark - Private Method
/// 获取在各个设备上的屏幕底部不可用的高度
- (CGFloat)__screenBottomHeight {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL isScreenFull = screenHeight >= 812 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;  // 是否是全面屏
    CGFloat screenBottomHeight = isScreenFull ?  34.0 : 0.0;    // 屏幕底部
    return screenBottomHeight;
}

- (void)clickCancel {
    NSAssert(self.commonClickAction != nil, @"请设置每次点击都会触发的事件");
    self.commonClickAction(self);   //[self cq_hidePopupView];
    
    !self.item2EventBlock ?: self.item2EventBlock();
}

- (void)clickDelete {
    NSAssert(self.commonClickAction != nil, @"请设置每次点击都会触发的事件");
    self.commonClickAction(self);   //[self cq_hidePopupView];
    
    !self.item1EventBlock ?: self.item1EventBlock();
}


#pragma mark - Get Method: ViewHeight
/// 获取视图的高度（已自适应promptTitle多行的情况）
- (CGFloat)viewHeightWithViewWidth:(CGFloat)viewWidth {
    NSString *promptTitle = self.titleLabel.text;
    CGFloat promptTitleMaxWidth = viewWidth - 2 * 32;
    UIFont *promptTitleFont = self.titleLabel.font;
    CGSize maxSize = CGSizeMake(promptTitleMaxWidth, CGFLOAT_MAX);
    CGSize textSize = [CJOverlayTextSizeUtil getTextSizeFromString:promptTitle withFont:promptTitleFont maxSize:maxSize lineBreakMode:NSLineBreakByCharWrapping paragraphStyle:nil];
    CGFloat titleLabelHeight = MAX(18, textSize.height) + 2;
    
    CGFloat screenBottomHeight = [self __screenBottomHeight];
    CGFloat buttonHeight = 62;
    CGFloat viewHeight = screenBottomHeight + 2 * buttonHeight + 20 + titleLabelHeight + 20;
    
    return viewHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
