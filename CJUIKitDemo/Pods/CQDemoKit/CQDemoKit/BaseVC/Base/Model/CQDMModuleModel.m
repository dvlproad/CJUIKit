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
    if (xibBundle == nil) {
        Class classEntry = self.classEntry;
        NSString *clsString = NSStringFromClass(classEntry);
        NSBundle *bundle = [NSBundle bundleForClass:clsString];
        NSString *bundleName = self.xibBundleName;
        NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
        xibBundle = [NSBundle bundleWithURL:url];
    }
    return xibBundle;
}

@end
