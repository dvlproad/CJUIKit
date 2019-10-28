//
//  NSString+CJCut.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/21/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (CJCut)

/**
 *  删除特殊字符后返回新的字符串数组
 *
 *  @param startCharacter   startCharacter
 *  @param endCharacter     endCharacter
 *
 *  @return 删除特殊字符后返回的新字符串数组
 */
- (NSArray<NSString *> *)removeSeprateCharacterWithStart:(NSString *)startCharacter
                                                     end:(NSString *)endCharacter;

/**
*  截取字符串中两个指定字符串中间的字符串
*
*  @param startCharacter   startCharacter
*  @param endCharacter     endCharacter
*
*  @return 截取字符串中两个指定字符串中间的字符串
*/
- (NSString *)getStringBetweenSeprateCharacterWithStart:(NSString *)startCharacter
                                                    end:(NSString *)endCharacter;

@end
