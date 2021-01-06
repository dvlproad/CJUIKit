//
//  CQBlockTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQBlockTextField.h"
#import "NSString+CJTextLength.h"
#import "UITextViewCJHelper.h"
//#import "UITextField+CJBlock.h"
#import "CQTextFieldDelegate.h"

@interface CQBlockTextField () <UITextFieldDelegate> {
    
}
@property (nonatomic, copy) void (^textDidChangeBlock)(NSString *text);         /**< 文本已经改变的通知事件 */

@property (nonatomic, strong) CQTextFieldDelegate *blockDelegate;
@property (nonatomic, copy, readonly) NSString *lastSuccessDidChangeText;
@property (nonatomic, assign, readonly) NSRange newChangeCharactersInRange;

@end

@implementation CQBlockTextField

/*
 *  初始化将delegete接口改为block的文本输入框视图(使用此类时候，禁止再进行delegate的设置)
 *  @brief  使用此类时候，禁止再进行delegate的设置
 *
 *  @param textDidChangeBlock       文本已经改变的通知事件
 *
 *  @return 将delegete接口改为block的文本输入框视图
 */
- (instancetype)initWithTextDidChangeBlock:(void (^ __nullable)(NSString *text))textDidChangeBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _textDidChangeBlock = textDidChangeBlock;
        
        [self changeDelegateToBlock];
    }
    return self;
}

/// 将delegete接口改为block
- (void)changeDelegateToBlock {
    CQTextFieldDelegate *blockDelegate = [[CQTextFieldDelegate alloc] init];
    self.blockDelegate = blockDelegate;
    self.delegate = blockDelegate;
    
//    self.delegate = self; // 会有特殊bug:输入拼音后，点击上面的中文没走shouldChangeCharactersInRange

    //②直接添加监视
    [self addTarget:self action:@selector(__textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}



#pragma mark - Event
- (NSInteger)maxTextLength {
    return self.blockDelegate.maxTextLength;
}

- (void)updateMaxTextLength:(NSInteger)maxTextLength {
    [self.blockDelegate setupMaxTextLength:maxTextLength];
}

#pragma mark - Private Method
/**
 *  文本内容改变的事件
 */
- (void)__textFieldDidChange:(UITextField *)textField {
    // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断(注意1高亮的时候，长度计算以莫名其妙的规则计算，2shouldChangeCharactersInRange中无法获取第一个未选中的时机)
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    if (position) {
        
//        return;
    } else {
        _newChangeCharactersInRange = self.blockDelegate.shouldChangeCharactersInRange;
    }
    
    // 过滤空格
    NSLog(@"系统处理后得到的文本:%@", textField.text);
    NSString *oldText = self.lastSuccessDidChangeText;
    NSRange range = self.newChangeCharactersInRange;
    NSString *string = self.blockDelegate.shouldChangeWithReplacementString;
    NSString *newText = [UITextViewCJHelper shouldChange_newTextFromOldText:oldText shouldChangeCharactersInRange:range replacementString:string maxTextLength:self.maxTextLength];
    NSLog(@"自己处理希望得到的文本:%@", newText);    // 有时候限制了最大长度，又在中间插入超多字符。会希望原有字符不变。只插入其他数值
    
//    if (shouldChangeText != nil) {
//        NSString *oldText = shouldChangeText;
//        NSInteger maxTextLength = self.blockDelegate.maxTextLength;
//        NSString *newText = [UITextViewCJHelper didChange_newTextFromShouldChangeText:oldText maxTextLength:maxTextLength];
//        textField.text = newText;
//    }
    textField.text = newText;
    
    _lastSuccessDidChangeText = textField.text;
    
    if (self.textDidChangeBlock) {
        self.textDidChangeBlock(textField.text);
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
