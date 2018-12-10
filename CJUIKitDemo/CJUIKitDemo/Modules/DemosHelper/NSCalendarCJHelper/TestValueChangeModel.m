//
//  TestValueChangeModel.m
//  CJUIKitDemo
//
//  Created by 李超前 on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "TestValueChangeModel.h"

@interface TestValueChangeModel () {
    
}
@property (nonatomic, copy, readonly) id value;
@property (nonatomic, copy, readonly) id (^valueFromTextBlock)(NSString *string);
@property (nonatomic, copy, readonly) NSString* (^textFromValueBlock)(id value);    /**< 将value转给textField用 */
@property (nonatomic, copy, readonly) NSString* (^resultFromValueBlock)(id value);   /**< 将value转为resultLabel(一般只用textField就可以展示,所以该值一般为nil), */

@property (nonatomic, copy, readonly) id (^minusHandle)(id oldValue);
@property (nonatomic, copy, readonly) id (^addHandle)(id oldValue);

@end


@implementation TestValueChangeModel

- (instancetype)initWithValue:(id)value
           textFromValueBlock:(NSString* (^)(id value))textFromValueBlock
           valueFromTextBlock:(id (^)(NSString *string))valueFromTextBlock
{
    self = [super init];
    if (self) {
        _value = value;
        _textFromValueBlock = textFromValueBlock;
        _valueFromTextBlock = valueFromTextBlock;
    }
    return self;
}

- (void)setupChangeExplain:(NSString *)changeExplain minusHandle:(id (^)(id oldValue))minusHandle addHandle:(id (^)(id oldValue))addHandle
{
    _changeExplain = changeExplain;
    _minusHandle = minusHandle;
    _addHandle = addHandle;
}

- (NSString *)valueString {
    NSString *valueString = self.textFromValueBlock(self.value);
    return valueString;
}

- (NSString *)didMinusAction {
    _value = self.minusHandle(self.value);
    return self.valueString;
}

- (NSString *)didAddAction {
    _value = self.addHandle(self.value);
    return self.valueString;
}

#pragma mark - 额外结果信息
- (void)setupResultFromValueBlock:(NSString* (^)(id value))resultFromValueBlock {
    _resultFromValueBlock = resultFromValueBlock;
}

- (NSString *)extarResultString {
    if (self.resultFromValueBlock) {
        NSString *extarResultString = self.resultFromValueBlock(self.value);
        return extarResultString;
        
    } else {
        return nil;
    }
    
}

@end
