//
//  NSString+CJEncoding.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 15/3/25.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encoding)

/**
 *  将Unicode转化为汉字
 *
 *  return  返回结果
 */
- (NSString *)cjEncodeUnicodeToChinese;//参考：ios 汉字转码（http://blog.csdn.net/jidiao/article/details/8456370）


/**
 *  对字符串做HTTP编码
 *
 *  @return 编码后的HTTP字符串
 */
- (NSString *)cjEncodeURL;

/**
 *  对字符串做HTTP解码
 *
 *  @return 编码后的HTTP字符串
 */
- (NSString *)cjDecodeURL;

@end
