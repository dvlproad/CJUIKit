//
//  UISearchBar+CJAddInputAccessoryView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/10/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJDefaultToolbar.h"

@interface UISearchBar (CJAddInputAccessoryView)

- (void)addDefaultInputAccessoryViewWithDoneButtonClickBlock:(void (^)(UISearchBar *searchBar))doneButtonClickBlock;

@end
