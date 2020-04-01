//
//  SearchBarViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "CJSearchBar.h"
#else
#import <LuckinBaseUIKit/CJSearchBar.h>
#endif

@interface SearchBarViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@end
