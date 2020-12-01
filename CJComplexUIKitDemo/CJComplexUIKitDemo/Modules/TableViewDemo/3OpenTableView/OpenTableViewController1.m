//
//  OpenTableViewController1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "OpenTableViewController1.h"
#import "TestDataUtil.h"

@interface OpenTableViewController1 ()

@end

@implementation OpenTableViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"OpenTableViewController1", nil);
    
    self.sectionModels = [TestDataUtil getTestSectionDataModels];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"TableViewHeader"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionModels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionModels objectAtIndex:section];
    NSInteger rowCount = [sectionDataModel.values count];
    
    return sectionDataModel.isSelected ? rowCount : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionModels objectAtIndex:section];
    
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
    CQDMSectionDataModel *sectionDataModel = [self.sectionModels objectAtIndex:indexPath.section];
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
    CQDMSectionDataModel *secctionModel = [self.sectionModels objectAtIndex:section];
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
