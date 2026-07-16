//
//  CQTSTestMethodLongTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSTestMethodLongTableViewCell.h"
#import <Masonry/Masonry.h>
#import "CQTSTestMethodMiddleButton.h"
#import "CQTSTestMethodLeftButton.h"

@interface CQTSTestMethodLongTableViewCell () {
    
}
@property (nonatomic, strong) CQTSTestMethodLeftButton *leftVerticalButton;
@property (nonatomic, strong) CQTSTestMethodMiddleButton *middleValidateButton;

@property (nonatomic, strong) UIView *accentLine;
@property (nonatomic, strong) UIView *inputBgView;
@property (nonatomic, strong) UIView *resultBgView;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation CQTSTestMethodLongTableViewCell

+ (NSArray *)accentColors {
    static NSArray *colors;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = @[
            [UIColor colorWithRed:0.20 green:0.60 blue:0.86 alpha:1.0],  // 蓝
            [UIColor colorWithRed:0.18 green:0.72 blue:0.45 alpha:1.0],  // 绿
            [UIColor colorWithRed:0.90 green:0.45 blue:0.25 alpha:1.0],  // 橙
            [UIColor colorWithRed:0.60 green:0.40 blue:0.80 alpha:1.0],  // 紫
            [UIColor colorWithRed:0.90 green:0.30 blue:0.30 alpha:1.0],  // 红
            [UIColor colorWithRed:0.20 green:0.70 blue:0.70 alpha:1.0],  // 青
        ];
    });
    return colors;
}

- (void)dealloc {
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupViews];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Config
/*
 *  设置执行按钮的title
 *
 *  @param buttonTitle      按钮的title
 *  @param buttonPosition   按钮位置(中间：适合按钮文字长，左侧：适合按钮文字短），设置后自动更新布局
 */
- (void)configButtonTitle:(NSString *)buttonTitle buttonPosition:(CJValidateButtonPosition)buttonPosition {
    [self.middleValidateButton configTitle:buttonTitle];
    [self.leftVerticalButton configTitle:buttonTitle];
    
    if (buttonPosition == CJValidateButtonPositionLeft) {
        self.leftVerticalButton.hidden = NO;
        [self.leftVerticalButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(34);
        }];
        self.middleValidateButton.hidden = YES;
        [self.middleValidateButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
    } else { // 中
        self.leftVerticalButton.hidden = YES;
        [self.leftVerticalButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        self.middleValidateButton.hidden = NO;
        [self.middleValidateButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
    }
}

#pragma mark - Setter
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    NSArray *colors = [[self class] accentColors];
    self.accentLine.backgroundColor = colors[indexPath.section % colors.count];
}

- (void)setFixTextViewHeight:(CGFloat)fixTextViewHeight {
    _fixTextViewHeight = fixTextViewHeight;
    
    if (fixTextViewHeight > 44) {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(fixTextViewHeight));
        }];
    }
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UIView *parentView = self.contentView;
    // --- 左侧彩色竖线 ---
    UIView *accentLine = [UIView new];
    accentLine.layer.cornerRadius = 1.5;
    accentLine.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.9 alpha:1.0];
    [parentView addSubview:accentLine];
    [accentLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(6);
        make.top.mas_equalTo(parentView).mas_offset(14);
        make.bottom.mas_equalTo(parentView).mas_offset(-14);
        make.width.mas_equalTo(3);
    }];
    self.accentLine = accentLine;
    
    // --- 右侧卡片容器 ---
    UIView *cardContainer = [self _setupMethodCardContainer];
    [parentView addSubview:cardContainer];
    [cardContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(10);
        make.right.mas_equalTo(parentView).mas_equalTo(-10);
        make.top.mas_equalTo(parentView).mas_offset(5);
        make.bottom.mas_equalTo(parentView).mas_offset(-5);
    }];
    
    // 默认中间布局
    //self.buttonPosition = CJValidateButtonPositionMiddle;
    //self.leftVerticalButton.verticalStyle = CJVerticalTextButtonStyleRotated;
}


- (UIView *)_setupMethodCardContainer {
    // --- 卡片容器 ---
    UIView *cardContainer = [UIView new];
    cardContainer.backgroundColor = [UIColor whiteColor];
    cardContainer.layer.cornerRadius = 8;
    cardContainer.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.15].CGColor;
    cardContainer.layer.shadowOffset = CGSizeMake(0, 3);
    cardContainer.layer.shadowOpacity = 1.0;
    cardContainer.layer.shadowRadius = 8;
    // --- 左侧竖排文字按钮 ---
    CQTSTestMethodLeftButton *leftVerticalButton = [CQTSTestMethodLeftButton buttonWithType:UIButtonTypeCustom];
    [leftVerticalButton addTarget:self action:@selector(verticalButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [cardContainer addSubview:leftVerticalButton];
    [leftVerticalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cardContainer).mas_offset(2);
        make.width.mas_equalTo(34);
        make.top.mas_equalTo(cardContainer).mas_offset(10);
        make.bottom.mas_equalTo(cardContainer).mas_offset(-10);
    }];
    self.leftVerticalButton = leftVerticalButton;
    
    UIView *inputOutputContainer = [self __setupMethodInputOutputContainer];
    [cardContainer addSubview:inputOutputContainer];
    [inputOutputContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftVerticalButton.mas_right).mas_offset(0);
        make.right.mas_equalTo(cardContainer).mas_offset(-2);
        make.top.mas_equalTo(cardContainer).mas_offset(2);
        make.bottom.mas_equalTo(cardContainer).mas_offset(-2);
    }];
    //inputOutputContainer.backgroundColor = UIColor.redColor;
    
    return cardContainer;
}

- (UIView *)__setupMethodInputOutputContainer {
    __weak typeof(self)weakSelf = self;
    
    // --- 卡片中的输入输出容器 ---
    UIView *parentView = [UIView new];

    // --- 输入区域 ---
    UIView *inputBg = [UIView new];
    inputBg.layer.cornerRadius = 6;
    inputBg.layer.borderWidth = 1.0;
    inputBg.layer.borderColor = [UIColor colorWithWhite:0.88 alpha:1.0].CGColor;
    inputBg.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.98 alpha:1.0];
    [parentView addSubview:inputBg];
    [inputBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(parentView).mas_offset(0);
        make.left.mas_equalTo(parentView).mas_offset(0);
        make.right.mas_equalTo(parentView).mas_offset(-0);
    }];
    self.inputBgView = inputBg;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    [inputBg addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inputBg).mas_offset(8);
        make.left.mas_equalTo(inputBg).mas_offset(10);
        make.right.mas_equalTo(inputBg).mas_offset(-10);
        make.bottom.mas_equalTo(inputBg).mas_offset(-8);
        make.height.mas_equalTo(44);
    }];
    self.textView = textView;

    // --- 操作按钮 ---
    // --- 中间区域（虚线箭头贯穿，按钮盖在上面） ---
    CQTSTestMethodMiddleButton *middleValidateButton = [[CQTSTestMethodMiddleButton alloc] initWithTapAction:^{
        [weakSelf verticalButtonAction];
    }];
    [parentView addSubview:middleValidateButton];
    [middleValidateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inputBg.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(inputBg.mas_left).mas_offset(4);
        make.centerX.mas_equalTo(inputBg).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    self.middleValidateButton = middleValidateButton;

    // --- 结果区域 ---
    UIView *resultBg = [UIView new];
    resultBg.layer.cornerRadius = 6;
    resultBg.layer.borderWidth = 1.5;
    resultBg.layer.borderColor = [UIColor colorWithWhite:0.88 alpha:1.0].CGColor;
    resultBg.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.98 alpha:1.0];
    [parentView addSubview:resultBg];
    [resultBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(inputBg.mas_left).mas_offset(0);
        make.right.mas_equalTo(inputBg.mas_right).mas_offset(0);
        make.top.mas_equalTo(middleValidateButton.mas_bottom).mas_offset(0);
        make.bottom.mas_equalTo(parentView).mas_offset(-0);
    }];
    self.resultBgView = resultBg;

    // 状态标签（右上角小标签）
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    statusLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    statusLabel.textAlignment = NSTextAlignmentLeft;
    statusLabel.text = @"";
    [resultBg addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(resultBg).mas_offset(8);
        make.left.mas_equalTo(resultBg).mas_offset(12);
        make.right.mas_lessThanOrEqualTo(resultBg).mas_offset(-12);
    }];
    self.statusLabel = statusLabel;

    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    resultLabel.numberOfLines = 0;
    resultLabel.backgroundColor = [UIColor clearColor];
    resultLabel.textColor = [UIColor darkGrayColor];
    resultLabel.textAlignment = NSTextAlignmentLeft;
    resultLabel.font = [UIFont systemFontOfSize:15];
    [resultBg addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(statusLabel.mas_bottom).mas_offset(4);
        make.left.mas_equalTo(resultBg).mas_offset(12);
        make.right.mas_equalTo(resultBg).mas_offset(-12);
        make.bottom.mas_equalTo(resultBg).mas_offset(-10);
        make.height.mas_greaterThanOrEqualTo(24);   // 限制最小高度，避免空字符串的时候不显示
    }];
    self.resultLabel = resultLabel;
    
    return parentView;
}

- (void)verticalButtonAction {
    [self validateWithTriggerType:CJValidateTriggerTypeValidateButtonClick];
}
/**
 *  cell执行既定操作
 *
 *  @param triggerType   触发验证的来源
 */
- (void)validateWithTriggerType:(CJValidateTriggerType)triggerType {
    CQTSMethodValidateResult result = CQTSMethodValidateResultMatch;
    if (self.validateHandle) {
        result = self.validateHandle(self, triggerType);
    }

    if (result == CQTSMethodValidateResultModified) {
        self.statusLabel.text = @"ℹ 原始值已变更，请自行验证下面结果是否正确";
        self.statusLabel.textColor = [UIColor colorWithRed:0.25 green:0.35 blue:0.70 alpha:1.0];
        self.resultBgView.backgroundColor = [UIColor colorWithRed:0.93 green:0.95 blue:1.0 alpha:1.0];
        self.resultBgView.layer.borderColor = [UIColor colorWithRed:0.55 green:0.65 blue:0.90 alpha:1.0].CGColor;
        self.resultLabel.textColor = [UIColor colorWithRed:0.25 green:0.35 blue:0.70 alpha:1.0];
    } else if (result == CQTSMethodValidateResultMatch) {
        self.statusLabel.text = @"✓ 正确";
        self.statusLabel.textColor = [UIColor colorWithRed:0.15 green:0.50 blue:0.20 alpha:1.0];
        self.resultBgView.backgroundColor = [UIColor colorWithRed:0.88 green:0.97 blue:0.90 alpha:1.0];
        self.resultBgView.layer.borderColor = [UIColor colorWithRed:0.30 green:0.75 blue:0.40 alpha:1.0].CGColor;
        self.resultLabel.textColor = [UIColor colorWithRed:0.15 green:0.50 blue:0.20 alpha:1.0];
    } else if (result == CQTSMethodValidateResultNoHopeResultText) {
        self.statusLabel.text = @"⚠ 未设置期望结果，请自行验证下面结果是否正确";
        self.statusLabel.textColor = [UIColor colorWithRed:0.70 green:0.50 blue:0.10 alpha:1.0];
        self.resultBgView.backgroundColor = [UIColor colorWithRed:1.0 green:0.96 blue:0.86 alpha:1.0];
        self.resultBgView.layer.borderColor = [UIColor colorWithRed:0.90 green:0.75 blue:0.30 alpha:1.0].CGColor;
        self.resultLabel.textColor = [UIColor colorWithRed:0.70 green:0.50 blue:0.10 alpha:1.0];
    } else {
        self.statusLabel.text = @"✗ 错误";
        self.statusLabel.textColor = [UIColor colorWithRed:0.80 green:0.15 blue:0.15 alpha:1.0];
        self.resultBgView.backgroundColor = [UIColor colorWithRed:1.0 green:0.90 blue:0.90 alpha:1.0];
        self.resultBgView.layer.borderColor = [UIColor colorWithRed:0.90 green:0.25 blue:0.25 alpha:1.0].CGColor;
        self.resultLabel.textColor = [UIColor colorWithRed:0.80 green:0.15 blue:0.15 alpha:1.0];
    }
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    // 统一走 validateEvent 处理颜色和 statusLabel
    [self validateWithTriggerType:CJValidateTriggerTypeTextChanged];

    !self.textDidChangeBlock ?: self.textDidChangeBlock(textView.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
