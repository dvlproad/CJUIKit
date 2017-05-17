//
//  NSString+CJAttributedString.h
//  CJFoundationDemo
//
//  Created by lichq on 7/21/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (CJAttributedString)

- (NSAttributedString *)attributedSubString1:(NSString *)string1 font1:(UIFont *)font1 color1:(UIColor *)color1 subString2:(NSString *)string2 font2:(UIFont *)font2 color2:(UIColor *)color2;

- (NSAttributedString *)attributedSubString1:(NSString *)string1 font1:(UIFont *)font1 color1:(UIColor *)color1 udlin1:(BOOL)unlin1 subString2:(NSString *)string2 font2:(UIFont *)font2 color2:(UIColor *)color2 udlin2:(BOOL)unlin2;

- (NSAttributedString *)attributedSubString:(NSString *)string font:(UIFont *)font color:(UIColor *)color udline:(BOOL)unline;

@end
