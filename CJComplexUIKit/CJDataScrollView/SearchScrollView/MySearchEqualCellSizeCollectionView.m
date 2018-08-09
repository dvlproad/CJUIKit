//
//  MySearchEqualCellSizeCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/4/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "MySearchEqualCellSizeCollectionView.h"

@interface MySearchEqualCellSizeCollectionView () <UICollectionViewDataSource, UISearchBarDelegate> {
    
}

@end



@implementation MySearchEqualCellSizeCollectionView

- (void)commonInit {
    [super commonInit];
    
    /*
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    self.searchController = searchController;
    UISearchBar *searchBar = searchController.searchBar;
    */
    
    UISearchBar *searchBar = self.searchBar;
    searchBar.delegate = self;
//    [searchBar sizeToFit];
    
    self.dataSource = self;
}

- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.searchBarStyle = UISearchBarStyleMinimal;
        searchBar.tintColor = [UIColor colorWithRed:105/255.0 green:193/255.0 blue:243/255.0 alpha:1]; //#69c1f3
        searchBar.placeholder = NSLocalizedString(@"搜索", nil);
        searchBar.returnKeyType = UIReturnKeyDone;
        //searchBar.showsScopeBar = YES;
        //searchBar.scopeButtonTitles = @[@"全部", @"数字", @"扑克牌", @"字母", @"地点桩"];
        //searchBar.selectedScopeButtonIndex = 0;
        
        _searchBar = searchBar;
    }
    
    return _searchBar;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    NSInteger sectionCount = sectionDataModels.count;
    return sectionCount;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:section];
    NSMutableArray *dataModels = sectionDataModel.values;
    
    NSInteger cellCount = [self.equalCellSizeSetting getCellCountByDataModels:dataModels];
    return cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                     cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(self.configureCellBlock != nil, @"未设置configureCellBlock");
    return self.configureCellBlock(collectionView, indexPath);
}

/* 完整的描述请参见文件头部 */
- (id)getDataModelAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:indexPath.section];
    NSMutableArray *dataModels = sectionDataModel.values;
    
    id dataModle = [self.equalCellSizeSetting getDataModelAtIndexPath:indexPath dataModels:dataModels];
    
    return dataModle;
}


#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _isSearching = NO;
    searchBar.showsCancelButton = NO;
    
    [self reloadData];
    
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    if (self.searchBarResignFirstResponderBlock) {
        self.searchBarResignFirstResponderBlock();
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (self.searchBarResignFirstResponderBlock) {
        self.searchBarResignFirstResponderBlock();
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    _isSearching = YES;
    searchBar.showsCancelButton = YES;
    
    if (self.searchBarBecomeFirstResponderBlock) {
        self.searchBarBecomeFirstResponderBlock();
    }
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    _isSearching = NO;
    searchBar.showsCancelButton = NO;
    
    if (self.searchBarResignFirstResponderBlock) {
        self.searchBarResignFirstResponderBlock();
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self doSearchText:searchText];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    if (self.searchBarSelectedScopeButtonIndexDidChangeBlock) {
        self.searchBarSelectedScopeButtonIndexDidChangeBlock(selectedScope);
    }
    
    NSString *searchText = searchBar.text;
    [self doSearchText:searchText];
    
    [searchBar resignFirstResponder];
}


/*
#pragma mark - searchController delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    [self doSearchText:searchText];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}
*/


#pragma mark - 搜索功能实现
- (void)doSearchText:(NSString *)searchText {
    __weak typeof(self)weakSelf = self;
    
    NSAssert(self.searchOperationBlock != nil, @"self.searchOperationBlock 不能为空");
    NSOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        weakSelf.resultSectionDataModels = self.searchOperationBlock(searchText);
        //weakSelf.resultSectionDataModels = [CJSearchUtil searchText:searchText inSectionDataModels:weakSelf.originSectionDataModels dataModelSearchSelector:weakSelf.dataModelSearchSelector supportPinyin:YES];
    }];
    NSArray *operations = @[operation1];

    NSOperation *lastOperation = [NSBlockOperation blockOperationWithBlock:^{
    //NSLog(@"搜索结果 %@", weakSelf.resultSectionDataModels);

        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
            if (self.searchResultShowBlock) {
                self.searchResultShowBlock();
            }
        });
    }];

    NSOperationQueue *searchOperationQueue = [[NSOperationQueue alloc] init];
    searchOperationQueue.name = @"this is a searchOperationQueue";
    for (NSBlockOperation *operation in operations) {
        [searchOperationQueue addOperation:operation];
        [lastOperation addDependency:operation];
    }
    [searchOperationQueue addOperation:lastOperation];
    
    self.searchOperationQueue = searchOperationQueue;
}


@end
