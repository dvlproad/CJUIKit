//
//  NSCalendarCJHelperViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"
#import <CJBaseUtil/CJSectionDataModel.h>   //在CJDataUtil中

#ifdef TEST_CJBASEHELPER_POD
#import "NSCalendarCJHelper.h"
#else
#import <CJBaseHelper/NSCalendarCJHelper.h>
#endif


@interface NSCalendarCJHelperViewController : CJUIKitBaseViewController <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *sectionDataModels;

@end
