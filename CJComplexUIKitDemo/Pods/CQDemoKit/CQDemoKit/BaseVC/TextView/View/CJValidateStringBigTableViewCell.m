//
//  CJValidateStringBigTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJValidateStringBigTableViewCell.h"

@interface CJValidateStringBigTableViewCell () {
    
}
@property (nonatomic, strong) UIView *container;

@end

@implementation CJValidateStringBigTableViewCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - Setter
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
    
    //UIView *parentView = self.contentView;
    UIView *container = [UIView new];
    [self.contentView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.left.mas_equalTo(self.contentView).mas_offset(10);
    }];
    self.container = container;
    UIView *parentView = container;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:14];
//    textField.minimumFontSize = 6;
//    [textField addTarget:self action:@selector(__textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(__textViewDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    [parentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView);
        make.centerX.mas_equalTo(parentView);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(parentView);
    }];
    self.textView = textView;
    
    
    UIButton *validateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    validateButton.layer.cornerRadius = 5;
    validateButton.layer.masksToBounds = YES;
    [validateButton setBackgroundColor:[UIColor orangeColor]];
    [validateButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [validateButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [validateButton.titleLabel setMinimumScaleFactor:0.4];
    [validateButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [validateButton addTarget:self action:@selector(validateAction) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:validateButton];
    [validateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textView).mas_offset(10);
        make.centerX.mas_equalTo(textView);
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(textView.mas_bottom).mas_offset(10);
    }];
    self.validateButton = validateButton;
    
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    resultLabel.numberOfLines = 0;
    resultLabel.backgroundColor = [UIColor clearColor];
    resultLabel.textColor = [UIColor lightGrayColor];
    resultLabel.textAlignment = NSTextAlignmentLeft;
    resultLabel.font = [UIFont systemFontOfSize:14];
    [parentView addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textView);
        make.right.mas_equalTo(textView);
        make.top.mas_equalTo(validateButton.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(parentView).mas_offset(-10);
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
    
    self.container.backgroundColor = validateSuccess ? [UIColor greenColor] : [UIColor redColor];
}


#pragma mark - Private Method
- (void)__textViewDidChange:(UITextView *)textView {
    //NSLog(@"textField内容改变了:%@", textView.text);
    !self.textDidChangeBlock ?: self.textDidChangeBlock(textView.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
