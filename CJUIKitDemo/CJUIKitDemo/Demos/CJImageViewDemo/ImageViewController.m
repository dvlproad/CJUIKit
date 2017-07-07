//
//  ImageViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ImageViewController.h"
#import "UIColor+CJHex.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"CJImageView", nil);
    
    self.badgeImageView.image = [UIImage imageNamed:@"icon.png"];
    self.badgeImageView.badge = 100;
    self.badgeImageView.title = @"年年年年";
    self.badgeImageView.titleColor = [UIColor redColor];
    self.badgeImageView.imageCornerRadius = 10;
    [self.badgeImageView setTapCompleteBlock:^(CJImageView *imageView) {
        NSLog(@"点击照片");
    }];
    
    //以下三种设置颜色一样
    self.view.backgroundColor = CJColorFromHex(0x43FBFE);
    self.view.backgroundColor = [UIColor cjColorWithHexString:@"0x43FBFE"];
    self.view.backgroundColor = [UIColor cjColorWithHexString:@"#43FBFE"];
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
