//
//  ImageChangeColorViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ImageChangeColorViewController.h"
#import "UIImage+CJChangeColor.h"
#import "UIImage+CJQRCode.h"

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
    
    UIImage *originImage = [UIImage imageNamed:@"imageOriginColor"];
    
    self.imageView.image = originImage;
    
    //kCGBlendModeDestinationIn
    self.imageView1.image = [originImage cj_imageWithTintColor:[UIColor orangeColor]];
    
    //kCGBlendModeOverlay
    self.imageView2.image = [originImage cj_imageWithGradientTintColor:[UIColor orangeColor]];
    
    self.imageView3.image = [originImage cj_QRImageWithColor:[UIColor orangeColor]];
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
