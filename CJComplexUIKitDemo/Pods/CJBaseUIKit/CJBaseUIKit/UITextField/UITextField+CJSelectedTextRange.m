//
//  UITextField+CJSelectedTextRange.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UITextField+CJSelectedTextRange.h"

@implementation UITextField (CJSelectedTextRange)

/* 完整的描述请参见文件头部 */
- (NSRange)cjSelectedTextRange {
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

/* 完整的描述请参见文件头部 */
- (void)setCjSelectedTextRange:(NSRange)range
{
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *textRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:textRange];
}

@end
