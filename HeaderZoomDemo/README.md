# iOS-Header-Zoom --

在很多App中，经常存在一种需求就是，界面上下滚动时用户的头像也会跟着滚动，而用户头像在视图向上滚动一定范围时停留并在导航栏的位置，这里我实现了一个视图，基本用法如下：

1、视图的基本效果：
```
- (LEOHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LEOHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kImageHeight)];
        [_headerView setBackgroundImage:[UIImage imageNamed:@"background.jpg"]];
        [_headerView setHeaderImage:[UIImage imageNamed:@"header.jpg"] text:@"leiliang"];
    }
    return _headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView reloadWithScrollView:scrollView];
}
```

2、给头像添加点击方法及滚动到临界值的回调
```
// 点击头像回调
[self.headerView pressHeaderImageWithBlock:^{
    NSLog(@"点击头像");
}];

// navigationBar 的颜色可以根据这个方法来调整
// @param reachtop: YES 已经滚动到顶部, NO 在顶部以下
__weak typeof(self) weakSelf = self;
[self.headerView scrollViewStateChangeWithBlock:^(BOOL reachtop) {
    [weakSelf.navigationController.navigationBar leo_setBackgroundColor:reachtop ? [UIColor lightGrayColor] : [UIColor clearColor]];
}];
```

使用起来很简单，只需要这几行代码就可以了，另外一些注意事项如下：
```
 1、在 - (void)viewWillAppear:(BOOL)animated 方法中需要调用一次 [self.headerView reloadWithScrollView:self.tableView]，为了防止在刚进入这一页面的时候视图有偏差
 2、需要设置 tableView 的 contentInset 的 top 值为 kImageHeight - kNavigationBarHeight
 3、需要设置 tableView 的背景色为 [UIColor clearColor]，否则会遮挡视图
 4、需要设置 tableView 的顶部据屏幕顶部为 64，否则如果你想设置navigationBar为透明时顶部有留白
 5、需要将视图插入到 tableView 的底部，这里是将视图加在 self.view 上，并在tableView的底部，[self.view insertSubview:self.headerView belowSubview:self.tableView]
 6、需要在 - (void)scrollViewDidScroll:(UIScrollView *)scrollView 方法中调用 [self.headerView reloadWithScrollView:scrollView]
 7、需要设置 self.automaticallyAdjustsScrollViewInsets = NO; 防止滚动视图有偏差
```

最后献上Demo的样式：
![headerZoom.gif](headerZoom.gif)
