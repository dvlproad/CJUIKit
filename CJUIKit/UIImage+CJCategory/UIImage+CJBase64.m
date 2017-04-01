//
//  UIImage+CJBase64.m
//  CJUIKitDemo
//
//  Created by lichq on 14-12-26.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "UIImage+CJBase64.h"

@implementation UIImage (CJBase64)

//1.UIImage转成base64
- (NSString *)imageTobase64{
    NSData *_data = UIImageJPEGRepresentation(self, 1.0f);
    
    NSString *_encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    //NSLog(@"===Encoded image:\n%@", _encodedImageStr);
    return _encodedImageStr;
}


@end
