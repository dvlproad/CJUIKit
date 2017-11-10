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
        //NSLog(@"maxDataModelShowCount = %ld", self.maxDataModelShowCount);
    }
    return self;
}


- (BOOL)isExtraItemIndexPath:(NSIndexPath *)indexPath dataModels:(NSMutableArray *)dataModels {
    BOOL isExtraItem = NO;
    
    CJExtralItemSetting extralItemSetting = self.extralItemSetting;
    switch (extralItemSetting) {
        case CJExtralItemSettingLeading:
        {
            if (indexPath.row >= 1) {
                isExtraItem = NO;
            } else {
                isExtraItem = YES;
            }
            break;
        }
        case CJExtralItemSettingTailing:
        {
            if (indexPath.row < dataModels.count) {
                isExtraItem = NO;
            } else {
                isExtraItem = YES;
            }
            break;
        }
        case CJExtralItemSettingNone:
        default:
        {
            isExtraItem = NO;
            break;
        }
    }
    
    return isExtraItem;
}

- (NSInteger)getCellCountByDataModels:(NSArray *)dataModels {
    NSInteger dataModelCount = dataModels.count;
    
    CJExtralItemSetting extralItemSetting = self.extralItemSetting;
    switch (extralItemSetting) {
        case CJExtralItemSettingLeading:
        case CJExtralItemSettingTailing:
        {
            if (dataModels.count < self.maxDataModelShowCount) {
                return dataModelCount + 1;
            } else {
                return dataModelCount;
            }
            
            break;
        }
        case CJExtralItemSettingNone:
        default:
        {
            return dataModelCount;
            break;
        }
    }
}

- (id)getDataModelAtIndexPath:(NSIndexPath *)indexPath dataModels:(NSMutableArray *)dataModels {
    id dataModle = nil;
    
    CJExtralItemSetting extralItemSetting = self.extralItemSetting;
    switch (extralItemSetting) {
        case CJExtralItemSettingLeading:
        {
            dataModle = [dataModels objectAtIndex:indexPath.item-1];
            break;
        }
        case CJExtralItemSettingTailing:
        case CJExtralItemSettingNone:
        default:
        {
            dataModle = [dataModels objectAtIndex:indexPath.item];
            break;
        }
    }
    
    return dataModle;
}


@end
