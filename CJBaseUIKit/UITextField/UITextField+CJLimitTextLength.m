//
//  UITextField+CJLimitTextLength.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextField+CJLimitTextLength.h"
#import <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, copy) void (^cjLimitCompleteBlock)(void);

@end

@implementation UITextField (CJLimitLength)

#pragma mark - runtime
static NSString *kCJLimitTextLengthKey = @"kCJLimitTextLengthKey";
static NSString *kCJLimitCompleteBlockKey = @"kCJLimitCompleteBlockKey";

- (void (^)(void))cjLimitCompleteBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(kCJLimitCompleteBlockKey));
}

- (void)setCjLimitCompleteBlock:(void (^)(void))cjLimitCompleteBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(kCJLimitCompleteBlockKey), cjLimitCompleteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)cj_limitTextLength:(int)length {
    [self cj_limitTextLength:length withLimitCompleteBlock:nil];
}

- (void)cj_limitTextLength:(int)length withLimitCompleteBlock:(void(^)(void))limitCompleteBlock
{
    objc_setAssociatedObject(self, (__bridge const void *)(kCJLimitTextLengthKey), [NSNumber numberWithInt:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.cjLimitCompleteBlock = limitCompleteBlock;
   
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
    
}
- (void)textFieldTextLengthLimit:(id)sender
{
    NSNumber *limitTextLengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kCJLimitTextLengthKey));
    
    NSInteger limitTextLength = [limitTextLengthNumber intValue];
    
    if(self.text.length > limitTextLength){
        self.text = [self.text substringToIndex:limitTextLength];
        
        if (self.cjLimitCompleteBlock) {
            self.cjLimitCompleteBlock();
        }
    }
}

@end



