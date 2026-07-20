//
//  TSTextFieldOffsetViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "TSTextFieldOffsetViewController.h"
#import "TestTextFieldOffsetTableViewCell.h"

@interface TSTextFieldOffsetViewController ()

@end

@implementation TSTextFieldOffsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;  //视图滚动时候自动收起键盘
    [tableView registerClass:[TestTextFieldOffsetTableViewCell class] forCellReuseIdentifier:@"TestTextFieldOffsetTableViewCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试CJTextFieldOffset";
        {
            CQDMModuleModel *tfModule = [[CQDMModuleModel alloc] init];
            tfModule.title = @"测试<CJTextFieldOffset>的加减(请输入内容仔细观察文字头尾是否被遮盖)";
            
            [sectionDataModel.values addObject:tfModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CQDMModuleModel *tfModule = [dataModels objectAtIndex:indexPath.row];
    
    TestTextFieldOffsetTableViewCell *cell = (TestTextFieldOffsetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TestTextFieldOffsetTableViewCell" forIndexPath:indexPath];
    cell.changeExplainLabel.text = tfModule.title;
    
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
