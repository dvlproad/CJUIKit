//
//  TestChangeModel2.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const TestChangeModel2_sameMethod;
UIKIT_EXTERN NSString *const TestChangeModel2_diffMethod;

@interface TestChangeModel2 : NSObject

- (NSString *)common_swizzle_printLog;
- (NSString *)model2_swizzle_printLog;

@end
