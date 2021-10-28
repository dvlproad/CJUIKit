//
//  TextViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextViewController.h"
#import "UIView+CJAutoMoveUp.h"

@implementation TextViewController

- (void)dealloc {
    [self.textView cj_removeKeyboardNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = NSLocalizedString(@"TextView仿微信输入框", nil);
    
//    CJTextView *textView1 = [[CJTextView alloc] init];
//    textView1.text = @"总感觉看得见的生活在";
//    [self.view addSubview:textView1];
//    [textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).mas_offset(60);
//        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(24);
//        make.height.mas_greaterThanOrEqualTo(100);
//    }];
    
    // 监听键盘弹出
    __weak typeof(self)weakSelf = self;
    [self.textView cj_registerKeyboardNotificationWithWillShowBlock:nil willHideBlock:nil willChangeFrameBlock:^(CGFloat keyboardHeight, CGFloat keyboardTopY, CGFloat duration) {
        // 修改底部视图距离底部的间距
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf->_bottomViewBottomConstraint.constant = keyboardHeight;
        
        // 约束动画
        [UIView animateWithDuration:duration animations:^{
            [self.view layoutIfNeeded];
        }];
    }];
    
    // 设置文本框占位文字
    _textView.placeholder = @"这是CJTextView的占位文字";
    _textView.placeholderColor = [UIColor redColor];
    
    // 设置文本框最大行数 及 监听文本框文字高度改变
    [self.textView setMaxNumberOfLines:4];
    [self.textView configDidChangeHappenHandle:nil didChangeCompleteBlock:^(NSString * _Nonnull text, BOOL shouldUpdateHeight, CGFloat currentTextViewHeight) {
        // 文本框文字高度改变会自动执行这个【block】，可以在这【修改底部View的高度】
        // 设置底部条的高度 = 文字高度 + textView距离上下间距约束
        // 为什么添加10 ？（10 = 底部View距离上（5）底部View距离下（5）间距总和）
        weakSelf.bottomViewHeightConstraint.constant = currentTextViewHeight + 10;
    }];
    
    //方法②：
//    [self.textView setMaxTextViewHeight:200 textHeightChangeBlock:^(NSString *text, CGFloat currentTextViewHeight) {
//        _bottomViewHeightConstraint.constant = currentTextViewHeight + 10;
//    }];
}

- (IBAction)resetTextView:(UIButton *)button {
    self.textView.text = @"";
    
    _bottomViewHeightConstraint.constant = self.textView.originTextViewHeight + 10;
}


-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
