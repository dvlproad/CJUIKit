//
//  CJHookFileUploadPanel.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJHookFileUploadPanel.h"
#import <CJBaseHelper/HookCJHelper.h>

@interface CJHookFileUploadPanel () {
    
}

@end

@implementation CJHookFileUploadPanel

+ (CJHookFileUploadPanel *)sharedInstance {
    static CJHookFileUploadPanel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

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

/// the new method will repleace the `imagePickerController:didFinishPickingMediaWithInfo:` of `WKFileUploadPanel` class
- (void)swizzled_imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // attention: now the `self` is `WKFileUploadPanel`, not `CJHookFileUploadPanel`;
    // attention: now the `self` is `WKFileUploadPanel`, not `CJHookFileUploadPanel`;
    // attention: now the `self` is `WKFileUploadPanel`, not `CJHookFileUploadPanel`;
    CJHookFileUploadPanel *sharedHookFileUploadPanel = [CJHookFileUploadPanel sharedInstance];
    if (!sharedHookFileUploadPanel.getNewImagePickerMediaModelFromOriginImageBlock) {
        NSLog(@"Reminder: You do nothing for originImage");
        [self swizzled_imagePickerController:picker didFinishPickingMediaWithInfo:info];
        return;
    }
    
    NSMutableDictionary *new_info = [[NSMutableDictionary alloc] initWithDictionary:info];
    // because of the image from camera does not have asset URL, meaning the ReferenceURL is nil. so below we make the ReferenceURL value always be nil to let the system believe all the image is from Camera, include those from PhotoLibrary.
    [new_info setValue:nil forKey:@"UIImagePickerControllerReferenceURL"];
    
    UIImage *originImage = [new_info valueForKey:@"UIImagePickerControllerOriginalImage"];
    CJImagePickerMediaModel *newImagePickerMediaModel = sharedHookFileUploadPanel.getNewImagePickerMediaModelFromOriginImageBlock(originImage);
    UIImage *newImage = newImagePickerMediaModel.originalImage;
    NSURL *newImageURL = newImagePickerMediaModel.imageURL;
    [new_info setObject:newImage forKey:@"UIImagePickerControllerOriginalImage"];
    [new_info setObject:newImageURL forKey:@"UIImagePickerControllerImageURL"];
    
    // because of has swizzled, so the below method is call `imagePickerController:didFinishPickingMediaWithInfo:` method in fact
    [self swizzled_imagePickerController:picker didFinishPickingMediaWithInfo:new_info];
}

@end
