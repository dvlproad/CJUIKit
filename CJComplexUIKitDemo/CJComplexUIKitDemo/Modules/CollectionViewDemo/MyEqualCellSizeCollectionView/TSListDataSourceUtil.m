//
//  TSListDataSourceUtil.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "TSListDataSourceUtil.h"
#import <CQDemoKit/CJUIKitResoucesUtil.h>

@implementation TSListDataSourceUtil

/// 获取测试用的数据
+ (NSMutableArray<CQFilesLookBadgeDataModel *> *)__getTestLookBadgeDataModels {
    NSMutableArray<CQFilesLookBadgeDataModel *> *dataModels = [[NSMutableArray alloc] init];
    {
        CQFilesLookBadgeDataModel *dataModel = [[CQFilesLookBadgeDataModel alloc] init];
        dataModel.name = @"1X透社";
        dataModel.imageUrl = [CJUIKitResoucesUtil cjts_iconImageUrl1];
        dataModel.badgeCount = 0;
        [dataModels addObject:dataModel];
    }
    {
        CQFilesLookBadgeDataModel *dataModel = [[CQFilesLookBadgeDataModel alloc] init];
        dataModel.name = @"2新鲜事";
        dataModel.imageUrl = [CJUIKitResoucesUtil cjts_iconImageUrl2];
        dataModel.badgeCount = 1;
        [dataModels addObject:dataModel];
    }
    {
        CQFilesLookBadgeDataModel *dataModel = [[CQFilesLookBadgeDataModel alloc] init];
        dataModel.name = @"3XX信";
        dataModel.imageUrl = [CJUIKitResoucesUtil cjts_iconImageUrl3];
        [dataModels addObject:dataModel];
    }
    {
        CQFilesLookBadgeDataModel *dataModel = [[CQFilesLookBadgeDataModel alloc] init];
        dataModel.name = @"4X角信";
        dataModel.badgeCount = 9;
        dataModel.imageUrl = [CJUIKitResoucesUtil cjts_iconImageUrl4];
        [dataModels addObject:dataModel];
    }
    {
        CQFilesLookBadgeDataModel *dataModel = [[CQFilesLookBadgeDataModel alloc] init];
        dataModel.name = @"5蓝精灵";
        dataModel.imageUrl = [CJUIKitResoucesUtil cjts_iconImageUrl5];
        dataModel.badgeCount = 10;
        [dataModels addObject:dataModel];
    }
    {
        CQFilesLookBadgeDataModel *dataModel = [[CQFilesLookBadgeDataModel alloc] init];
        dataModel.name = @"6年轻范";
        dataModel.badgeCount = 99;
        dataModel.imageUrl = [CJUIKitResoucesUtil cjts_iconImageUrl6];
        [dataModels addObject:dataModel];
    }
    {
        CQFilesLookBadgeDataModel *dataModel = [[CQFilesLookBadgeDataModel alloc] init];
        dataModel.name = @"7XX福";
        dataModel.imageUrl = [CJUIKitResoucesUtil cjts_iconImageUrl7];
        [dataModels addObject:dataModel];
    }
    {
        CQFilesLookBadgeDataModel *dataModel = [[CQFilesLookBadgeDataModel alloc] init];
        dataModel.name = @"8X之语";
        dataModel.badgeCount = 888;
        dataModel.imageUrl = [CJUIKitResoucesUtil cjts_iconImageUrl8];
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}


+ (NSMutableArray<CJFilesLookDataModel *> *)__getTestDataModels {
    NSMutableArray<CJFilesLookDataModel *> *dataModels = [[NSMutableArray alloc] init];
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"1X透社";
        dataModel.image = [CJUIKitResoucesUtil cjts_image1];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"2新鲜事";
        dataModel.image = [CJUIKitResoucesUtil cjts_image2];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"3XX信";
        dataModel.image = [CJUIKitResoucesUtil cjts_image3];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"4X角信";
        dataModel.image = [CJUIKitResoucesUtil cjts_image4];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"5蓝精灵";
        dataModel.image = [CJUIKitResoucesUtil cjts_image5];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"6年轻范";
        dataModel.image = [CJUIKitResoucesUtil cjts_image6];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"7XX福";
        dataModel.image = [CJUIKitResoucesUtil cjts_image7];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"8X之语";
        dataModel.image = [CJUIKitResoucesUtil cjts_image8];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"9";
        dataModel.image = [CJUIKitResoucesUtil cjts_image9];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"10";
        dataModel.image = [CJUIKitResoucesUtil cjts_image10];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"11";
        dataModel.image = [CJUIKitResoucesUtil cjts_image11];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"12";
        dataModel.image = [CJUIKitResoucesUtil cjts_image12];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"13";
        dataModel.image = [CJUIKitResoucesUtil cjts_image13];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"14";
        dataModel.image = [CJUIKitResoucesUtil cjts_image14];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"15";
        dataModel.image = [CJUIKitResoucesUtil cjts_image15];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"16";
        dataModel.image = [CJUIKitResoucesUtil cjts_image16];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"17";
        dataModel.image = [CJUIKitResoucesUtil cjts_image17];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"18";
        dataModel.image = [CJUIKitResoucesUtil cjts_image18];
        [dataModels addObject:dataModel];
    }
    {
        CJFilesLookDataModel *dataModel = [[CJFilesLookDataModel alloc] init];
        dataModel.title = @"19";
        dataModel.image = [CJUIKitResoucesUtil cjts_image19];
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}


@end
