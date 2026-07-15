//
//  NSCalendarCJHelperViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"
#import <CQDemoKit/CQDMSectionDataModel.h>   //在CJDataUtil中

@interface NSCalendarCJHelperViewController : CJUIKitBaseViewController <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;

@end
