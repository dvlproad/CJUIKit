//
//  NavigationBarBaseViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/4/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarBaseViewController.h"

#import "MyScaleHeadView.h"

@interface NavigationBarBaseViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
}

@end

@implementation NavigationBarBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self addTableHeaderView];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)addTableHeaderView {
    //warning：需要先设置完tableHeaderView后，再进行协议设置，否则协议走不进去
    //①
//    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"NavigationBarBaseViewController" owner:self options:nil];
//    UIView *tableHeaderView = [views objectAtIndex:1];
    //②
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"MyScaleHeadView" owner:self options:nil];
    MyScaleHeadView *tableHeaderView = [views objectAtIndex:0];
    //③
//    CJScaleHeadView *tableHeaderView = [[CJScaleHeadView alloc] initWithFrame:CGRectMake(10, 10, 320, 400)];
//    tableHeaderView.backgroundColor = [UIColor greenColor];
    
    /* 改变tableHeaderView的高度 */
    CGRect tableHeaderViewFrame = tableHeaderView.frame;
    tableHeaderViewFrame.size.height = 200;
    tableHeaderView.frame = tableHeaderViewFrame;
    
//    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.cjScaleHeadView = tableHeaderView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    //cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
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
