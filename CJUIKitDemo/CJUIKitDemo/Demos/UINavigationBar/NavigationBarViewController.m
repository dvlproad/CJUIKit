//
//  NavigationBarViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/4/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarViewController.h"

#import "UINavigationBar+CJChangeBG.h"

@interface NavigationBarViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation NavigationBarViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //先设置完tableHeaderView后，再进行协议设置，否则协议走不进去
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"NavigationBarViewController" owner:self options:nil];
    UIView *tableHeaderView = [views objectAtIndex:1];
    self.tableView.tableHeaderView = tableHeaderView;
    
    /* 改变tableHeaderView的高度 */
    CGRect tableHeaderViewFrame = tableHeaderView.frame;
    tableHeaderViewFrame.size.height = 300;
    tableHeaderView.frame = tableHeaderViewFrame;
    [self.tableView layoutIfNeeded];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    //改变导航栏背景色
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat navigationBarChangeAtPointY = 50;
    CGFloat alpha = 0;
    if (offsetY > navigationBarChangeAtPointY) {
        alpha = MIN(1, 1 - ((navigationBarChangeAtPointY + 64 - offsetY) / 64));
    }
    
    [self.navigationController.navigationBar cj_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.tableView.delegate = nil;
    [self.navigationController.navigationBar cj_reset];
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
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
