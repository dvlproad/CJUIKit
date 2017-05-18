//
//  NavigationBarBaseViewController.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/4/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+CJChangeBG.h"

#import "SmallScaleHeadView.h"

@interface NavigationBarBaseViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CJScaleHeadView *scaleHeadView;

/**
 *  添加顶部视图
 *
 *  @param attachNavigationBar  滚动视图是否会依附在导航栏上
 *  @param canPullSmall         所添加的view是否同时支持上推缩小
 */
- (void)addTableScaleHeaderViewWithAttachNavigationBar:(BOOL)attachNavigationBar supportPullSmall:(BOOL)canPullSmall;

@end
