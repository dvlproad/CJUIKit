//
//  SearchBarViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//


//详情可参考：iOS中UISearchBar(搜索框)使用总结 https://my.oschina.net/u/2340880/blog/509756
#import "SearchBarViewController.h"

@interface SearchBarViewController () <UISearchBarDelegate> {
    
}


@end

@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.searchBar.placeholder = @"请输入联系人姓名";
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;    //不显示背景
    self.searchBar.delegate = self;
    
    CJSearchBar *searchBar = [[CJSearchBar alloc] initWithFrame:CGRectMake(60, 100, 200, 40)];
    [self.view addSubview:searchBar];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.searchBar resignFirstResponder];
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
