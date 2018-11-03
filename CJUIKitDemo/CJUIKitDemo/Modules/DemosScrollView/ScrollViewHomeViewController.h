//
//  ScrollViewHomeViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"

@interface ScrollViewHomeViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *sectionDataModels;

@end
