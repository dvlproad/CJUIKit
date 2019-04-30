//
//  TypeConvertViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TypeConvertViewController.h"
#import "NSJSONSerialization+CJCategory.h"

@interface TypeConvertViewController ()

@end

@implementation TypeConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *array = @[@"abc", @"defg", @"hijk", @"lmn", @"opq", @"我来说一句话", @"这是测试json转换是否有特殊字符生成"];
    NSString *jsonString = [NSJSONSerialization cj_JSONStringFromJsonObject:array];
    NSLog(@"jsonString = %@", jsonString);
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
