//
//  TSSearchBarFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/4/17.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "TSSearchBarFactory.h"

@implementation TSSearchBarFactory

/// 搜索栏
+ (CJSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder {
    CJSearchBar *searchBar = [[CJSearchBar alloc] init];
    searchBar.placeholder = placeholder;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;    //不显示背景
    
    return searchBar;
}

@end
