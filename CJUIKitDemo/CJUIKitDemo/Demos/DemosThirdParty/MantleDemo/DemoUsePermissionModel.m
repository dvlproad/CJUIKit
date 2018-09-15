//
//  DemoUsePermissionModel.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DemoUsePermissionModel.h"

@implementation DemoUsePermissionModel


- (instancetype)initWithPermissionDictionary:(NSDictionary *)permissionDictionary {
    self = [super init];
    if (self) {
        self.checked = permissionDictionary[@"checked"];
        self.menuId = [permissionDictionary[@"menuId"] integerValue];
        self.menuName = permissionDictionary[@"menuName"];
        self.menuParent = [permissionDictionary[@"menuParent"] integerValue];
        self.permission = [permissionDictionary[@"permission"] integerValue];
        self.rootNode = [permissionDictionary[@"rootNode"] integerValue];
        self.typeInfo = permissionDictionary[@"typeInfo"];
    }
    
    return self;
}

@end
