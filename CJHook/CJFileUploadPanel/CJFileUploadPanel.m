//
//  CJFileUploadPanel.m
//  CJHookDemo
//
//  Created by ciyouzen on 2019/1/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJFileUploadPanel.h"
#import "HookCJHelper.h"

@interface CJFileUploadPanel () {
    
}
@property (nonatomic, copy) NSString * (^absoluteFilePathHandle)(UIImage *originImage);

@end


@implementation CJFileUploadPanel

+ (CJFileUploadPanel *)sharedInstance {
    static CJFileUploadPanel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

/// start Hook FileUploadPanel With Get New Image absoluteFilePath From OriginImage Block
+ (void)startHookWithAbsoluteFilePathHandle:(NSString * (^)(UIImage *originImage))absoluteFilePathHandle {
    CJFileUploadPanel *sharedFileUploadPanel = [CJFileUploadPanel sharedInstance];
    sharedFileUploadPanel.absoluteFilePathHandle = absoluteFilePathHandle;
    
    [self hookFileUploadPanel:YES];
}

/// stop Hook FileUploadPanel
+ (void)stopHook {
    [self hookFileUploadPanel:NO];
}

+ (void)hookFileUploadPanel:(BOOL)hook {
    SEL originalSelector = @selector(imagePickerController:didFinishPickingMediaWithInfo:);
    SEL swizzledSelector = @selector(swizzled_imagePickerController:didFinishPickingMediaWithInfo:);
    Class originalClass = NSClassFromString(@"WKFileUploadPanel");
    //Class originalClass = NSClassFromString(@"UIWebFileUploadPanel");
    Class otherClass = [CJFileUploadPanel class];
    if (hook) {
        bool success = HookCJHelper_exchangeOriMethodToNewMethodWhichAddFromDiffClass(originalClass, originalSelector, otherClass, swizzledSelector);
        NSLog(@"exchangeOriMethodToNewMethod:%@", success ? @"success": @"failure");
    } else {
        bool success = HookCJHelper_recoverOriMethodToNewMethodWhichAddFromDiffClass(originalClass, originalSelector, otherClass, swizzledSelector);
        NSLog(@"recoverOriMethodToNewMethod:%@", success ? @"success": @"failure");
    }
}

/// the new method will repleace the `imagePickerController:didFinishPickingMediaWithInfo:` of `WKFileUploadPanel` class
- (void)swizzled_imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // attention: now the `self` is `WKFileUploadPanel`, not `CJFileUploadPanel`;
    // attention: now the `self` is `WKFileUploadPanel`, not `CJFileUploadPanel`;
    // attention: now the `self` is `WKFileUploadPanel`, not `CJFileUploadPanel`;
    CJFileUploadPanel *sharedFileUploadPanel = [CJFileUploadPanel sharedInstance];
    if (!sharedFileUploadPanel.absoluteFilePathHandle) {
        NSLog(@"Reminder: You do nothing for originImage");
        [self swizzled_imagePickerController:picker didFinishPickingMediaWithInfo:info];
        return;
    }
    
    NSMutableDictionary *new_info = [[NSMutableDictionary alloc] initWithDictionary:info];
    // because of the image from camera does not have asset URL, meaning the ReferenceURL is nil. so below we make the ReferenceURL value always be nil to let the system believe all the image is from Camera, include those from PhotoLibrary.
    [new_info setValue:nil forKey:@"UIImagePickerControllerReferenceURL"];
    
    UIImage *originImage = [new_info valueForKey:@"UIImagePickerControllerOriginalImage"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *absoluteFilePath = sharedFileUploadPanel.absoluteFilePathHandle(originImage);
        NSURL *newImageURL = [NSURL fileURLWithPath:absoluteFilePath];
        UIImage *newImage = [UIImage imageWithContentsOfFile:absoluteFilePath];
        
        [new_info setObject:newImage forKey:@"UIImagePickerControllerOriginalImage"];
        [new_info setObject:newImageURL forKey:@"UIImagePickerControllerImageURL"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // because of has swizzled, so the below method is call `imagePickerController:didFinishPickingMediaWithInfo:` method in fact
            [self swizzled_imagePickerController:picker didFinishPickingMediaWithInfo:new_info];
        });
    });
}

@end
