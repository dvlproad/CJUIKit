//
//  H5ImgInterceptPickerViewController1.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "H5ImgInterceptPickerViewController1.h"
#import "UIViewController+CJHookImagePicker.h"
#import "DemoCacheUtil.h"

@interface H5ImgInterceptPickerViewController1 () {
    
}

@end

@implementation H5ImgInterceptPickerViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"H5选择的系统照片拦截--②load拦截图片", nil);
    self.useWebTitle = NO;
    
    NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"H5ImgPickerIntercept.html" ofType:nil];
    [self reloadLocalWebWithUrl:localHtmlUrl]; //加载本地网页
    
    self.cjShouldHookFileUploadPanelFinishPicking = YES;
}

- (NSDictionary *)cjHook_FileUploadPanelFinishPicking:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [CJToast shortShowMessage:@"Congratulation：H5正在直接调用相册,被我拦截了"];
    
    NSMutableDictionary *new_info = [[NSMutableDictionary alloc] initWithDictionary:info];
    // because of the image from camera does not have asset URL, meaning the ReferenceURL is nil. so below we make the ReferenceURL value always be nil to let the system believe all the image is from Camera, include those from PhotoLibrary.
    [new_info setValue:nil forKey:@"UIImagePickerControllerReferenceURL"];
    
    UIImage *originImage = [new_info valueForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSData *newImageData = [self dealImage:originImage];
    
    // 保存图片到本地
    NSString *absoluteFilePath = [DemoCacheUtil saveImageData:newImageData forModuleType:DemoModuleTypeIot];
    NSURL *newImageURL = [NSURL fileURLWithPath:absoluteFilePath];
    UIImage *newImage = [UIImage imageWithData:newImageData];
    
    
    [new_info setObject:newImage forKey:@"UIImagePickerControllerOriginalImage"];
    [new_info setObject:newImageURL forKey:@"UIImagePickerControllerImageURL"];
    
    return new_info;
}


- (NSData *)dealImage:(UIImage *)image {
    UIImage *newImage = [UIImage imageNamed:@"饮品2.jpg"];
    NSData *newImageData = UIImagePNGRepresentation(newImage);
    return newImageData;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
