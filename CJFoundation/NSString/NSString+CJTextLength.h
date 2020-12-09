//
//  NSString+CJTextLength.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (CJTextLength)

//得到中英文混合字符串长度
- (NSInteger)cj_length;
@end
