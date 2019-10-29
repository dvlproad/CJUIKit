//
//  CJValidateStringTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJValidateStringTableViewCell.h"

@implementation CJValidateStringTableViewCell

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

- (void)setupViews {
    UIView *parentView = self.contentView;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.font = [UIFont systemFontOfSize:14];
    [parentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(5);
        make.width.mas_equalTo(125);
        make.centerY.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(5);
    }];
    self.textField = textField;
    
    
    UIButton *validateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [validateButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [validateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [validateButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [validateButton.titleLabel setMinimumScaleFactor:0.4];
    [validateButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [validateButton addTarget:self action:@selector(validateEvent:) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:validateButton];
    [validateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(parentView);
        make.width.mas_equalTo(88);
        make.centerY.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(5);
    }];
    self.validateButton = validateButton;
    
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    resultLabel.backgroundColor = [UIColor greenColor];
    resultLabel.textColor = [UIColor lightGrayColor];
    resultLabel.textAlignment = NSTextAlignmentLeft;
    resultLabel.font = [UIFont systemFontOfSize:14];
    [parentView addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(validateButton.mas_right).mas_offset(5);
        make.right.mas_equalTo(parentView).mas_offset(-5);
        make.centerY.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(5);
    }];
    self.resultLabel = resultLabel;
}

- (void)validateEvent:(UIButton *)validateButton {
    if (self.validateHandle) {
        self.validateHandle(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
