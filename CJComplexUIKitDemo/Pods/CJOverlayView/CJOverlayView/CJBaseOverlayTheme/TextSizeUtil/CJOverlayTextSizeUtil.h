//
//  CJOverlayTextSizeUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJOverlayTextSizeUtil : NSObject

#pragma mark --  size helper
+ (CGSize)sizeOfText:(NSString *)text WithMaxSize:(CGSize)maxSize font:(UIFont *)font;

//以下获取textSize方法取自NSString+CJTextSize
+ (CGSize)getTextSizeFromString:(NSString *)string
                       withFont:(UIFont *)font
                        maxSize:(CGSize)maxSize
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                 paragraphStyle:(nullable NSMutableParagraphStyle *)paragraphStyle;

@end

NS_ASSUME_NONNULL_END
