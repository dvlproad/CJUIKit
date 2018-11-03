//
//  AccuracyStringViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef CJTESTPOD
#import "CJSectionDataModel.h"
#else
#import <CJBaseUtil/CJSectionDataModel.h> //在CJDataUtil中
#endif

@interface AccuracyStringViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionDataModels;

@end
