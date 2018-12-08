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

@end
