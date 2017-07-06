//
//  TableViewController.h
//  CJUIKitDemo
//
//  Created by lichaoqian on 2017/7/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
