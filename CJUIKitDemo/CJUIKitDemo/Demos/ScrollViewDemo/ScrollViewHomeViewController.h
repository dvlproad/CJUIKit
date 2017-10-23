//
//  ScrollViewHomeViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewHomeViewController : UIViewController {
    
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSArray *> *datas;
@property (nonatomic, strong) NSMutableArray<NSString *> *indexTitles;

@end
