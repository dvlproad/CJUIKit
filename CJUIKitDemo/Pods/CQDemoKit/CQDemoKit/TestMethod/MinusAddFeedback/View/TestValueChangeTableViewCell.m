//
//  TestValueChangeTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "TestValueChangeTableViewCell.h"
#import "CQTSMinusAddView.h"
#import <Masonry/Masonry.h>

@interface TestValueChangeTableViewCell () {
    
}
@property (nonatomic, strong) UILabel *changeExplainLabel;
@property (nonatomic, strong) CQTSMinusAddView *minusAddView;
@property (nonatomic, strong) UILabel *extraResultLabel;

@end

@implementation TestValueChangeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.layer.cornerRadius = 3;
    view.layer.borderColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0].CGColor; // @"#f2f2f2"
    view.layer.borderWidth = 2;
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    
    UIView *parentView = view;
    
    UILabel *changeExplainLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    changeExplainLabel.backgroundColor = [UIColor cyanColor];
    changeExplainLabel.textAlignment = NSTextAlignmentLeft;
    changeExplainLabel.font = [UIFont systemFontOfSize:14];
    changeExplainLabel.numberOfLines = 0;
    [parentView addSubview:changeExplainLabel];
    [changeExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(0);
        make.right.mas_equalTo(parentView).mas_offset(-0);
        make.top.mas_equalTo(parentView).mas_offset(0);
        make.height.mas_equalTo(20);
    }];
    self.changeExplainLabel = changeExplainLabel;
    
    __weak typeof(self)weakSelf = self;
    CQTSMinusAddView *minusAddView = [[CQTSMinusAddView alloc] initWithMinusHandle:^(UIButton *button) {
        [weakSelf minusAction:button];
    } addHandle:^(UIButton *button) {
        [weakSelf addAction:button];
    }];
    [parentView addSubview:minusAddView];
    [minusAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(changeExplainLabel);
        make.right.mas_equalTo(changeExplainLabel);
        make.top.mas_equalTo(changeExplainLabel.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    self.minusAddView = minusAddView;
    
    UILabel *extraResultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    extraResultLabel.backgroundColor = [UIColor cyanColor];
    extraResultLabel.textAlignment = NSTextAlignmentLeft;
    extraResultLabel.font = [UIFont systemFontOfSize:14];
    extraResultLabel.numberOfLines = 0;
    [parentView addSubview:extraResultLabel];
    [extraResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(minusAddView);
        make.right.mas_equalTo(minusAddView);
        make.top.mas_equalTo(minusAddView.mas_bottom);
        make.bottom.mas_equalTo(parentView).mas_offset(-0);//使得cell自适应
    }];
    self.extraResultLabel = extraResultLabel;
}

#pragma mark - Setter
- (void)setValueChangeModel:(CQTSManualTestMethodModel *)valueChangeModel {
    _valueChangeModel = valueChangeModel;
    
    self.changeExplainLabel.text = valueChangeModel.changeExplain;
    
    NSString *text = valueChangeModel.valueString;
    self.minusAddView.text = text;
    [self showExtraResult];
}

#pragma mark - Action
- (void)minusAction:(UIButton *)button {
    NSString *newText = [self.valueChangeModel didMinusAction];
    self.minusAddView.text = newText;
    [self showExtraResult];
}

- (void)addAction:(UIButton *)button {
    NSString *newText = [self.valueChangeModel didAddAction];
    self.minusAddView.text = newText;
    [self showExtraResult];
}

- (void)showExtraResult {
    NSString *extraResultMessage = self.valueChangeModel.extarResultString;
    if (extraResultMessage == nil) {
        self.extraResultLabel.text = @"（方法返回 nil）";
    } else if (extraResultMessage.length == 0) {
        self.extraResultLabel.text = @"（方法返回空字符串）";
    } else {
        self.extraResultLabel.text = extraResultMessage;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
