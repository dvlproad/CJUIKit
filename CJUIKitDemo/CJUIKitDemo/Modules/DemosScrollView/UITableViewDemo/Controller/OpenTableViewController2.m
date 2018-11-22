//
//  OpenTableViewController2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "OpenTableViewController2.h"
#import "TestDataUtil.h"

@interface OpenTableViewController2 ()

@end

@implementation OpenTableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"OpenTableViewController2", nil);
    
    self.sectionModels = [TestDataUtil getTestSectionDataModels];
    
    
    //封装的openTableView
    [self.openTableView registerNib:[UINib nibWithNibName:@"TableViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"TableViewHeader"];
    [self.openTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.openTableView.sectionModels = self.sectionModels;
    [self.openTableView configureHeaderBlock:^(TableViewHeader *header, NSInteger section) {
        CJSectionDataModel *sectionDataModel = [self.sectionModels objectAtIndex:section];
        
        header.tilteLabel.backgroundColor = [UIColor cyanColor];
        header.tilteLabel.text = sectionDataModel.theme;
        
    } configureCellBlock:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        CJSectionDataModel *sectionDataModel = [self.sectionModels objectAtIndex:indexPath.section];
        TestDataModel *dataModel = [sectionDataModel.values objectAtIndex:indexPath.row];
        
        cell.textLabel.text = dataModel.name;
        
    } didSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"点击%zd-%zd", indexPath.section, indexPath.row);
    }];
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
