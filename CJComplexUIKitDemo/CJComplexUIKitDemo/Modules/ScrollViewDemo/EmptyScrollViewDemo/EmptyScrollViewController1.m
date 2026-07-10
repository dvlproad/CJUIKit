//
//  EmptyScrollViewController1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/26.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "EmptyScrollViewController1.h"
#import "DataEmptyViewFactory.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface EmptyScrollViewController1 () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    
}
@property (nonatomic, strong) CJDataEmptyView *emptyView;

@property (nonatomic, assign, readonly) BOOL isNetworkWeb;   /**< 是否是网络网页，否则是本地网页 */

@end

@implementation EmptyScrollViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"DZNEmptyDataSet", nil);
    
    self.scrollView.emptyDataSetSource = self;
    self.scrollView.emptyDataSetDelegate = self;
    [self.scrollView reloadEmptyDataSet];
}

//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
//    return [UIImage imageNamed:@"currency_icon_network"];
//}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyView;
}


#pragma mark - LazyLoad
- (CJDataEmptyView *)emptyView {
    if (_emptyView == nil) {
        CJDataEmptyView *emptyView = [DataEmptyViewFactory networkEmptyViewWithSuccess:^{
            self->_isNetworkWeb = YES;
            
            //通过URL，创建Request并加载
            //NSURL *URL = [NSURL URLWithString:self.requestUrl];;
            //NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            //[self.webView loadRequest:request];

        }];
        _emptyView = emptyView;
    }
    
    return _emptyView;
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
