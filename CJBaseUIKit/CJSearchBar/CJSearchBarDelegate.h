//
//  CJSearchBarDelegate.h
//  CJUIKitDemo
//
//  Created by lcQian on 2020/4/17.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJSearchBarDelegate : NSObject <UISearchBarDelegate> {
    
}

- (instancetype)initWithTextDidChange:(void(^)(UISearchBar *searchBar, NSString *searchText))textChangeBlock;

@end

NS_ASSUME_NONNULL_END
