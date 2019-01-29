//
//  UIImagePickerController+CJHookFileUploadPanel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIImagePickerController+CJHookFileUploadPanel.h"
#import <objc/runtime.h>
#import <CJBaseHelper/HookCJHelper.h>

@implementation UIImagePickerController (CJHookFileUploadPanel)

static BOOL isDelegateMethodHooked = false;

+ (void)hookDelegate {
    SEL originSEL = @selector(imagePickerController:didFinishPickingMediaWithInfo:);
    SEL swizzledSEL = @selector(swizzled_imagePickerController:didFinishPickingMediaWithInfo:);
    
    Class class = NSClassFromString(@"WKFileUploadPanel");
    hook_delegateMethod(class, originSEL, [UIImagePickerController class], swizzledSEL, swizzledSEL);
//    HookCJHelper_swizzleMethodInDiffClass(class, originSEL, [UIImagePickerController class], swizzledSEL);
//    HookCJHelper_swizzleMethodInDiffClass(class, originSEL, [UIImagePickerController class], swizzledSEL);
}

/**
 替换代理方法的实现
 */
static void hook_delegateMethod(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel)  {
    //原实例方法
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    //替换的实例方法
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    
    if (!originalMethod) {// 如果没有实现 delegate 方法，则手动动态添加
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        return;
    }
    
    // 向实现 delegate 的类中添加新的方法
    BOOL didAddMethod =class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    
    // 重新拿到添加被添加的 method, 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
    Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
    if(!isDelegateMethodHooked && originalMethod && newMethod) {
        method_exchangeImplementations(originalMethod, newMethod);// 实现交换
        isDelegateMethodHooked = YES;
    }
}

+ (void)unHookDelegate {
    SEL swizzledSEL = @selector(swizzled_imagePickerController:didFinishPickingMediaWithInfo:);
    SEL originSEL = @selector(imagePickerController:didFinishPickingMediaWithInfo:);
    Class class = NSClassFromString(@"WKFileUploadPanel");
    unHook_delegateMethod(class,swizzledSEL,originSEL);
}

/**
 恢复代理方法的实现
 */
static void unHook_delegateMethod(Class originalClass, SEL originalSel, SEL replacedSel){
    if(isDelegateMethodHooked) {
        Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
        Method replacedMethod = class_getInstanceMethod(originalClass, replacedSel);
        if (originalMethod && replacedMethod){
            // 重新拿到添加被添加的 method,这里是关键(注意这里 originalClass, 不 replacedClass), 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
            Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
            method_exchangeImplementations(originalMethod, newMethod);// 实现交换
            isDelegateMethodHooked = NO;
        }
    }
}

/**
 替换的代理实现
 
 @param picker picker
 @param info info
 */
- (void)swizzled_imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSMutableDictionary *new_info = [[NSMutableDictionary alloc] initWithDictionary:info];
    //UIImagePickerControllerReferenceURL设为空是关键一步。
    //相机是不会有asset URL,即referenceURL会为空，所以这里不需要传asset URL，直接传图片对象即可。
    //让WKFileUploadPanel以为从相册来的图片也是从相机来的
    [new_info setValue:nil forKey:@"UIImagePickerControllerReferenceURL"];
    
    
    UIImage *originImage = [new_info valueForKey:@"UIImagePickerControllerOriginalImage"];;
    
    UIImage *newImage = [UIImagePickerController dealImage:originImage];
    
    NSString *imageFilePath = [UIImagePickerController imageFilePath];
    [UIImagePickerController saveToSandBox:newImage filePath:imageFilePath];
    NSURL *newImageURL = [NSURL fileURLWithPath:imageFilePath];
    [new_info setObject:newImage forKey:@"UIImagePickerControllerOriginalImage"];
    [new_info setObject:newImageURL forKey:@"UIImagePickerControllerImageURL"];
    
    //方法的实现已经通过Method swizling交换了，所以这里调用的是原始实现
    [self swizzled_imagePickerController:picker didFinishPickingMediaWithInfo:new_info];
}

- (void)hookImageWithNewImage:(UIImage *)newImage newAbsoluteImagePath:(NSString *)newAbsoluteImagePath {
    
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
