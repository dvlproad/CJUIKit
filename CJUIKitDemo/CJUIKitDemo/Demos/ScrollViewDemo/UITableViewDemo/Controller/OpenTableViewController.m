//
//  OpenTableViewController.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "OpenTableViewController.h"
#import "TestDataUtil.h"

#define kHeadTableViewCount 5
#define kSubTableViewCount  6
#define kHeadTableViewHeight 50
#define kSubTableViewHeight 50

@interface OpenTableViewController ()

@end

@implementation OpenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"OpenTableViewController", nil);
    
    self.sectionModels = [TestDataUtil getTestSectionDataModels];
    
    section_old = -1;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"TableViewHeader"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    
    
    //封装的openTableView
    [self.openTableView registerNib:[UINib nibWithNibName:@"TableViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"TableViewHeader"];
    [self.openTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.openTableView.sectionModels = self.sectionModels;
    [self.openTableView configureHeaderBlock:^(TableViewHeader *header, NSInteger section) {
        MySectionModel *sectionDataModel = [self.sectionModels objectAtIndex:section];
        
        header.tilteLabel.backgroundColor = [UIColor cyanColor];
        header.tilteLabel.text = sectionDataModel.theme;
        
    } configureCellBlock:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        MySectionModel *sectionDataModel = [self.sectionModels objectAtIndex:indexPath.section];
        TestDataModel *dataModel = [sectionDataModel.values objectAtIndex:indexPath.row];
        
        cell.textLabel.text = dataModel.name;
        
    } didSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"点击%ld-%ld", indexPath.section, indexPath.row);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionModels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MySectionModel *sectionDataModel = [self.sectionModels objectAtIndex:section];
    NSInteger rowCount = [sectionDataModel.values count];
    
    return sectionDataModel.isSelected ? rowCount : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MySectionModel *sectionDataModel = [self.sectionModels objectAtIndex:section];
    
    TableViewHeader *header = (TableViewHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TableViewHeader"];
    header.belongToSection = section;
    __weak typeof(self)weakSelf = self;
    [header setTapHandle:^(NSInteger section) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf tapHeaderAtSection:section];
        }
    }];
    
    header.tilteLabel.backgroundColor = [UIColor cyanColor];
    header.tilteLabel.text = sectionDataModel.theme;
    
    return header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MySectionModel *sectionDataModel = [self.sectionModels objectAtIndex:indexPath.section];
    TestDataModel *dataModel = [sectionDataModel.values objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = dataModel.name;
    
    return cell;
}

#pragma mark - TableViewHeaderBlock
/**
 *  点击了第几个Header
 *
 *  @param section section
 */
- (void)tapHeaderAtSection:(NSInteger)section {
    MySectionModel *secctionModel = [self.sectionModels objectAtIndex:section];
    secctionModel.selected = !secctionModel.isSelected;
    
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
