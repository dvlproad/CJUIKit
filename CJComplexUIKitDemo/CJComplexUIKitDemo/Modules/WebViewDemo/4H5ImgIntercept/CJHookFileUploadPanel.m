//
//  CJHookFileUploadPanel.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJHookFileUploadPanel.h"
#import <CJBaseHelper/HookCJHelper.h>

@implementation CJHookFileUploadPanel

+ (void)hookFileUploadPanel:(BOOL)hook {
    SEL originalSelector = @selector(imagePickerController:didFinishPickingMediaWithInfo:);
    SEL swizzledSelector = @selector(swizzled_imagePickerController:didFinishPickingMediaWithInfo:);
    Class originalClass = NSClassFromString(@"WKFileUploadPanel");
    Class otherClass = [CJHookFileUploadPanel class];
    if (hook) {
        bool success = HookCJHelper_exchangeOriMethodToNewMethodWhichAddFromDiffClass(originalClass, originalSelector, otherClass, swizzledSelector);
        NSLog(@"exchangeOriMethodToNewMethod:%@", success ? @"success": @"failure");
    } else {
        bool success = HookCJHelper_recoverOriMethodToNewMethodWhichAddFromDiffClass(originalClass, originalSelector, otherClass, swizzledSelector);
        NSLog(@"recoverOriMethodToNewMethod:%@", success ? @"success": @"failure");
    }
}

/// 替换后的代理方法
- (void)swizzled_imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSMutableDictionary *new_info = [[NSMutableDictionary alloc] initWithDictionary:info];
    // 因为相机是不会有asset URL的，即referenceURL会为空，所以我们设UIImagePickerControllerReferenceURL为空，以使得让WKFileUploadPanel以为从相册选取来的图片也是从相机来的。
    [new_info setValue:nil forKey:@"UIImagePickerControllerReferenceURL"];
    
    UIImage *originImage = [new_info valueForKey:@"UIImagePickerControllerOriginalImage"];;
    
    UIImage *newImage = [CJHookFileUploadPanel dealImage:originImage];
    
    NSString *imageFilePath = [CJHookFileUploadPanel imageFilePath];
    [CJHookFileUploadPanel saveToSandBox:newImage filePath:imageFilePath];
    NSURL *newImageURL = [NSURL fileURLWithPath:imageFilePath];
    [new_info setObject:newImage forKey:@"UIImagePickerControllerOriginalImage"];
    [new_info setObject:newImageURL forKey:@"UIImagePickerControllerImageURL"];
    
    // 方法的实现已经通过Method swizling交换了，所以这里调用的是原始实现
    [self swizzled_imagePickerController:picker didFinishPickingMediaWithInfo:new_info];
}


+ (UIImage *)dealImage:(UIImage *)image {
    UIImage *newImage = [UIImage imageNamed:@"饮品2.jpg"];
    return newImage;
}

+ (void)saveToSandBox:(UIImage *)image filePath:(NSString *)path {
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
}

+ (NSString *)imageFilePath {
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = @"yyyyMMddHHmmss";
    NSString *dateString = [dateFormater stringFromDate:date];
    NSString *fileName = [dateString stringByAppendingString:@".png"];
    return [documentDirectory stringByAppendingPathComponent:fileName];
}

@end
