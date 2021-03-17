//
//  ImageRotateViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/6/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ImageRotateViewController.h"
#import "UIImage+CJRotateAngle.h"

@interface ImageRotateViewController ()

@end

@implementation ImageRotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = NSLocalizedString(@"UIImage(旋转任意角度)", nil);
    
    UIImage *image = [UIImage imageNamed:@"taixi_icon"];
    self.imageView1.image = image;
    //self.imageView1.contentMode = UIViewContentModeScaleAspectFit;
    
    self.imageView2.image = image;
    //self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
    
    self.imageView3.image = image;
    
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 360;
    [self.slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    self.slider.value = 0;
}

- (void)sliderValueChange:(UISlider *)slider {
    CGFloat angle = slider.value;
    self.sliderValueLabel.text = [NSString stringWithFormat:@"当前旋转的角度为%.2f°", angle];
    
    UIImage *image = [UIImage imageNamed:@"taixi_icon"];
    
    UIImage *image1 = [image cj_rotateImageWithAngle:angle isExpand:YES];
    self.imageView1.image = image1;
    
    UIImage *image2 = [image cj_rotateImageWithAngle:angle isExpand:NO];
    self.imageView2.image = image2;
    
    CGAffineTransform transform= CGAffineTransformMakeRotation(angle);
    self.imageView3.transform = transform;
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
