//
//  DemoUsePermissionModel.h
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoUsePermissionModel : NSObject

@property (nonatomic, assign) BOOL checked;
@property (nonatomic, assign) NSInteger menuId;
@property (nonatomic, copy) NSString *menuName;
@property (nonatomic, assign) NSInteger menuParent;
@property (nonatomic, assign) NSInteger permission;
@property (nonatomic, assign) BOOL rootNode;
@property (nonatomic, copy) NSString *typeInfo;

- (instancetype)initWithPermissionDictionary:(NSDictionary *)permissionDictionary;

@end
