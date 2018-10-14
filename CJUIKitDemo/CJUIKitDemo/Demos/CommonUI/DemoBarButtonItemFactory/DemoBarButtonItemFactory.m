//
//  DemoBarButtonItemFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/12.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoBarButtonItemFactory.h"

@implementation DemoBarButtonItemFactory

+ (UIBarButtonItem *)demoDoneBarButtonItemWithSEL:(SEL)sel {
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", nil) style:UIBarButtonItemStylePlain target:self action:sel];
    return doneBarButtonItem;
}

@end
