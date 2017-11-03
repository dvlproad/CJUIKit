//
//  CJMJRefreshViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/28.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJMJRefreshComponent.h"

@interface CJMJRefreshViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
}

@property(nonatomic, strong) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, assign) NSInteger pageNo;      /**< 当前页码 */
@property(nonatomic, assign) NSInteger pageCount;   /**< 总共多少页 */
@property(nonatomic, assign) NSInteger pageSize;    /**< 每页多少个 */

@end
