//
//  CQDMModuleModel.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQDMModuleModel.h"

@implementation CQDMModuleModel

- (NSBundle *)xibBundle {
    NSBundle *xibBundle = _xibBundle;
    if (xibBundle == nil && _xibBundleName != nil) {
        Class classEntry = self.classEntry;
        //NSString *clsString = NSStringFromClass(classEntry);
        NSBundle *bundle = [NSBundle bundleForClass:classEntry];
        NSString *bundleName = self.xibBundleName;
        NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
        xibBundle = [NSBundle bundleWithURL:url];
    }
    return xibBundle;
}

- (void)updateContent:(NSString *)content {
    NSString *lastContentString = self.content;
    
    NSArray<NSString *> *components = [self.content componentsSeparatedByString:@"\n"];
    if (components.count > self.contentLines) {
        NSArray *firstTwoComponents = [components subarrayWithRange:NSMakeRange(0, self.contentLines)];
        lastContentString = [firstTwoComponents componentsJoinedByString:@"\n"];
    }
    
    self.content = content;
    
}

#pragma mark - Util
+ (UIViewController *)viewControllWithTitle:(NSString *)title tsview:(UIView *)tsview {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor colorWithRed:105/255.0 green:193/255.0 blue:243/255.0 alpha:1];
    viewController.title = NSLocalizedString(title, nil);

    // 将 tsview 添加到 viewController.view 中,设置 tsview 的自动布局约束
    [viewController.view addSubview:tsview];
    tsview.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [tsview.topAnchor constraintEqualToAnchor:viewController.view.safeAreaLayoutGuide.topAnchor constant:10],
        [tsview.bottomAnchor constraintEqualToAnchor:viewController.view.bottomAnchor constant:-10],
        [tsview.leadingAnchor constraintEqualToAnchor:viewController.view.leadingAnchor constant:10],
        [tsview.trailingAnchor constraintEqualToAnchor:viewController.view.safeAreaLayoutGuide.trailingAnchor constant:-10]
    ]];
    
    return viewController;
}

@end
