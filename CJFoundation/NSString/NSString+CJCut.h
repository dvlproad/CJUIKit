//
//  NSString+CJCut.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/21/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CJCut)

- (NSArray<NSString *> *)removeSeprateCharacterWithStart:(NSString *)startCharacter
                                                     end:(NSString *)endCharacter;

@end

NS_ASSUME_NONNULL_END
