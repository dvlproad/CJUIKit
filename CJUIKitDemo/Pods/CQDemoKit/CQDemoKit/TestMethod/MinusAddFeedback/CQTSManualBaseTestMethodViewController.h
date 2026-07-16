//
//  CQTSManualBaseTestMethodViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//
//  本视图介绍：中间是文本框，左侧"-"按钮，右侧"+"按钮 ，下面是方法执行结果的 的方法列表测试视图（常用于时间加减、数值加减)

#import "CJUIKitBaseViewController.h"
#import "CQDMSectionDataModel.h"
#import "CQTSManualTestMethodModel.h"

@interface CQTSManualBaseTestMethodViewController : CJUIKitBaseViewController <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;

@end
