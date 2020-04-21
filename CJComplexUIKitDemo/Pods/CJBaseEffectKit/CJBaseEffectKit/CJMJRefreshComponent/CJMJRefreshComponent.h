//
//  CJMJRefreshComponent.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/10.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#ifndef CJMJRefreshComponent_h
#define CJMJRefreshComponent_h

//依赖MJRefresh
#import "CJMJRefreshNormalHeader.h"
#import "CJMJRefreshNormalFooter.h"

/*
 header有以下状态
 ①[self.tableView.header endRefreshing]; //结束刷新状态
 
 footer有以下状态
 ①[self.tableView.footer endRefreshing]; //结束刷新状态
 ②[self.tableView.footer noticeNoMoreData];//变为没有更多数据的状态（此时也结束了刷新的状态了）
 所以要想在下拉刷新之后，可以重新变成有更多数据需要进行如下设置
 [self.tableView.footer resetNoMoreData];
 */

/*
//可带动画的刷新动作（其实都是执行刷新的接口，这里假设刷新的接口是[self loadNewData],与其对应的还有一个loadMoreData）
- (void)refreshHeaderWithAnimated:(BOOL)animated {
    if (animated) {
        [self.tableView.mj_header beginRefreshing]; //会自动调用[self loadNewData];
    } else {
        [self refreshData]; //调用[self loadNewData];
    }
}
*/


#endif /* CJMJRefreshComponent_h */
