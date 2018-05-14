//
//  CJSearchTableView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/21.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSearchTableView.h"

#ifdef CJTESTPOD
    #import "NSOperationQueueUtil.h"
#else
    #import <CJBaseUtil/NSOperationQueueUtil.h>
#endif

@interface CJSearchTableView () <UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>  {
    
}

@end


@implementation CJSearchTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    UITableViewStyle style = UITableViewStylePlain;
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    /* 这里只实现dataSource,不实现delegate */
    self.dataSource = self;
    //self.delegate = self;
    
    UISearchController *searchController = self.searchController;
    self.tableHeaderView = searchController.searchBar;
}

#pragma mark - Getter
- (UISearchController *)searchController {
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;//搜索的时候是否遮挡导航栏
        
        UISearchBar *searchBar = _searchController.searchBar;
        //searchBar.delegate = self;
        //searchBar.searchBarStyle = UISearchBarStyleMinimal;
        //searchBar.tintColor = [UIColor colorWithRed:105/255.0 green:193/255.0 blue:243/255.0 alpha:1]; //Cancel文字的颜色 #69c1f3
        searchBar.placeholder = NSLocalizedString(@"搜索", nil);
        searchBar.returnKeyType = UIReturnKeyDone;
        //searchBar.showsScopeBar = YES;
        //searchBar.scopeButtonTitles = @[@"全部", @"数字", @"扑克牌", @"字母", @"地点桩"];
        //searchBar.selectedScopeButtonIndex = 0;
        searchBar.delegate = self;
        //[searchBar sizeToFit];
    }
    
    return _searchController;
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    NSInteger sectionCount = sectionDataModels.count;
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:section];
    NSMutableArray *dataModels = sectionDataModel.values;
    
    NSInteger cellCount = [dataModels count];
    return cellCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:section];
    
    return sectionDataModel.theme;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellForRowAtIndexPathBlock) {
        return self.cellForRowAtIndexPathBlock(tableView, indexPath);
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        /*
         id dataModel = [self getDataModelAtIndexPath:indexPath];
         
         [cell configureForDataModel:dataModel]; //是否等同于cell.dataModel，哪个好
         */
        cell.textLabel.text = @"暂时未赋值";
        cell.detailTextLabel.text = @"detail";
        
        return cell;
    }
}


//header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.heightForHeaderInSectionBlock) {
        return self.heightForHeaderInSectionBlock(tableView, section);
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.viewForHeaderInSectionBlock) {
        return self.viewForHeaderInSectionBlock(tableView, section);
    } else {
        return nil;
    }
}

//footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.heightForFooterInSectionBlock) {
        return self.heightForFooterInSectionBlock(tableView, section);
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.viewForFooterInSectionBlock) {
        return self.viewForFooterInSectionBlock(tableView, section);
    } else {
        return nil;
    }
}


/* 完整的描述请参见文件头部 */
- (id)getDataModelAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isSearching = self.isSearching;
    NSArray *sectionDataModels = isSearching ? self.resultSectionDataModels : self.originSectionDataModels;
    
    CJSectionDataModel *sectionDataModel = [sectionDataModels objectAtIndex:indexPath.section];
    NSMutableArray *dataModels = sectionDataModel.values;
    
    id dataModle = [dataModels objectAtIndex:indexPath.row];
    
    return dataModle;
}



#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    [self doSearchText:searchString];
}

/*
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self doSearchText:searchString];
    
    return YES;//刷新表格
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
    
    NSOperation *operationLast = [NSBlockOperation blockOperationWithBlock:^{
        //NSLog(@"搜索结果 %@", weakSelf.resultSectionDataModels);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
            if (self.searchResultShowBlock) {
                self.searchResultShowBlock();
            }
        });
    }];
    
    self.searchOperationQueue = [NSOperationQueueUtil createOperationQueueWithOperations:operations lastOperation:operationLast];
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




#pragma mark - addSubView
- (void)cj_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    //left
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:edgeInsets.left]];
    //right
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:edgeInsets.right]];
    //top
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:edgeInsets.top]];
    //bottom
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:edgeInsets.bottom]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
