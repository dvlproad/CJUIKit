//
//  TestTextFieldOffsetTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "TestTextFieldOffsetTableViewCell.h"
#import <CJFoundation/NSString+CJTextSize.h>
#import "DemoTextFieldFactory.h"

@interface TestTextFieldOffsetTableViewCell () {
    
}
@property (nonatomic, strong) UILabel *changeExplainLabel;
@property (nonatomic, strong) CJTextField *textField;
@property (nonatomic, strong) UILabel *extraResultLabel;

@end

@implementation TestTextFieldOffsetTableViewCell

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
    view.layer.borderColor = CJColorFromHexString(@"#f2f2f2").CGColor;
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
    
    UILabel *changeExplainLabel = [DemoLabelFactory testExplainLabel];
    [parentView addSubview:changeExplainLabel];
    [changeExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(0);
        make.right.mas_equalTo(parentView).mas_offset(-0);
        make.top.mas_equalTo(parentView).mas_offset(0);
        make.height.mas_equalTo(20);
    }];
    self.changeExplainLabel = changeExplainLabel;
    
    [parentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(changeExplainLabel);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(changeExplainLabel.mas_bottom);
        //make.height.mas_equalTo(44); //TOSURE:为什么这边加高度设置会有问题
    }];
    
    UILabel *extraResultLabel = [DemoLabelFactory testExplainLabel];
    [parentView addSubview:extraResultLabel];
    [extraResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(changeExplainLabel);
        make.right.mas_equalTo(changeExplainLabel);
        make.top.mas_equalTo(self.textField.mas_bottom);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(parentView).mas_offset(-0);//使得cell自适应
    }];
    self.extraResultLabel = extraResultLabel;
}

- (void)setValueChangeModel:(TestValueChangeModel *)valueChangeModel {
    _valueChangeModel = valueChangeModel;
    
    self.changeExplainLabel.text = valueChangeModel.changeExplain;
    
    NSString *text = valueChangeModel.valueString;
    self.textField.text = text;
    [self showExtraResult];
}

- (void)minusAction:(UIButton *)button {
    NSString *newText = [self.valueChangeModel didMinusAction];
    self.textField.text = newText;
    [self showExtraResult];
}

- (void)addAction:(UIButton *)button {
    NSString *newText = [self.valueChangeModel didAddAction];
    self.textField.text = newText;
    [self showExtraResult];
}

- (void)showExtraResult {
    CGFloat textHeight = 0;

    NSString *extraResultMessage = self.valueChangeModel.extarResultString;
    if (extraResultMessage.length > 0) {
        self.extraResultLabel.text = extraResultMessage;

        CGFloat maxWidth = CGRectGetWidth(self.frame) - 10 - 10;
        textHeight =  [extraResultMessage cjTextHeightWithFont:[UIFont systemFontOfSize:14] infiniteHeightAndMaxWidth:maxWidth];
    }

    [self.extraResultLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
}

#pragma mark - Lazy
- (CJTextField *)textField {
    if (_textField == nil) {
        CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.backgroundColor = CJColorFromHexString(@"#ffffff");
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.backgroundColor = [UIColor orangeColor];
        UIImage *leftNormalImage = [UIImage imageNamed:@"minus_common_icon"];
        [leftButton setImage:leftNormalImage forState:UIControlStateNormal];
        [leftButton setCjTouchUpInsideBlock:^(UIButton *button) {
            [self minusAction:button];
        }];
        [leftButton setFrame:CGRectMake(0, 0, 20, 20)];
        
        textField.leftView = leftButton;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftViewLeftOffset = 10;
        textField.leftViewRightOffset = 10;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.backgroundColor = [UIColor orangeColor];
        UIImage *rightNormalImage = [UIImage imageNamed:@"add_common_icon"];
        [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
        [rightButton setCjTouchUpInsideBlock:^(UIButton *button) {
            [self addAction:button];
        }];
        [rightButton setFrame:CGRectMake(0, 0, 20, 20)];
        
        textField.rightView = rightButton;
        textField.rightViewMode = UITextFieldViewModeAlways;
        textField.rightViewLeftOffset = 10;
        textField.rightViewRightOffset = 10;
        
        textField.backgroundColor = [UIColor greenColor];
        //textField.leftView.backgroundColor = [UIColor redColor];
        textField.leftView.alpha = 0.5;
        //textField.rightView.backgroundColor = [UIColor redColor];
        textField.rightView.alpha = 0.5;
        
        _textField = textField;
    }
    return _textField;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
