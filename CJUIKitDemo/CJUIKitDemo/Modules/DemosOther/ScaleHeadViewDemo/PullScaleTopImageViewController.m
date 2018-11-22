//
//  PullScaleTopImageViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "PullScaleTopImageViewController.h"
#import "UINavigationBar+CJChangeBG.h"

@interface PullScaleTopImageViewController () <UITableViewDataSource,UITableViewDelegate> {
    
}


@end

@implementation PullScaleTopImageViewController
/**
 * 推荐大家在使用这个视图的时候尽量使用带有navigationBar的controller，在不带有navigationBar的controller中也支持这一效果，请参考第一个Demo，但是在滚动到顶部的时候有时会因为滚动过快导致获取的偏移量不准确产生偏差，但是在带有navigationBar的controller中是没有这一问题的，源码中已经做了处理，处理方法为 - (void)fixHeaderImageViewWithReachtop:(BOOL)reachtop; 请大家放心使用
 */

/**
 这个视图的使用方法及注意事项，主要有以下几点：
 1、在 - (void)viewWillAppear:(BOOL)animated 方法中需要调用一次 [self.headerView reloadWithScrollView:self.tableView]，为了防止在刚进入这一页面的时候视图有偏差
 2、需要设置 tableView 的 contentInset 的 top 值为 kImageHeight - kNavigationBarHeight
 3、需要设置 tableView 的背景色为 [UIColor clearColor]，否则会遮挡视图
 4、需要设置 tableView 的顶部据屏幕顶部为 64，否则如果你想设置navigationBar为透明时顶部有留白
 5、需要将视图插入到 tableView 的底部，这里是将视图加在 self.view 上，并在tableView的底部，[self.view insertSubview:self.headerView belowSubview:self.tableView]
 6、需要在 - (void)scrollViewDidScroll:(UIScrollView *)scrollView 方法中调用 [self.headerView reloadWithScrollView:scrollView]
 7、需要设置 self.automaticallyAdjustsScrollViewInsets = NO; 防止滚动视图有偏差
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar cj_resetBackgroundColor];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.headerView reloadWithScrollView:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kImageHeight - kNavigationBarHeight, 0, 0, 0);
    [self.view insertSubview:self.headerView belowSubview:self.tableView]; //记得放的位置
    self.tableView.backgroundColor = [UIColor clearColor]; //记得弄透明
}

- (LEOHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LEOHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kImageHeight)];
        [_headerView setBackgroundImage:[UIImage imageNamed:@"bgSky.jpg"]];
        [_headerView setHeaderImage:[UIImage imageNamed:@"header.jpg"] text:@"leiliang"];
        // 点击头像回调
        [_headerView pressHeaderImageWithBlock:^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你点击了头像" message:@"" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertView show];
        }];
        
        // navigationBar 的颜色可以根据这个方法来调整
        __weak typeof(self) weakSelf = self;
        [_headerView scrollViewStateChangeWithBlock:^(BOOL reachtop) {
            [weakSelf.navigationController.navigationBar cj_setBackgroundColor:reachtop ? [UIColor lightGrayColor] : [UIColor clearColor]];
        }];
    }
    return _headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView reloadWithScrollView:scrollView];
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
    //NSLog(@"didSelectRowAtIndexPath = %zd %zd", indexPath.section, indexPath.row);
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
