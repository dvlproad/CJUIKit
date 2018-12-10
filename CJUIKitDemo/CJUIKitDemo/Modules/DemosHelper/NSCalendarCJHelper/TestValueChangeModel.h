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

@property (nonatomic, copy, readonly) NSString *extarResultString;/**< 额外的结果信息 */

- (instancetype)initWithValue:(id)value
           textFromValueBlock:(NSString* (^)(id value))textFromValueBlock
           valueFromTextBlock:(id (^)(NSString *string))valueFromTextBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (void)setupChangeExplain:(NSString *)changeExplain minusHandle:(id (^)(id oldValue))minusHandle addHandle:(id (^)(id oldValue))addHandle;

/// 展示额外的结果信息(用于在textField改变后在其下面多显示一个信息)，默认为nil,如果有值时候才会显示
- (void)setupResultFromValueBlock:(NSString* (^)(id value))resultFromValueBlock;

- (NSString *)didMinusAction;
- (NSString *)didAddAction;

@end
