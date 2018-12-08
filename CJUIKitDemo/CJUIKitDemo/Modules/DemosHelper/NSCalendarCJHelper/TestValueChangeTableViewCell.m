//
//  TestValueChangeTableViewCell.m
//  CJUIKitDemo
//
//  Created by 李超前 on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "TestValueChangeTableViewCell.h"
#import <CJFoundation/NSString+CJTextSize.h>

@interface TestValueChangeTableViewCell () {
    
}
@property (nonatomic, strong) UILabel *changeExplainLabel;
@property (nonatomic, strong) CJChooseTextTextField *chooseTextTextField;
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
    
    CJChooseTextTextField *chooseTextTextField = [[CJChooseTextTextField alloc] initWithFrame:CGRectZero];
    //chooseTextTextField.delegate = self;
    chooseTextTextField.textAlignment = NSTextAlignmentCenter;
    chooseTextTextField.backgroundColor = CJColorFromHexString(@"#ffffff");
    UIView *pickerView = [UIView new];
    [chooseTextTextField setTextOnlyFromPickerView:pickerView];//设置textField的值只能来源于指定pickerView的选择
    [self completeTextField:chooseTextTextField leftButtonAction:@selector(minusAction:) rightButtonAction:@selector(addAction:)];
    [parentView addSubview:chooseTextTextField];
    [chooseTextTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(changeExplainLabel);
        make.right.mas_equalTo(changeExplainLabel);
        make.top.mas_equalTo(changeExplainLabel.mas_bottom);
        make.bottom.mas_equalTo(parentView).mas_offset(-0);
        make.height.mas_equalTo(44);
    }];
    self.chooseTextTextField = chooseTextTextField;
    
    UILabel *extraResultLabel = [DemoLabelFactory testExplainLabel];
    [parentView addSubview:extraResultLabel];
    [extraResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(chooseTextTextField);
        make.right.mas_equalTo(chooseTextTextField);
        make.top.mas_equalTo(chooseTextTextField.mas_bottom);
        make.height.mas_equalTo(0);
    }];
    self.extraResultLabel = extraResultLabel;
}

- (void)completeTextField:(CJTextField *)textField
         leftButtonAction:(SEL)leftButtonAction
        rightButtonAction:(SEL)rightButtonAction
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor orangeColor];
    UIImage *leftNormalImage = [UIImage imageNamed:@"minus_common_icon"];
    [leftButton setImage:leftNormalImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:leftButtonAction forControlEvents:UIControlEventTouchUpInside];
    [leftButton setFrame:CGRectMake(0, 0, 20, 20)];
    
    textField.leftView = leftButton;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftViewLeftOffset = 10;
    textField.leftViewRightOffset = 10;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor orangeColor];
    UIImage *rightNormalImage = [UIImage imageNamed:@"add_common_icon"];
    [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:rightButtonAction forControlEvents:UIControlEventTouchUpInside];
    [rightButton setFrame:CGRectMake(0, 0, 20, 20)];
    
    textField.rightView = rightButton;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightViewLeftOffset = 10;
    textField.rightViewRightOffset = 10;
}

- (void)setValueChangeModel:(TestValueChangeModel *)valueChangeModel {
    _valueChangeModel = valueChangeModel;
    
    self.changeExplainLabel.text = valueChangeModel.changeExplain;
    
    NSString *text = valueChangeModel.valueString;
    self.chooseTextTextField.text = text;
    [self showExtraResult];
}

- (void)minusAction:(UIButton *)button {
    NSString *newText = [self.valueChangeModel didMinusAction];
    self.chooseTextTextField.text = newText;
    [self showExtraResult];
}

- (void)addAction:(UIButton *)button {
    NSString *newText = [self.valueChangeModel didAddAction];
    self.chooseTextTextField.text = newText;
    [self showExtraResult];
}

- (void)showExtraResult {
    NSString *extraResultMessage = self.valueChangeModel.extarResultString;
    if (extraResultMessage.length > 0) {
        self.extraResultLabel.text = extraResultMessage;
        
        CGFloat maxWidth = CGRectGetWidth(self.frame) - 10 - 10;
        CGFloat textHeight =  [extraResultMessage cjTextHeightWithFont:[UIFont systemFontOfSize:14] infiniteHeightAndMaxWidth:maxWidth];
        [self.extraResultLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textHeight);
        }];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
