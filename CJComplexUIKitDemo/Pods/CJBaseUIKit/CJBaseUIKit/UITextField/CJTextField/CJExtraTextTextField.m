//
//  CJExtraTextTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJExtraTextTextField.h"
#import "UITextField+CJSelectedTextRange.h"


@interface CJExtraTextTextField () <UITextFieldDelegate>

@end



@implementation CJExtraTextTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.delegate = self;
    self.limitTextLength = NSIntegerMax;
}

//UITextField 没有change的事件
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    NSString *oldText = textField.text;
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:string];//若允许改变，则会改变成的新文本
    if ([newText length] > self.limitTextLength) {
        //NSLog(@"输入内容太长");
        return NO;
    }
    
    BOOL isCursorMinLocation = [self fixCursor];
    BOOL isDeleteOperation = string.length == 0;
    BOOL shouldChangeCharacters = !(isCursorMinLocation && isDeleteOperation);
    return shouldChangeCharacters;
}


/**
 *  自适应光标位置(当光标位置处在不符合的位置时候，其会自动调整光标到合适的位置)
 *
 *  @return 自适应后的光标位置是否是最小位置
 */
- (BOOL)fixCursor {
    UITextField *textField = self;
    
    BOOL isCursorMinLocation = NO;//光标是否在最小位置
    
    NSInteger currentCursorLocation = textField.cjSelectedTextRange.location;
    
    NSString *beforeExtraString = self.beforeExtraString;
    BOOL containBeforeExtraString = [textField.text hasPrefix:beforeExtraString];
    if (containBeforeExtraString) {
        NSRange beforeExtraStringRange = [textField.text rangeOfString:beforeExtraString];
        NSInteger newCursorMinLocation = beforeExtraStringRange.location+beforeExtraStringRange.length;
        if (currentCursorLocation < newCursorMinLocation) {
            NSInteger newCursorLocation = newCursorMinLocation;
            [textField setCjSelectedTextRange:NSMakeRange(newCursorLocation, 0)];
            
            isCursorMinLocation = YES;
        } else if (currentCursorLocation == newCursorMinLocation) {
            isCursorMinLocation = YES;
        } else {
            isCursorMinLocation = NO;;
        }
    }
    
    NSString *afterExtraString = self.afterExtraString;
    BOOL containAfterExtraString = [textField.text hasSuffix:afterExtraString];
    if (containAfterExtraString) {
        NSRange afterExtraStringRange = [textField.text rangeOfString:afterExtraString];
        NSInteger newCursorMaxLocation = afterExtraStringRange.location;
        if (currentCursorLocation > newCursorMaxLocation) {
            NSInteger newCursorLocation = newCursorMaxLocation;
            [textField setCjSelectedTextRange:NSMakeRange(newCursorLocation, 0)];
        }
    }
    
    return isCursorMinLocation;
}

/**
 *  完善补充textField的额外字符串
 *
 */
- (void)fixExtraString {
    UITextField *textField = self;
    
    if (textField.text.length == 0) {
        return;
    }
    
    NSString *middleString = [self middleString];
    if (middleString.length == 0) {
        textField.text = @"";
        return;
    }
    
    NSString *beforeExtraString = self.beforeExtraString;
    BOOL containBeforeExtraString = [textField.text hasPrefix:beforeExtraString];
    if (!containBeforeExtraString) {
        textField.text = [beforeExtraString stringByAppendingString:textField.text];
    }
    
    NSString *afterExtraString = self.afterExtraString;
    BOOL containAfterExtraString = [textField.text containsString:afterExtraString];
    if (!containAfterExtraString) {
        textField.text = [textField.text stringByAppendingString:afterExtraString];
        [self fixCursor];
    }
}


/**
 *  获取中间字符串
 *
 *  @return 中间字符串
 */
- (NSString *)middleString {
    UITextField *textField = self;
    
    NSInteger newCursorMinLocation = 0;
    NSInteger newCursorMaxLocation = 0;
    
    NSString *beforeExtraString = self.beforeExtraString;
    BOOL containBeforeExtraString = [textField.text hasPrefix:beforeExtraString];
    if (containBeforeExtraString) {
        NSRange beforeExtraStringRange = [textField.text rangeOfString:beforeExtraString];
        newCursorMinLocation = beforeExtraStringRange.location+beforeExtraStringRange.length;
    } else {
        newCursorMinLocation = 0;
    }
    
    NSString *afterExtraString = self.afterExtraString;
    BOOL containAfterExtraString = [textField.text hasSuffix:afterExtraString];
    if (containAfterExtraString) {
        NSRange afterExtraStringRange = [textField.text rangeOfString:afterExtraString];
        newCursorMaxLocation = afterExtraStringRange.location;
    } else {
        newCursorMaxLocation = self.text.length;
    }
    
    NSRange middleStringRange = NSMakeRange(newCursorMinLocation, newCursorMaxLocation - newCursorMinLocation);
    NSString *middleString = [textField.text substringWithRange:middleStringRange];
    
    return middleString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
