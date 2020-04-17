//
//  TSSearchBarFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/4/17.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "CJSearchBar.h"
#else
#import <CJBaseUIKit/CJSearchBar.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TSSearchBarFactory : NSObject

/// 搜索栏
+ (CJSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
