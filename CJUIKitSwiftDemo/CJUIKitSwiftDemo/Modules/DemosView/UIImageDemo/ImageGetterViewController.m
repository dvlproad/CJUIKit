//
//  ImageGetterViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ImageGetterViewController.h"
#import <Masonry/Masonry.h>

@interface ImageGetterViewController ()

@end

@implementation ImageGetterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView1.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    NSString *imageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554202630803&di=84fad580a2f1e780fc28b447b4906520&imgtype=0&src=http%3A%2F%2Fmedia.putibaby.com%2Fmedia%2Fimage-8bfbfc5c9c91179b45b8c6c5163b8f06.jpg"; //正常情况下显示不出来
    NSURL *healthCerImageURL2 = [NSURL URLWithString:imageUrl];
    
    NSData *healthCerImageData2 = [[NSData alloc] initWithContentsOfURL:healthCerImageURL2];
    UIImage *healthCerImage2 = [UIImage imageWithData:healthCerImageData2];
    imageView1.image = healthCerImage2;
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
