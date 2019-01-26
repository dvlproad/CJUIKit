//
//  SearchTableViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2016/11/21.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "SearchTableViewController.h"
#import "TestDataUtil.h"

#ifdef TEST_CJCOMPLEXUIKIT_POD
#import "CJDataAllUtil.h"
#else
#import <CJBaseUtil/CJDataAllUtil.h>
#endif


#import "CJPinyinHelper.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.searchController.hidesNavigationBarDuringPresentation = NO;//搜索的时候是否遮挡导航栏
    
    UISearchBar *searchBar = self.tableView.searchController.searchBar;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.tintColor = [UIColor colorWithRed:105/255.0 green:193/255.0 blue:243/255.0 alpha:1]; //Cancel文字的颜色 #69c1f3
    
    self.tableView.cellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        TestDataModel *dataModel = (TestDataModel *)[(CJSearchTableView *)tableView getDataModelAtIndexPath:indexPath];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = dataModel.name;
        
        return cell;
    };
    
    __weak typeof(self)weakSelf = self;
    self.tableView.searchOperationBlock = ^NSMutableArray<CJSectionDataModel *> *(NSString *searchText) {
        NSArray *searchInSectionDataModels = weakSelf.tableView.originSectionDataModels;
        SEL dataModelSearchSelector = @selector(name);
        
        NSMutableArray *resultSectionDataModels =
        [CJDataUtil searchText:searchText
           inSectionDataModels:searchInSectionDataModels
       dataModelSearchSelector:dataModelSearchSelector
                withSearchType:CJSearchTypeFull
                 supportPinyin:YES
         pinyinFromStringBlock:^NSString *(NSString *string) {
             return [CJPinyinHelper pinyinFromChineseString:string];
         }];
        return resultSectionDataModels;
    };
    //self.showTableViewSectionHeader = NO;
    
    [self getMyOriginSectionDataModels];
}

- (void)getMyOriginSectionDataModels {
    self.tableView.originSectionDataModels = [TestDataUtil getTestSectionDataModels];
    [self.tableView reloadData];
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
