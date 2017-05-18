//
//  ViewController.m
//  iOS-NavigationBar-Category
//
//  Created by 雷亮 on 16/7/29.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "UINavigationBar+leoAdd.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString *>*dataArray;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar leo_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"View Controller";
    
    [self.navigationController.navigationBar leo_removeUnderline];
    
    self.dataArray = @[@"present DemoVC",
                       @"push DemoVC",
                       @"push DemoVC (navigationBar color can reset)"];
}

#pragma mark -
#pragma mark - tableView protocol methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reUse" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DemoViewController *demoVC = [[DemoViewController alloc] init];
    demoVC.index = indexPath.row;
    if (indexPath.row == 0) {
        [self presentViewController:demoVC animated:YES completion:^{
        }];
    } else {
        [self.navigationController pushViewController:demoVC animated:YES];        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
