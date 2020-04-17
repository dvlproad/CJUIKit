//
//  SearchBarViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//


//详情可参考：iOS中UISearchBar(搜索框)使用总结 https://my.oschina.net/u/2340880/blog/509756
#import "SearchBarViewController.h"
#import "CJSearchBarDelegate.h"

@interface SearchBarViewController () <UISearchBarDelegate> {
    
}
@property (nonatomic, strong) UISearchBar *searchBar1;
//@property (nonatomic, strong) CJSearchBarDelegate *searchBarDelegate;

@end

@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"测试SearchBar", nil);
    
    
    UISearchBar *searchBar1 = [TSSearchBarFactory searchBarWithPlaceholder:@"请输入联系人姓名"];
    [self.view addSubview:searchBar1];
    [searchBar1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(120);
        make.height.mas_equalTo(44);
    }];
    self.searchBar1 = searchBar1;
    
    
    
    CJSearchBar *searchBar2 = [[CJSearchBar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:searchBar2];
    [searchBar2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(searchBar1.mas_bottom).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.searchBar1 resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
