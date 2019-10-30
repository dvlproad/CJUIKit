//
//  NSString+CJAttributedString.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/21/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class CJStringAttributedModel;
@interface NSString (CJAttributedString)

/**
 *  对字符串中用特殊始止字符包取来的部分，按照指定的字符串配置进行自定义
 *
 *  @param startCharacter           开始的特殊字符
 *  @param endCharacter             结束的特殊字符
 *  @param stringAttributedModel    特殊字符之间的字符串需要进行自定义的那些配置(不需要设置是什么字符,因为这里已约定处理特殊字符之间的)
 *
 *  @return 符合要求的富文本
 */
- (NSMutableString *)attributedStringForSepicalBetweenStart:(NSString *)startCharacter
                                                        end:(NSString *)endCharacter
                                middleStringAttributedModel:(CJStringAttributedModel *)middleStringAttributedModel;

/**
 *  对字符串中的子字符串们进行自定义设置
 *
 *  @param attributedStringModels   要设置的那些子字符串的①字符串值②字体③颜色④下划线
 *
 *  @return 子字符串们经过自定义后的新的字符串
 */
- (NSAttributedString *)attributedStringWithModels:(NSArray<CJStringAttributedModel *> *)attributedStringModels;

@end




#pragma mark - CJStringAttributedModel类的声明
@interface CJStringAttributedModel : NSObject {
    
}

@property (nonatomic, copy) NSString *string;       /**< 要处理的子字符串 */
@property (nonatomic) UIFont *font;                 /**< 要处理的子字符串的字体 */
@property (nonatomic) UIColor *color;               /**< 要处理的子字符串的颜色 */
@property (nonatomic, assign) BOOL underline;       /**< 要处理的子字符串是否显示下划线 */

@end

