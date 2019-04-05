//
//  TestTextFieldOffsetViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "TestTextFieldOffsetViewController.h"
#import "TestTextFieldOffsetTableViewCell.h"

@interface TestTextFieldOffsetViewController ()

@end

@implementation TestTextFieldOffsetViewController

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
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试CJTextFieldOffset";
        {
            TestValueChangeModel *valueChangeModel = [self textFieldOffsetValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<CJTextFieldOffset>的加减" minusHandle:^id(id oldValue) {
                CGFloat newOffset = [(NSNumber *)oldValue floatValue] - 1;
                return [NSNumber numberWithFloat:newOffset];
            } addHandle:^id(id oldValue) {
                CGFloat newOffset = [(NSNumber *)oldValue floatValue] + 1;
                return [NSNumber numberWithFloat:newOffset];
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

- (TestValueChangeModel *)textFieldOffsetValueChangeModel {
    TestValueChangeModel *valueChangeModel = [[TestValueChangeModel alloc] initWithValue:@(10.0f) textFromValueBlock:^NSString *(id value) {
        NSString *string = [(NSNumber *)value stringValue];
        return string;
    } valueFromTextBlock:^id(NSString *string) {
        CGFloat leftViewOffset = [string floatValue];
        return [NSNumber numberWithFloat:leftViewOffset];
    }];
    return valueChangeModel;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    TestValueChangeModel *valueChangeModel = [dataModels objectAtIndex:indexPath.row];
    
    TestTextFieldOffsetTableViewCell *cell = (TestTextFieldOffsetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TestTextFieldOffsetTableViewCell" forIndexPath:indexPath];
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
