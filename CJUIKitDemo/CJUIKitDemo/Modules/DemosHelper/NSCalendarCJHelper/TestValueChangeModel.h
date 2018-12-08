//
//  TestValueChangeModel.h
//  CJUIKitDemo
//
//  Created by 李超前 on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestValueChangeModel : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *valueString;

@property (nonatomic, copy, readonly) NSString *changeExplain;  /**< 测试加减项的解释说明 */

- (instancetype)initWithValue:(id)value stringFromValueBlock:(NSString* (^)(id value))stringFromValueBlock valueFromStringBlock:(id (^)(NSString *string))valueFromStringBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (void)setupChangeExplain:(NSString *)changeExplain minusHandle:(id (^)(id oldValue))minusHandle addHandle:(id (^)(id oldValue))addHandle;


- (NSString *)didMinusAction;
- (NSString *)didAddAction;

@end
