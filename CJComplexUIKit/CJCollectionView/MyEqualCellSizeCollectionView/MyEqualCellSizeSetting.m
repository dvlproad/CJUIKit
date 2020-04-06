//
//  MyEqualCellSizeSetting.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyEqualCellSizeSetting.h"

@implementation MyEqualCellSizeSetting

- (instancetype)init {
    self = [super init];
    if (self) {
        self.extralItemSetting = CJExtralItemSettingNone;
        self.maxDataModelShowCount = NSIntegerMax;
        //NSLog(@"maxDataModelShowCount = %zd", self.maxDataModelShowCount);
        
        
        //flowLayout.headerReferenceSize = CGSizeMake(110, 135);
        _minimumInteritemSpacing = 10;
        _minimumLineSpacing = 15;
        _sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
        _cellWidthFromPerRowMaxShowCount = 4;
        //_cellWidthFromFixedWidth = 50;
        
        //以下值，可选设置
        //_cellHeightFromFixedHeight = 30;
        //_cellHeightFromPerColumnMaxShowCount = 1;
        
        //_maxDataModelShowCount = 5;
        //_extralItemSetting = CJExtralItemSettingLeading;
    }
    return self;
}

@end
