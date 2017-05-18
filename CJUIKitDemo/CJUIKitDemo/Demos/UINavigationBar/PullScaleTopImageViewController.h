//
//  PullScaleTopImageViewController.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEOHeaderView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kImageHeight 263

@interface PullScaleTopImageViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) LEOHeaderView *headerView;

@end
