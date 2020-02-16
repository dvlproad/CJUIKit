//
//  JSONRefreshViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/28.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "JSONRefreshViewController.h"

@implementation JSONRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __weak typeof(self)weakSelf = self;
    CJRefreshJSONHeader *header = [CJRefreshJSONHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.tableView.mj_header = header;
    
    CJRefreshJSONFooter *footer = [CJRefreshJSONFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    self.tableView.mj_footer = footer;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
