//
//  CJUIKitBaseTextViewController.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"
#import "CQDMSectionDataModel.h"
#import "CQDMSectionDataModel+CJDealTextModel.h"

@interface CJUIKitBaseTextViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;


@end
