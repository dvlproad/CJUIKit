//
//  StringViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "StringViewController.h"

#import "NSString+CJEncryption.h"

@interface StringViewController ()

@end

@implementation StringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *string = @"这是一串比较长的字符串，用来富文本化的文字";
    
    self.attributedLabel.attributedText = nil;
    
    
    NSString *encryptionString = @"得到";
    NSString *base64String = [NSString cj_base64StringFromText:encryptionString];
    NSLog(@"base64String = %@", base64String);
    
    NSString *text = [NSString cj_textFromBase64String:base64String];
    NSLog(@"text = %@", text);
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
