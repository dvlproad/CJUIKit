//
//  OpenTableViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TableViewHeader.h"
#import "MySectionModel.h"

#import "MyOpenTableView.h"


//实际只需采用CJTableViewHeaderFooterView和MySectionModel即可实现
@interface OpenTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSInteger section_old;
    
}
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<MySectionModel *> *sectionModels;

@property (nonatomic, strong) IBOutlet MyOpenTableView *openTableView;

@end
