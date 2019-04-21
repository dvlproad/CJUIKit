//
//  EmptyScrollViewController2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/4/26.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "EmptyScrollViewController2.h"
#import "DataEmptyViewFactory.h"
#import "UIScrollView+CJAddFillView.h"

@interface EmptyScrollViewController2 ()  {
    
}
@property (nonatomic, strong) CJDataEmptyView *emptyView;

@property (nonatomic, assign, readonly) BOOL isNetworkWeb;   /**< 是否是网络网页，否则是本地网页 */

@end

@implementation EmptyScrollViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"UIScrollView+CJAddFillView", nil);
    
    [self.scrollView cj_addFillView:self.emptyView];
    
    /*
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.emptyView.hidden = NO;
    //*/
}


#pragma mark - LazyLoad
- (CJDataEmptyView *)emptyView {
    if (_emptyView == nil) {
        _emptyView = [DataEmptyViewFactory networkEmptyViewWithSuccess:^{
            self->_isNetworkWeb = YES;
            
            [SVProgressHUD show];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                sleep(1);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
            
            //通过URL，创建Request并加载
            //NSURL *URL = [NSURL URLWithString:self.requestUrl];;
            //NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            //[self.webView loadRequest:request];

        }];
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
