//
//  CameraH5ViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CameraH5ViewController.h"
#import "UIViewController+CJHookPresent.h"

@interface CameraH5ViewController () {
    
}

@end

@implementation CameraH5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"JS调用系统相册(网页版-拦截)", nil);
    
    self.networkUrl = @"http://gif.55.la/";
    self.shouldHookFileUploadPanel = YES;
}


/*
- (void)cjHook_onFileInputIntercept {
    //  当根视图为 UINavigationController 时，需要取出 navigation 对应的控制器
    //  获取 window
    UIWindow *mainWindow = [AppDelegate sharedAppDelegate].window;
    //  如果以导航控制器作为根控制器
    if ([mainWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
        __block NSInteger   index;
        [mainWindow.rootViewController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //  RootViewController 就是放了 webview 的 controller
            if ([obj isKindOfClass:[RootViewController class]]) {
                //  得到对应的控制器在导航控制器中的位置
                index = idx;
            }
        }];
        //  取出对应的控制器来实现方法
        UIViewController *vc = [mainWindow.rootViewController.childViewControllers objectAtIndex:index];
        if ([vc respondsToSelector:@selector(onFileInputClicked)]) {
            [vc performSelector:@selector(onFileInputClicked)];
        }
    }
    
    
    if ([self respondsToSelector:@selector(cjHook_onFileInputClicked)]) {
        [self performSelector:@selector(cjHook_onFileInputClicked)];
    }
}
//*/

- (void)cjHook_onFileInputClicked {
    [CJToast shortShowMessage:@"H5正在直接调用相册"];
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
