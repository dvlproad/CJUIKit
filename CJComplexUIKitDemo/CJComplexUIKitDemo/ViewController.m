//
//  ViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "ViewController.h"
#import "CJRefreshComponent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //CJRefresh 的使用示例
    // 上拉加载
//    CJRefreshFooter *_refreshFooter = [CJRefreshFooter refreshView];
//    [_refreshFooter addToScrollView:self.tableView];
//    __weak typeof(self)weakSelf = self;
//    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
//    _refreshFooter.beginRefreshingOperation = ^() {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf creatModelsWithCount:10];
//            [weakSelf.tableView reloadData];
//            [weakRefreshFooter endRefreshing];
//        });
//    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
