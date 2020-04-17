//
//  CJSearchBar.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJSearchBar : UISearchBar {
    
}

/*
*  初始化搜索栏
*
*  @param textChangeBlock 搜索栏文本改变时的回调
*
*  @return 搜索栏
*/
- (instancetype)initWithTextDidChange:(void(^)(UISearchBar *searchBar, NSString *searchText))textChangeBlock;

@end
