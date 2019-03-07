//
//  CJFileUploadPanel.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  详见我的简书：[拦截H5通过<input>标签选取的图片](https://www.jianshu.com/p/cc715c5b594c)

#import <Foundation/Foundation.h>

@interface CJFileUploadPanel : NSObject {
    
}
/// start Hook FileUploadPanel With Get New Image absoluteFilePath From OriginImage Block
+ (void)startHookWithAbsoluteFilePathHandle:(NSString * (^)(UIImage *originImage))absoluteFilePathHandle;

/// stop Hook FileUploadPanel
+ (void)stopHook;

@end
