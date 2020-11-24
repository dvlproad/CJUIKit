//
//  CJUIKitRandomUtil.h
//  CQDemoKit
//
//  Created by 李超前 on 2020/11/13.
//

#ifndef CJUIKitRandomUtil_h
#define CJUIKitRandomUtil_h

UIColor *cqtsRandomColor() {
    return [UIColor colorWithRed:arc4random()%255/256.0f green:arc4random()%255/256.0f blue:arc4random()%255/256.0f alpha:1.0f];
}

/*
 *  获取随机的字符串
 *
 *  @param maxLength    随机字符串的最大长度
 *  @param fixMaxLength 是否固定为最大长度
 *
 *  @return 随机的字符串
 */
NSString *cqtsRandomString(NSInteger maxLength, BOOL fixMaxLength) {
    NSInteger randomStringLength = 0;   // 随机字符串的长度
    if (fixMaxLength) {
        randomStringLength = maxLength;
    } else {
        randomStringLength = rand() % maxLength;
    }
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRST";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < randomStringLength; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


#endif /* CJUIKitRandomUtil_h */
