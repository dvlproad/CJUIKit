//
//  CQUpdateContentPopupView.m
//  CJUIKitDemo
//
//  Created by qian on 2020/11/24.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQUpdateContentPopupView.h"
#import <Masonry/Masonry.h>
#import "UIColor+CJHex.h"

@interface CQUpdateContentPopupView () {
    
}
@property (nonatomic, strong) UILabel *titleLabel;      /**< 标题标签 */
@property (nonatomic, strong) UIButton *okButton;       /**< 确认按钮 */
@property (nonatomic, strong) UITextField *textField;   /**< 文本框 */

@property (nonatomic, copy, readonly) void(^okHandle)(NSString *bText);   /**< 更新成功的回调 */

@end

@implementation CQUpdateContentPopupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (CGRectEqualToRect(frame, CGRectZero)) {
        CGFloat height = 180;
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

/**
 *  设置标题、提示和击完成按钮的事件
 *
 *  @param title                标题
 *  @param placeholder  输入内容的提示文案
 *  @param okHandle         点击完成按钮的事件
 */
- (void)setupTitle:(NSString *)title
       placeholder:(NSString *)placeholder
updateCompleteBlock:(void(^)(NSString *bText))okHandle
{
    self.titleLabel.text = title;
    
    _okHandle = okHandle;
}


#pragma mark - SetupViews
- (void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [okButton setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okButton.backgroundColor = CJColorFromHexString(@"#0C101B");
    okButton.layer.cornerRadius = 18;
    okButton.layer.masksToBounds = YES;
    [okButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.height.equalTo(@36);
        make.right.equalTo(self).offset(-16);
        make.width.equalTo(@56);
    }];
    self.okButton = okButton;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = CJColorFromHexString(@"#B6B7BA");
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.right.equalTo(okButton.mas_left).offset(-10);
        make.centerY.equalTo(okButton);
        make.height.equalTo(@18);
    }];
    self.titleLabel = titleLabel;
    
    
    UITextField *textField = [[UITextField alloc] init];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.font = [UIFont systemFontOfSize:18];
    textField.textColor = CJColorFromHexString(@"#0C101B");
    textField.placeholder = NSLocalizedString(@"这是输入的内容", nil);
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(6);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(66+26);
        make.bottom.equalTo(self).offset(-68);
    }];
    self.textField = textField;
}

- (void)okAction {
    !self.okHandle ?: self.okHandle(self.textField.text);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
