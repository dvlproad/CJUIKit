//
//  TestDataUtil.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "TestDataUtil.h"

@implementation TestDataUtil

+ (NSMutableArray<TestDataModel *> *)getTestDataModels {
    NSArray *imageNames =
    @[@"alipay_r",  @"bitcoin_r",   @"dianpin_r",   @"douban_r",    @"dribbble_r",
      @"dropbox_r", @"email_r",     @"evernote_r",  @"facebook_r",  @"google-plus_r",
      @"instagram_r",@"instapaper_r",@"line_r",     @"linkedin_r",  @"path_r",
      @"snapchat_r",@"path_r",      @"snapchat_r",  @"pinterest_r", @"pocket_r",
      @"qq_r",      @"quora_r",     @"qzone_r",     @"readability_r",@"reddit_r",
      @"path_r",    @"snapchat_r",  @"pinterest_r", @"pocket_r",    @"qq_r",
      @"quora_r",   @"qzone_r",     @"readability_r",@"reddit_r"];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 34; i++) {
        TestDataModel *cellModel = [[TestDataModel alloc]init];
        cellModel.name = [NSString stringWithFormat:@"%02ld", i];
        cellModel.imagePath = [imageNames objectAtIndex:i];
        [values addObject:cellModel];
    }
    
    return values;
}

/** 完整的描述请参见文件头部 */
+ (NSMutableArray<CJSectionDataModel *> *)getTestSectionDataModels {
    CJSectionDataModel *secctionModel1 = [[CJSectionDataModel alloc] init];
    secctionModel1.theme = @"A区";
    secctionModel1.values = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 5; i++) {
        TestDataModel *cellModel = [[TestDataModel alloc]init];
        cellModel.name = [NSString stringWithFormat:@"%ld", 10+i];
        [secctionModel1.values addObject:cellModel];
    }
    secctionModel1.selected = YES;
    
    
    CJSectionDataModel *secctionModel2 = [[CJSectionDataModel alloc]init];
    secctionModel2.theme = @"B区";
    secctionModel2.values = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 3; i++) {
        TestDataModel *cellModel = [[TestDataModel alloc]init];
        cellModel.name = [NSString stringWithFormat:@"%ld", 20+i];
        [secctionModel2.values addObject:cellModel];
    }
    secctionModel2.selected = YES;
    
    CJSectionDataModel *secctionModel3 = [[CJSectionDataModel alloc]init];
    secctionModel3.theme = @"C区";
    secctionModel3.values = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 4; i++) {
        TestDataModel *cellModel = [[TestDataModel alloc]init];
        cellModel.name = [NSString stringWithFormat:@"%ld", 30+i];
        [secctionModel3.values addObject:cellModel];
    }
    secctionModel3.selected = YES;
    
    NSMutableArray *secctionModels = [NSMutableArray arrayWithArray:@[secctionModel1, secctionModel2, secctionModel3]];
    return secctionModels;
}

/** 完整的描述请参见文件头部 */
+ (NSMutableArray<CJSectionDataModel *> *)testDataForDemoTableViewController {
    //secctionModel1
    CJSectionDataModel *secctionModel1 = [[CJSectionDataModel alloc] init];
    secctionModel1.theme = @"A：CJDefaultTableViewCell";
    secctionModel1.values = [[NSMutableArray alloc]init];
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"00";
        dataModel.nickname = @"DefaultTableViewCell";
        [secctionModel1.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"01";
        dataModel.nickname = @"1111";
        [secctionModel1.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"02";
        dataModel.nickname = @"1111";
        [secctionModel1.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"03";
        dataModel.nickname = @"1111";
        [secctionModel1.values addObject:dataModel];
    }
    
    //secctionModel2
    CJSectionDataModel *secctionModel2 = [[CJSectionDataModel alloc] init];
    secctionModel2.theme = @"B：CJSubTitleTabelViewCell";
    secctionModel2.values = [[NSMutableArray alloc]init];
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"10";
        dataModel.nickname = @"1111";
        [secctionModel2.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"11";
        dataModel.nickname = @"1111";
        [secctionModel2.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"12";
        dataModel.nickname = @"1111";
        [secctionModel2.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"13";
        dataModel.nickname = @"1111";
        [secctionModel2.values addObject:dataModel];
    }
    
    //secctionModel3
    CJSectionDataModel *secctionModel3 = [[CJSectionDataModel alloc] init];
    secctionModel3.theme = @"C：CJRightDetailTableViewCell";
    secctionModel3.values = [[NSMutableArray alloc]init];
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"20";
        dataModel.nickname = @"1111";
        [secctionModel3.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"21";
        dataModel.nickname = @"1111";
        [secctionModel3.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"22";
        dataModel.nickname = @"1111";
        [secctionModel3.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"23";
        dataModel.nickname = @"1111";
        [secctionModel3.values addObject:dataModel];
    }
    
    //secctionModel4
    CJSectionDataModel *secctionModel4 = [[CJSectionDataModel alloc] init];
    secctionModel4.theme = @"D：CJLeftDetailTableViewCell";
    secctionModel4.values = [[NSMutableArray alloc]init];
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"30";
        dataModel.nickname = @"1111";
        [secctionModel4.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"31";
        dataModel.nickname = @"1111";
        [secctionModel4.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"32";
        dataModel.nickname = @"1111";
        [secctionModel4.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"33";
        dataModel.nickname = @"1111";
        [secctionModel4.values addObject:dataModel];
    }
    
    //secctionModel5
    CJSectionDataModel *secctionModel5 = [[CJSectionDataModel alloc] init];
    secctionModel5.theme = @"E：CustomTableViewCell";
    secctionModel5.values = [[NSMutableArray alloc]init];
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"40";
        dataModel.nickname = @"1111";
        [secctionModel5.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"41";
        dataModel.nickname = @"1111";
        [secctionModel5.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"42";
        dataModel.nickname = @"1111";
        [secctionModel5.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"43";
        dataModel.nickname = @"1111";
        [secctionModel5.values addObject:dataModel];
    }
    
    
    //secctionModel6
    CJSectionDataModel *secctionModel6 = [[CJSectionDataModel alloc] init];
    secctionModel6.theme = @"F：SystemTableViewCell";
    secctionModel6.values = [[NSMutableArray alloc]init];
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"50";
        dataModel.nickname = @"1111";
        [secctionModel6.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"51";
        dataModel.nickname = @"1111";
        [secctionModel6.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"52";
        dataModel.nickname = @"1111";
        [secctionModel6.values addObject:dataModel];
    }
    
    {
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.name = @"53";
        dataModel.nickname = @"1111";
        [secctionModel6.values addObject:dataModel];
    }
    
    NSMutableArray *secctionModels = [NSMutableArray arrayWithObjects:secctionModel1, secctionModel2, secctionModel3, secctionModel4, secctionModel5, secctionModel6, nil];
    return secctionModels;
}

@end
