//
//  BaseRefreshViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/28.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseRefreshViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
}

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, assign) NSInteger pageNo;      /**< 当前页码 */
@property(nonatomic, assign) NSInteger pageCount;   /**< 总共多少页 */
@property(nonatomic, assign) NSInteger pageSize;    /**< 每页多少个 */

- (void)loadNewData;

- (void)loadMoreData;

@end
