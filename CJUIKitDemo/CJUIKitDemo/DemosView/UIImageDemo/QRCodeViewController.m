//
//  QRCodeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/8/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "QRCodeViewController.h"
#import "UIImage+CJQRCode.h"

@interface QRCodeViewController () {
    
}
@property (nonatomic, weak) IBOutlet UIImageView *qrCodeImageView;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createQRCodeImage];
}

- (void)createQRCodeImage {
    UIImage *qrCodeImage = [UIImage cj_QRUIImageForQRString:@"http://weixin.qq.com/r/0UxTS0nEJBRbrQ0o9xnD" size:100]; //创建二维码
    qrCodeImage = [qrCodeImage cj_QRImageWithColor:[UIColor redColor]]; //改变二维码颜色
    qrCodeImage = [qrCodeImage cj_addWaterImage:[UIImage imageNamed:@"bg.jpg"] withSize:CGSizeMake(40, 40)]; //添加二维码水印
    
    self.qrCodeImageView.image = qrCodeImage;
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
