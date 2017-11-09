//
//  NavigationBarBaseViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarBaseViewController.h"

#import "EasyScaleHeadView.h"

@interface NavigationBarBaseViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation NavigationBarBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addTableHeaderView]; //仅用于测试添加tableHeaderView，是否会对待会addSubview的TableScaleHeader有影响。warning：需要先设置完tableHeaderView后，再进行协议设置，否则协议走不进去
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)addTableHeaderView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"NavigationBarBaseViewController" owner:self options:nil];
    UIView *tableHeaderView = [views objectAtIndex:1];
    
    /* 改变tableHeaderView的高度 */
    CGRect tableHeaderViewFrame = tableHeaderView.frame;
    tableHeaderViewFrame.size.height = 200;
    tableHeaderView.frame = tableHeaderViewFrame;
    
    self.tableView.tableHeaderView = tableHeaderView;
}

/* 完整的描述请参见文件头部 */
- (void)addTableScaleHeaderViewWithAttachNavigationBar:(BOOL)attachNavigationBar supportPullSmall:(BOOL)canPullSmall  {
    CJScaleHeadView *scaleHeadView = nil;
    if (!canPullSmall) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"EasyScaleHeadView" owner:self options:nil];
        EasyScaleHeadView *easyScaleHeadView = (EasyScaleHeadView *)[views objectAtIndex:0];
        scaleHeadView = easyScaleHeadView;
        
        /* 改变scaleHeadView的高度 */
        CGRect scaleHeadViewFrame = scaleHeadView.frame;
        scaleHeadViewFrame.size.height = 200;
        scaleHeadView.frame = scaleHeadViewFrame;
        
    } else {
        MyUserInfoScaleHeadView *userInfoScaleHeadView = [[MyUserInfoScaleHeadView alloc] initWithFrame:CGRectZero];
        userInfoScaleHeadView.backgroundImageView.image = [UIImage imageNamed:@"bg.jpg"];
        [userInfoScaleHeadView.portraitButton setImage:[UIImage imageNamed:@"header.jpg"] forState:UIControlStateNormal];
        [userInfoScaleHeadView.nameLabel setText:@"昵称"];
        userInfoScaleHeadView.originHeight = 200;
        
        scaleHeadView = userInfoScaleHeadView;
        
        /* 改变scaleHeadView的高度 */
        CGRect scaleHeadViewFrame = scaleHeadView.frame;
        scaleHeadViewFrame.size.height = 200;
        scaleHeadView.frame = scaleHeadViewFrame;
    }
    
    self.scaleHeadView = scaleHeadView;
    [self.tableView addSubview:scaleHeadView];
    [scaleHeadView pullScaleByScrollView:self.tableView withAttachNavigationBar:attachNavigationBar];
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
