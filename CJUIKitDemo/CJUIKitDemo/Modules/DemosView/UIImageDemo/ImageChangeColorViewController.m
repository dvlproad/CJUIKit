//
//  ImageChangeColorViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ImageChangeColorViewController.h"
#import "UIImage+CJChangeColor.h"
#import "CJQRCodeUtil.h"

@interface ImageChangeColorViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView1;
@property (nonatomic, weak) IBOutlet UIImageView *imageView2;
@property (nonatomic, weak) IBOutlet UIImageView *imageView3;

@end

@implementation ImageChangeColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    UIImage *originImage = [UIImage imageNamed:@"qq"];
    
    self.imageView.image = [originImage cj_resizeToSize:CGSizeMake(100, 100)];;
    
    //kCGBlendModeDestinationIn
    self.imageView1.image = [originImage cj_imageWithTintColor:[UIColor orangeColor]];
    self.imageView1.image = [originImage cj_addBackgroundColor:[UIColor redColor] size:CGSizeMake(100, 100) cornerRadius:50];
    
    //kCGBlendModeOverlay
    self.imageView2.image = [originImage cj_imageWithGradientTintColor:[UIColor orangeColor]];
    UIImage *image2 = originImage;
    image2 = [image2 cj_resizeToSize:CGSizeMake(50, 50)];
    image2 = [image2 cj_imageWithTintColor:[UIColor whiteColor]];
//    image2 = [image2 cj_addBackgroundColor:[UIColor redColor] size:CGSizeMake(100, 100) cornerRadius:50];
    image2 = [image2 cj_addBackgroundColor:[UIColor redColor] backgroundSize:CGSizeMake(100, 100) imageSize:CGSizeMake(50, 50) cornerRadius:50];
    self.imageView2.image = image2;
//    self.imageView2.image = [originImage cj_imageWithGradientTintColor:[UIColor orangeColor]];
    
    self.imageView3.image = [CJQRCodeUtil changeQRCodeImage:originImage withColor:[UIColor orangeColor]];
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
