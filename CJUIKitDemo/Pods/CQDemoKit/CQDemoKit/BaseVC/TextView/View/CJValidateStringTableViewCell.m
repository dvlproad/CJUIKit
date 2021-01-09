//
//  CJValidateStringTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJValidateStringTableViewCell.h"

@interface CJValidateStringTableViewCell () {
    
}

@end

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

#pragma mark - Setter
- (void)setFixResultLableWidth:(CGFloat)fixResultLableWidth {
    _fixResultLableWidth = fixResultLableWidth;
    
    if (fixResultLableWidth > 20) {
        [self.resultLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(fixResultLableWidth));
        }];
    }
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *parentView = self.contentView;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.font = [UIFont systemFontOfSize:14];
    textField.minimumFontSize = 6;
    [textField addTarget:self action:@selector(__textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [parentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(5);
        //make.width.mas_equalTo(125);
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
    [validateButton addTarget:self action:@selector(validateAction) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:validateButton];
    [validateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textField.mas_right).offset(0);
        make.width.mas_equalTo(88);
        make.centerY.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(5);
    }];
    self.validateButton = validateButton;
    
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    resultLabel.backgroundColor = [UIColor orangeColor];
    resultLabel.textColor = [UIColor lightGrayColor];
    resultLabel.textAlignment = NSTextAlignmentLeft;
    resultLabel.font = [UIFont systemFontOfSize:14];
    [parentView addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(validateButton.mas_right).mas_offset(5);
        make.right.mas_equalTo(parentView).mas_offset(-5);
        make.centerY.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(5);
//        make.width.equalTo(@100);
    }];
    self.resultLabel = resultLabel;
}


- (void)validateAction {
    [self validateEvent:NO];
}
/**
 *  cell执行既定操作
 *
 *  @param isAutoExec   是否在cell显示出来的时候自动执行
 */
- (void)validateEvent:(BOOL)isAutoExec {
    BOOL validateSuccess = YES;
    if (self.validateHandle) {
        validateSuccess = self.validateHandle(self, isAutoExec);
    }
    
    self.resultLabel.backgroundColor = validateSuccess ? [UIColor greenColor] : [UIColor redColor];
}


#pragma mark - Private Method
- (void)__textFieldDidChange:(UITextField *)textField {
    //NSLog(@"textField内容改变了:%@", textField.text);
    !self.textDidChangeBlock ?: self.textDidChangeBlock(textField.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
