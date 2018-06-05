//
//  NSString+CJValidate.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSString+CJValidate.h"

@implementation NSString (CJValidate)

///是否为空字符串
- (BOOL)cj_isEmpty {
    BOOL isEmpty = !self || [self isEqual:[NSNull null]] || [self isEqualToString:@""];
    return isEmpty;
}

///判断自己是否为空
- (BOOL)cj_isBlank {
    if (!self.length ||
        self == nil ||
        self == NULL ||
        (NSNull *)self == [NSNull null] ||
        [self isKindOfClass:[NSNull class]] ||
        [self isEqualToString:@"(null)"] ||
        [self isEqualToString:@"<null>"] ||
        [self isEqualToString:@"null"] ||
        [self isEqualToString:@"NULL"]
        ) {
        return YES;
    }else {
        return NO;
    }
}


#pragma mark - 数字、字母、整型、浮点型的判断
///判断是否为整型(即是否为纯数字)
- (BOOL)cj_validateInt {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点型
- (BOOL)cj_validateFloat {
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/*
 //demo
 if( ![insertValue.text cj_validateInt] || ![insertValue.text cj_validateFloat])
 {
 resultLabel.textColor = [UIColor redColor];
 resultLabel.text = @"警告:含非法字符，请输入纯数字！";
 return;
 }
 */

///判断仅输入数字或字母
- (BOOL)cj_validateNumberOrLetter {
    if (self.length == 0) {
        return NO;
    }
    
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

///判断是否纯字母
- (BOOL)cj_validateAllLetter {
    if (self.length == 0) {
        return NO;
    }
    
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

///验证是否是纯数字
- (BOOL)cj_validateAllNumber {
    if (self.length == 0) {
        return NO;
    }
    
    NSString *regex =@"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

#pragma mark - 其他判断
///邮箱
- (BOOL)cj_validateEmail {
    if (self.length == 0) {
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}


///手机号码验证
- (BOOL)cj_validateMobile:(CJAreaType)areaType {
    //①大陆 +86+11位数字（正则表达式校验），1+10位数字
    //②香港 +852+8位数字（正则表达式校验），5/6/8/9+7位数字
    //③澳门 +853+8位数字（正则表达式校验），6+7位数字
    NSString *phoneRegex = @"^[1][0-9]{10}$";
    if (areaType == CJAreaTypeHongKong) {
        phoneRegex = @"^[5678][0-9]{7}$";
    } else if (areaType == CJAreaTypeMacao) {
        phoneRegex = @"^[6][0-9]{7}$";
    }
    
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePredicate evaluateWithObject:self];
}


///车牌号验证
- (BOOL)cj_validateCarNo:(CJAreaType)areaType {
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carPredicate is %@",carPredicate);
    return [carPredicate evaluateWithObject:self];
}


///车型
- (BOOL)cj_validateCarType {
    NSString *carTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTypePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carTypeRegex];
    return [carTypePredicate evaluateWithObject:self];
}


///用户名
- (BOOL)cj_validateUserName {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}


///密码
- (BOOL)cj_validatePassword {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}


///昵称
- (BOOL)cj_validateNickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}


///身份证号
- (BOOL)cj_validateIdentityCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}



#pragma mark - Append(在字符串后追加字符的判断)
/**
 *  判断数字字符串后面是否可以添加字符串(比如①是否允许出现小数点，②是否允许出现类似0005)
 *
 *  @param appendString 要添加的字符串
 *  @param allowDecimals 是否允许小数点
 *
 *  @return 是否允许追加
 */
- (BOOL)canAppendString:(NSString *)appendString allowDecimals:(BOOL)allowDecimals {
    BOOL isDelete = [appendString isEqualToString:@""]; //如果输入的是删除键
    if (isDelete) {
        return YES;
    }
    
    /* 小数点的检查 */
    if ([appendString isEqualToString:@"."]) {  //如果输入的是小数点
        if (!allowDecimals) { //不能添加小数点
            return NO;
        }
    }
    
    /* 0开头的检查 */
    NSString *numberString = self;
    if (!allowDecimals) { //不允许小数
        if ([numberString hasPrefix:@"0"]) {
            return NO;
        }
    } else {
        if ([numberString hasPrefix:@"00"]) {
            return NO;
        }
    }
    
    return YES;
}

@end
