//
//  CQTSManualBaseTestMethodViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "CQTSManualBaseTestMethodViewController.h"
#import "TestValueChangeTableViewCell.h"

@interface CQTSManualBaseTestMethodViewController () 

@end

@implementation CQTSManualBaseTestMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;  //视图滚动时候自动收起键盘
    [tableView registerClass:[TestValueChangeTableViewCell class] forCellReuseIdentifier:@"TestValueChangeTableViewCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
}
#pragma mark - Lazy
- (NSMutableArray<CQDMSectionDataModel *> *)sectionDataModels {
    if (_sectionDataModels == nil) {
        _sectionDataModels = [[NSMutableArray alloc] init];
    }
    return _sectionDataModels;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CQTSManualTestMethodModel *valueChangeModel = [dataModels objectAtIndex:indexPath.row];
    
    TestValueChangeTableViewCell *cell = (TestValueChangeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TestValueChangeTableViewCell" forIndexPath:indexPath];
    cell.valueChangeModel = valueChangeModel;
    
    return cell;
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
