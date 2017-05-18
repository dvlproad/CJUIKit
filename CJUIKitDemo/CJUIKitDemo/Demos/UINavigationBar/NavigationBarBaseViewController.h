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
 *  @param pullUpMinHeight  在上推缩小的过程中能推到的最小高度
 *  @param canPullSmall     所添加的view是否同时支持上推缩小
 */
- (void)addTableScaleHeaderViewWithPullUpMinHeight:(CGFloat)pullUpMinHeight supportPullSmall:(BOOL)canPullSmall;

@end
