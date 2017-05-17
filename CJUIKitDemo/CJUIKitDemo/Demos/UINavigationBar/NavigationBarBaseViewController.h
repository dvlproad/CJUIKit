//
//  NavigationBarBaseViewController.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/4/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIScrollView+CJAddScaleHead.h"

@interface NavigationBarBaseViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
