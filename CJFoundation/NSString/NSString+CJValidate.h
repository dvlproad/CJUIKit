//
//  NSString+CJValidate.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJAreaType) {
    CJAreaTypeMainland,     /**< 大陆地区 */
    CJAreaTypeHongKong,     /**< 香港地区 */
    CJAreaTypeMacao,        /**< 澳门地区 */
};

@interface NSString (CJValidate)


///是否为空字符串
- (BOOL)cj_isEmpty;

///判断自己是否为空
- (BOOL)cj_isBlank;

//源自：iOS - 正则表达式判断邮箱、身份证..是否正确：http://www.2cto.com/kf/201311/256494.html

#pragma mark - 数字、字母、整型、浮点型的判断
///判断是否为整型
- (BOOL)cj_validateInt;
//判断是否为浮点型
- (BOOL)cj_validateFloat;

///判断仅输入数字或字母
- (BOOL)cj_validateNumberOrLetter;
///判断是否纯字母
- (BOOL)cj_validateAllLetter;
///验证是否是纯数字
- (BOOL)cj_validateAllNumber;

#pragma mark - 其他判断
///邮箱
- (BOOL)cj_validateEmail;

///手机号码验证
- (BOOL)cj_validateMobile:(CJAreaType)areaType;

///车牌号验证
- (BOOL)cj_validateCarNo:(CJAreaType)areaType;

///车型
- (BOOL)cj_validateCarType;

///用户名
- (BOOL)cj_validateUserName;

///密码
- (BOOL)cj_validatePassword;

///昵称
- (BOOL)cj_validateNickname;

///身份证号
- (BOOL)cj_validateIdentityCard;




#pragma mark - Append(在字符串后追加字符的判断)
/**
 *  判断数字字符串后面是否可以添加字符串(比如①是否允许出现小数点，②是否允许出现类似0005)
 *
 *  @param appendString 要添加的字符串
 *  @param allowDecimals 是否允许小数点
 *
 *  @return 是否允许追加
 */
- (BOOL)canAppendString:(NSString *)appendString allowDecimals:(BOOL)allowDecimals;

@end
