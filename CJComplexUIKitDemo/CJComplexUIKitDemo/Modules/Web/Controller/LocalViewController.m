//
//  LocalViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "LocalViewController.h"

@interface LocalViewController ()

@end

@implementation LocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"网页(本地)", nil);
    
    NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"localWeb.html" ofType:nil];
    [self reloadLocalWebWithUrl:localHtmlUrl]; //加载本地网页
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
