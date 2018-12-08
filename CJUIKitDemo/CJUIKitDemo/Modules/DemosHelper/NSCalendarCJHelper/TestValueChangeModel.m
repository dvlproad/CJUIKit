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
@property (nonatomic, copy, readonly) id (^valueFromStringBlock)(NSString *string);
@property (nonatomic, copy, readonly) NSString* (^stringFromValueBlock)(id value);

@property (nonatomic, copy, readonly) id (^minusHandle)(id oldValue);
@property (nonatomic, copy, readonly) id (^addHandle)(id oldValue);

@property (nonatomic, copy) NSString* (^showExtraResultBlock)(id value);   /**< 展示额外的结果信息(用于在textField改变后在其下面多显示一个信息)，默认为nil,如果有值时候才会显示 */

@end


@implementation TestValueChangeModel

- (instancetype)initWithValue:(id)value stringFromValueBlock:(NSString* (^)(id value))stringFromValueBlock valueFromStringBlock:(id (^)(NSString *string))valueFromStringBlock
{
    self = [super init];
    if (self) {
        _value = value;
        _stringFromValueBlock = stringFromValueBlock;
        _valueFromStringBlock = valueFromStringBlock;
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
    NSString *valueString = self.stringFromValueBlock(self.value);
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
- (void)setupShowExtraResultBlock:(NSString *(^)(id))showExtraResultBlock {
    _showExtraResultBlock = showExtraResultBlock;
}

- (NSString *)extarResultString {
    if (self.showExtraResultBlock) {
        NSString *extarResultString = self.showExtraResultBlock(self.value);
        return extarResultString;
        
    } else {
        return nil;
    }
    
}

@end
