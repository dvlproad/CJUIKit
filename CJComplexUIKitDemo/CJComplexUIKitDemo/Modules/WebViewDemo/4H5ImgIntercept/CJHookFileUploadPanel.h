//
//  CJHookFileUploadPanel.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  详见我的简书：[拦截H5通过<input>标签选取的图片](https://www.jianshu.com/p/cc715c5b594c)

#import <Foundation/Foundation.h>
#import "CJImagePickerMediaModel.h"

@interface CJHookFileUploadPanel : NSObject {
    
}
@property (nonatomic, copy) CJImagePickerMediaModel * (^getNewImagePickerMediaModelFromOriginImageBlock)(UIImage *originImage);


+ (CJHookFileUploadPanel *)sharedInstance;
+ (void)hookFileUploadPanel:(BOOL)hook;

@end
