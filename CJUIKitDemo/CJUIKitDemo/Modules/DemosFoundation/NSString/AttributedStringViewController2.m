//
//  AttributedStringViewController2.m
//  CJFoundationDemo
//
//  Created by ciyouzne on 2017/7/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AttributedStringViewController2.h"
#import "UIColor+CJHex.h"
#import <CJFoundation/NSString+CJAttributedString.h>

@interface AttributedStringViewController2 ()

@end

@implementation AttributedStringViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.backgroundColor = [UIColor lightGrayColor];
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.top.mas_equalTo(self.view).mas_offset(120);
        make.height.mas_equalTo(100);
    }];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.backgroundColor = [UIColor lightGrayColor];
    label2.numberOfLines = 0;
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.top.mas_equalTo(label1.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(100);
    }];
    
    
    label1.attributedText = [self __emailAttributedString:@"xxxx@163.com"];
    label2.attributedText = [self __drawAttributedString];
}


- (NSAttributedString *)__emailAttributedString:(NSString *)emailString {
    NSString *string1 = NSLocalizedString(@"我们已将重置密码的邮件发送至您的账户邮箱：\n", nil);
    NSString *string3 = NSLocalizedString(@"\n请访问邮件内的地址进行重置", nil);
    NSString *mesg1 = [NSString stringWithFormat:@"%@%@%@", string1, emailString, string3];
    
    CJStringAttributedModel *stringAttributedModel = [[CJStringAttributedModel alloc] init];
    stringAttributedModel.string = emailString;
    stringAttributedModel.font = [UIFont systemFontOfSize:21.0];
    stringAttributedModel.color = [UIColor redColor];
    stringAttributedModel.underline = YES;
    NSAttributedString *attributedString1 = [mesg1 attributedStringWithModels:@[stringAttributedModel]];
    
    return attributedString1;
}

- (NSAttributedString *)__drawAttributedString {
    NSString *title =  @"还差{{2}}件商品参与抽奖";
    CJStringAttributedModel *stringAttributedModel = [[CJStringAttributedModel alloc] init];
    stringAttributedModel.font = [UIFont systemFontOfSize:23];
    stringAttributedModel.color = CJColorFromHexString(@"#212474");
    stringAttributedModel.underline = NO;
    NSAttributedString *attributedTitle = [title attributedStringForSepicalBetweenStart:@"{{" end:@"}}" middleStringAttributedModel:stringAttributedModel];
    
    return attributedTitle;
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
