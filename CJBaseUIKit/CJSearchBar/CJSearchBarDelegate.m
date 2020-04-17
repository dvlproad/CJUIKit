//
//  CJSearchBarDelegate.m
//  CJUIKitDemo
//
//  Created by lcQian on 2020/4/17.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJSearchBarDelegate.h"

@implementation CJSearchBarDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

@end
