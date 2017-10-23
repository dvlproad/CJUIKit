//
//  SvDemo_Refresh.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 9/24/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "SvDemo_Refresh.h"
#import "CJMJRefreshComponent.h"

@interface SvDemo_Refresh ()

@end

@implementation SvDemo_Refresh

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CJMJRefreshNormalHeader *header = [CJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新。。。。");
        sleep(1);
        [self.scrollView.mj_header endRefreshing];
    }];
    self.scrollView.mj_header = header;
    
    CJMJRefreshNormalFooter *footer = [CJMJRefreshNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉加载。。。。");
        sleep(1);
        
        BOOL loadAllDataFinish = NO;   //是否已加载完全部数据(即所有分页)
        if (!loadAllDataFinish) {
            [self.scrollView.mj_footer resetNoMoreData];
        } else {
            [self.scrollView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    self.scrollView.mj_footer = footer;
    
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
