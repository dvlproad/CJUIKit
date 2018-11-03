//
//  ReuseDataSourceTableViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ReuseDataSourceTableViewController.h"

#import "CJDefaultTableViewCell+ConfigureForDataModel.h"

#import "CJSingleTableViewCellDataSource2.h"

#import "TestDataUtil.h"

static NSString * const CJDefaultTableViewCellIdentifier = @"CJDefaultTableViewCell";

@interface ReuseDataSourceTableViewController () <UITableViewDelegate> {
    
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) CJSingleTableViewCellDataSource2 *tableViewDataSource;//必须是strong，防止被释放

@end

@implementation ReuseDataSourceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"ReuseDataSource Demo";
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /* ①、注册tableView所需的cell */
    [self.tableView registerClass:[CJDefaultTableViewCell class]
           forCellReuseIdentifier:CJDefaultTableViewCellIdentifier];
    
    /* ②、设置tableView的数据源dataSource及其他协议等 */
    NSString *cellIdentifier = CJDefaultTableViewCellIdentifier;
    TableViewCellConfigureBlock cellConfigureBlock = ^(CJDefaultTableViewCell *cell, TestDataModel *dataModel) {
        [cell configureForDataModel:dataModel];
    };
    
    self.datas = [TestDataUtil testDataForDemoTableViewController];
    self.tableViewDataSource =
    [[CJSingleTableViewCellDataSource2 alloc] initWithDatas:self.datas
                                             cellIdentifier:cellIdentifier
                                         cellConfigureBlock:cellConfigureBlock];
    self.tableView.dataSource = self.tableViewDataSource;
    
    /* ③、初始化tableView的delegate */
    self.tableView.delegate = self;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了 %ld-%ld", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TestDataModel *dataModel = [self.tableViewDataSource dataModelAtIndexPath:indexPath];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor lightGrayColor];
    viewController.title = dataModel.name;
    
    [self.navigationController pushViewController:viewController animated:YES];
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
