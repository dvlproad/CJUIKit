//
//  BaseRefreshViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/28.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BaseRefreshViewController.h"
#import <MJRefresh/MJRefresh.h>

typedef void ((^CJRequestSuccess)(id responseObject));
typedef void ((^CJRequestFailure)(NSError *error));

@interface BaseRefreshViewController () {
    
}
@property (nonatomic, strong) id request;

@end

@implementation BaseRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    
    self.pageCount = 4;
    self.pageSize = 3;
    
    self.datas = [[NSMutableArray alloc] init];
}

- (void)loadNewData {
    self.pageNo = 1;
    
    [self getDataFromRequest:self.request withIsLoadNewData:YES];
}

- (void)loadMoreData {
    self.pageNo ++;
    
    [self getDataFromRequest:self.request withIsLoadNewData:NO];
}


- (void)getDataFromRequest:(id)request withIsLoadNewData:(BOOL)isLoadNewData {
    __weak typeof(self)weakSelf = self;
    CJRequestSuccess success = ^(id responseObject) {
        if (isLoadNewData) {
            [weakSelf.datas removeAllObjects];
        }
        
        NSMutableArray *newDatas = [[NSMutableArray alloc] init];
        if (self.pageNo < self.pageCount) {
            for (NSInteger i = 0; i < self.pageSize; i++) {
                [newDatas addObject:[NSString stringWithFormat:@"更多数据%d", arc4random()%100]];
            }
        } else {
            //无数据
        }
        
        
        //处理之前的数据加上现在的数据
        if (newDatas.count > 0) {
            [weakSelf.datas addObjectsFromArray:newDatas];
            
            [weakSelf.tableView.mj_footer resetNoMoreData];
            [weakSelf.tableView.mj_footer endRefreshing];
            
        } else {
            //[weakSelf.tableView setEmptyView];//待实现
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        NSLog(@"self.datas = %@", weakSelf.datas);
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    };
    
    
    CJRequestFailure failure = ^(NSError *error) {
        //[weakSelf.tableView setRequestFaildView]; //待实现
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    };
    
    [self requestForData:request success:success failure:failure];
}

- (void)requestForData:(id)request success:(CJRequestSuccess)success failure:(CJRequestFailure)failure {
    //do request
    BOOL requestSuccess = YES;
    if (requestSuccess) {
        id responseObject = nil;
        
        if (success) {
            success(responseObject);
        }
        
    } else {
        NSError *error = nil;
        
        if (failure) {
            failure(error);
        }
    }
}



#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dataModel = [self.datas objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row <= self.datas.count-1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@____来自page%ld", dataModel, self.pageNo+1];
    }else{
        cell.textLabel.text = @"error";
    }
    
    
    return cell;
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
