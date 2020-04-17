//
//  CJSearchBar.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSearchBar.h"
#import "CJSearchBarDelegate.h"
//#import "LKThemeManager.h"

@interface CJSearchBar () <UISearchBarDelegate> {
    
}
@property (nonatomic, strong) CJSearchBarDelegate *searchBarDelegate;

@end



@implementation CJSearchBar

/*
*  初始化搜索栏
*
*  @param textChangeBlock 搜索栏文本改变时的回调
*
*  @return 搜索栏
*/
- (instancetype)initWithTextDidChange:(void(^)(UISearchBar *searchBar, NSString *searchText))textChangeBlock {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.searchBarDelegate = [[CJSearchBarDelegate alloc] initWithTextDidChange:textChangeBlock];
        self.delegate = self.searchBarDelegate;
        self.searchBarStyle = UISearchBarStyleMinimal;    //不显示背景
        
        // 风格颜色，可用于修改输入框的光标颜色，取消按钮和选择栏被选中时候都会变成设置的颜色
        //self.tintColor = [LKThemeManager serviceThemeModel].themeColor;
        
        // 搜索框背景颜色
        //self.barTintColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
