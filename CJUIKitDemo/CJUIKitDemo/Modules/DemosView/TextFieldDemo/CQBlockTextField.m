//
//  CQBlockTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQBlockTextField.h"
#import "CQTextFieldDelegate.h"
#import "UITextViewCJHelper.h"

@interface CQBlockTextField () <UITextFieldDelegate> {
    
}
@property (nonatomic, strong) CQTextFieldDelegate *blockDelegate;
@property (nonatomic, copy) void (^textDidChangeBlock)(NSString *text);         /**< 文本改变的回调（只回调没有待定词的回调） */

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


#pragma mark - Setup
/*
 *  设置最大长度
 *
 *  @param maxTextLength    最大长度（英文长度算1，中文长度算2）
 */
- (void)setupMaxTextLength:(NSInteger)maxTextLength {
    [self.blockDelegate setupMaxTextLength:maxTextLength];
}

#pragma mark - Getter
- (NSInteger)maxTextLength {
    return self.blockDelegate.maxTextLength;
}

#pragma mark - Private Method
/**
 *  文本内容改变的事件
 */
- (void)__textFieldDidChange:(UITextField *)textField {
    // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断(注意1高亮的时候，长度计算以莫名其妙的规则计算，2shouldChangeCharactersInRange中无法获取第一个未选中的时机)
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    BOOL donotneedCustomDealText = position != nil; // 存在高亮即未选中文本的时候，不需要自己处理文本框内容
    if (donotneedCustomDealText ==  YES) {
        return;
    }
    
    // 过滤空格
    //NSLog(@"系统处理后得到的文本:%@", textField.text);
    NSString *oldText = self.blockDelegate.shouldChangeWithOldText; // 文本框中高亮和不高亮的文本
    NSRange range = self.blockDelegate.shouldChangeCharactersInRange;
    NSString *string = self.blockDelegate.shouldChangeWithReplacementString;
    NSInteger maxTextLength = self.blockDelegate.maxTextLength;
    CQTextInputChangeResultModel *resultModel =
            [UITextViewCJHelper shouldChange_newTextFromOldText:oldText
                                  shouldChangeCharactersInRange:range
                                              replacementString:string maxTextLength:maxTextLength];
    if (resultModel.isDifferentFromSystemDeal) {
        // 注意，此步非常重要。是为了对于那些系统能处理的，就不去自己再setText了，防止光标和range变化。可有异常
        NSString *newText = resultModel.hopeNewText;
        //NSLog(@"自己处理希望得到的文本:%@", newText);    // 有时候限制了最大长度，又在中间插入超多字符。会希望原有字符不变。只插入其他数值
        textField.text = newText;   // 使用这个方法会使得光标变到末尾了,所以我们还需要更新光标位置
        NSString *lastReplacementString = resultModel.hopeReplacementString;
        NSInteger cursorLocation = range.location+lastReplacementString.length;
        [UITextViewCJHelper setCursorLocationForTextField:textField atIndex:cursorLocation];
    }
    
    _lastSelectedText = textField.text;  // 只文本框中高亮的文本
    
    
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
