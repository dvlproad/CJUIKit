//
//  ReuseDataSourceTableViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ReuseDataSourceTableViewController.h"
#import <Masonry/Masonry.h>
#import "CJSingleTableViewCellDataSource2.h"

#import "TestDataUtil.h"

@interface ReuseDataSourceTableViewController () <UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionDataModels;
@property (nonatomic, strong) CJSingleTableViewCellDataSource2 *tableViewDataSource;//必须是strong，防止被释放

@end

@implementation ReuseDataSourceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"ReuseDataSource Demo";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /* ①、注册tableView所需的cell */
    NSString *cellIdentifier = @"cell";
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:cellIdentifier];
    
    /* ②、设置tableView的数据源dataSource及其他协议等 */
    void (^cellConfigureCellBlock)(id cell, id dataModel) = ^(UITableViewCell *cell, TestDataModel *dataModel) {
        cell.textLabel.text = dataModel.name;
    };
    
    self.sectionDataModels = [TestDataUtil testDataForDemoTableViewController];
    self.tableViewDataSource =
    [[CJSingleTableViewCellDataSource2 alloc] initWithSectionDataModels:self.sectionDataModels
                                             cellIdentifier:cellIdentifier
                                                      cellConfigureBlock:cellConfigureCellBlock];
    self.tableView.dataSource = self.tableViewDataSource;
    
    /* ③、初始化tableView的delegate */
    self.tableView.delegate = self;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了 %zd-%zd", indexPath.section, indexPath.row);
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
