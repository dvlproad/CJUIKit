//
//  TestTextFieldOffsetTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "TestTextFieldOffsetTableViewCell.h"
#import <Masonry/Masonry.h>
#import <CQDemoKit/CQTSMinusAddView.h>
#import <CJBaseUIKit/UIImage+CJCreate.h>
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>

@interface TestTextFieldOffsetTableViewCell () {
    
}
//以下四个属性的设置的前提：是必须有 leftView 和 rightView 的存在。如果为了省去设置，可直接使用
@property (nonatomic, assign) CGFloat leftViewLeftOffset;   /**< 左视图距左边框的距离 */
@property (nonatomic, assign) CGFloat leftViewRightOffset;  /**< 左视图距文字的距离 */

@property (nonatomic, assign) CGFloat rightViewRightOffset; /**< 右视图距右边框的距离 */
@property (nonatomic, assign) CGFloat rightViewLeftOffset;  /**< 右视图距文字的距离 */

@property (nonatomic, strong) CQTSMinusAddView *leftViewLeftOffsetTextField;   /**< 左视图距左边框的距离 */
@property (nonatomic, strong) CQTSMinusAddView *leftViewRightOffsetTextField;  /**< 左视图距文字的距离 */
@property (nonatomic, strong) CQTSMinusAddView *rightViewRightOffsetTextField; /**< 右视图距右边框的距离 */
@property (nonatomic, strong) CQTSMinusAddView *rightViewLeftOffsetTextField;  /**< 右视图距文字的距离 */

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
    
    // 左视图距左边框的距离
    [parentView addSubview:self.leftViewLeftOffsetTextField];
    [self.leftViewLeftOffsetTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(changeExplainLabel);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(changeExplainLabel.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    // 右视图距文字的距离
    [parentView addSubview:self.rightViewLeftOffsetTextField];
    [self.rightViewLeftOffsetTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(changeExplainLabel);
        make.width.mas_equalTo(self.leftViewLeftOffsetTextField);
        make.top.mas_equalTo(self.leftViewLeftOffsetTextField);
        make.height.mas_equalTo(self.leftViewLeftOffsetTextField);
    }];
    
    [parentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(changeExplainLabel);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(self.leftViewLeftOffsetTextField.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    // 左视图距文字的距离
    [parentView addSubview:self.leftViewRightOffsetTextField];
    self.leftViewRightOffsetTextField.backgroundColor = [UIColor blueColor];
    [self.leftViewRightOffsetTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftViewLeftOffsetTextField);
        make.width.mas_equalTo(self.leftViewLeftOffsetTextField);
        make.top.mas_equalTo(self.textField.mas_bottom);
        make.height.mas_equalTo(self.leftViewLeftOffsetTextField);
    }];

    // 右视图距右边框的距离
    [parentView addSubview:self.rightViewRightOffsetTextField];
    [self.rightViewRightOffsetTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightViewLeftOffsetTextField);
        make.width.mas_equalTo(self.rightViewLeftOffsetTextField);
        make.top.mas_equalTo(self.leftViewRightOffsetTextField);
        make.height.mas_equalTo(self.rightViewLeftOffsetTextField);
    }];
    
    
    UILabel *extraResultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    extraResultLabel.backgroundColor = [UIColor cyanColor];
    extraResultLabel.textAlignment = NSTextAlignmentLeft;
    extraResultLabel.font = [UIFont systemFontOfSize:14];
    extraResultLabel.numberOfLines = 0;
    [parentView addSubview:extraResultLabel];
    [extraResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(changeExplainLabel);
        make.right.mas_equalTo(changeExplainLabel);
        make.top.mas_equalTo(self.rightViewRightOffsetTextField.mas_bottom);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(parentView).mas_offset(-0);//使得cell自适应
    }];
    self.extraResultLabel = extraResultLabel;
}

#pragma mark - Private
- (void)__updateTFLayout {
    self.textField.leftViewLeftOffset = self.leftViewLeftOffset;
    self.textField.leftViewRightOffset = self.leftViewRightOffset;
    self.textField.rightViewLeftOffset = self.rightViewLeftOffset;
    self.textField.rightViewRightOffset = self.rightViewRightOffset;
    
    [self.textField setNeedsLayout];
    [self.textField layoutIfNeeded];
}

#pragma mark - Lazy
- (CJTextField *)textField {
    if (_textField == nil) {
        CJTextField *textField = [[CJTextField alloc] initWithFrame:CGRectZero];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.backgroundColor = CJColorFromHexString(@"#ffffff");
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.backgroundColor = [UIColor orangeColor];
        UIImage *leftNormalImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)];;
        [leftButton setImage:leftNormalImage forState:UIControlStateNormal];
        [leftButton setCjTouchUpInsideBlock:^(UIButton *button) {
            NSLog(@"左边按钮点击");
        }];
        [leftButton setFrame:CGRectMake(0, 0, 20, 20)];
        
        textField.leftView = leftButton;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftViewLeftOffset = 0;
        textField.leftViewRightOffset = 0;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.backgroundColor = [UIColor orangeColor];
        UIImage *rightNormalImage = [UIImage cj_imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)];
        [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
        [rightButton setCjTouchUpInsideBlock:^(UIButton *button) {
            NSLog(@"右边按钮点击");
        }];
        [rightButton setFrame:CGRectMake(0, 0, 20, 20)];
        
        textField.rightView = rightButton;
        textField.rightViewMode = UITextFieldViewModeAlways;
        textField.rightViewLeftOffset = 0;
        textField.rightViewRightOffset = 0;
        
        textField.backgroundColor = [UIColor greenColor];
        textField.leftView.alpha = 0.8;
        textField.rightView.alpha = 0.8;
        
        textField.text = @"12345678901";
        _textField = textField;
    }
    return _textField;
}

/// 左视图距左边框的距离
- (CQTSMinusAddView *)leftViewLeftOffsetTextField {
    if (_leftViewLeftOffsetTextField == nil) {
        _leftViewLeftOffsetTextField = [[CQTSMinusAddView alloc] initWithMinusHandle:^(UIButton *button) {
            self->_leftViewLeftOffset--;
            self->_leftViewLeftOffsetTextField.text = [NSString stringWithFormat:@"%.0f", self->_leftViewLeftOffset];
            [self __updateTFLayout];
        } addHandle:^(UIButton *button) {
            self->_leftViewLeftOffset++;
            self->_leftViewLeftOffsetTextField.text = [NSString stringWithFormat:@"%.0f", self->_leftViewLeftOffset];
            [self __updateTFLayout];
        }];
        // textField 没有 minimumScaleFactor 属性
        NSString *placeholder = @"左视图距左边框的距离";
        NSMutableAttributedString *attributedPlaceholder = [self __attributedPlaceholder:placeholder];
        _leftViewLeftOffsetTextField.textField.attributedPlaceholder = attributedPlaceholder;
    }
    return _leftViewLeftOffsetTextField;
}

/// 左视图距文字的距离
- (CQTSMinusAddView *)leftViewRightOffsetTextField {
    if (_leftViewRightOffsetTextField == nil) {
        _leftViewRightOffsetTextField = [[CQTSMinusAddView alloc] initWithMinusHandle:^(UIButton *button) {
            self->_leftViewRightOffset--;
            self->_leftViewRightOffsetTextField.text = [NSString stringWithFormat:@"%.0f", self->_leftViewRightOffset];
            [self __updateTFLayout];
        } addHandle:^(UIButton *button) {
            self->_leftViewRightOffset++;
            self->_leftViewRightOffsetTextField.text = [NSString stringWithFormat:@"%.0f", self->_leftViewRightOffset];
            [self __updateTFLayout];
        }];
        NSString *placeholder = @"左视图距文字的距离";
        NSMutableAttributedString *attributedPlaceholder = [self __attributedPlaceholder:placeholder];
        _leftViewRightOffsetTextField.textField.attributedPlaceholder = attributedPlaceholder;
    }
    return _leftViewRightOffsetTextField;
}


/// 右视图距文字的距离
- (CQTSMinusAddView *)rightViewLeftOffsetTextField {
    if (_rightViewLeftOffsetTextField == nil) {
        _rightViewLeftOffsetTextField = [[CQTSMinusAddView alloc] initWithMinusHandle:^(UIButton *button) {
            self->_rightViewLeftOffset--;
            self->_rightViewLeftOffsetTextField.text = [NSString stringWithFormat:@"%.0f", self->_rightViewLeftOffset];
            [self __updateTFLayout];
        } addHandle:^(UIButton *button) {
            self->_rightViewLeftOffset++;
            self->_rightViewLeftOffsetTextField.text = [NSString stringWithFormat:@"%.0f", self->_rightViewLeftOffset];
            [self __updateTFLayout];
        }];
        NSString *placeholder = @"右视图距文字的距离";
        NSMutableAttributedString *attributedPlaceholder = [self __attributedPlaceholder:placeholder];
        _rightViewLeftOffsetTextField.textField.attributedPlaceholder = attributedPlaceholder;
    }
    return _rightViewLeftOffsetTextField;
}

/// 右视图距右边框的距离
- (CQTSMinusAddView *)rightViewRightOffsetTextField {
    if (_rightViewRightOffsetTextField == nil) {
        _rightViewRightOffsetTextField = [[CQTSMinusAddView alloc] initWithMinusHandle:^(UIButton *button) {
            self->_rightViewRightOffset--;
            self->_rightViewRightOffsetTextField.text = [NSString stringWithFormat:@"%.0f", self->_rightViewRightOffset];
            [self __updateTFLayout];
        } addHandle:^(UIButton *button) {
            self->_rightViewRightOffset++;
            self->_rightViewRightOffsetTextField.text = [NSString stringWithFormat:@"%.0f", self->_rightViewRightOffset];
            [self __updateTFLayout];
        }];
        NSString *placeholder = @"右视图距右边框的距离";
        NSMutableAttributedString *attributedPlaceholder = [self __attributedPlaceholder:placeholder];
        _rightViewRightOffsetTextField.textField.attributedPlaceholder = attributedPlaceholder;
    }
    return _rightViewRightOffsetTextField;
}


#pragma mark - Private Method
- (NSMutableAttributedString *)__attributedPlaceholder:(NSString *)placeholder {
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [attributedPlaceholder addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:11]
                                  range:NSMakeRange(0, placeholder.length)];
    return attributedPlaceholder;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
