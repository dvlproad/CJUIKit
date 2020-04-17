//
//  CJSearchBarDelegate.m
//  CJUIKitDemo
//
//  Created by lcQian on 2020/4/17.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJSearchBarDelegate.h"

@interface CJSearchBarDelegate ()

@property (nonatomic, copy) void(^textChangeBlock)(UISearchBar *searchBar, NSString *searchText);

@end

@implementation CJSearchBarDelegate

- (instancetype)initWithTextDidChange:(void(^)(UISearchBar *searchBar, NSString *searchText))textChangeBlock {
    self = [super init];
    if (self) {
        _textChangeBlock = textChangeBlock;
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

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.textChangeBlock) {
        self.textChangeBlock(searchBar, searchText);
    }
}

@end
