//
//  ImageSizeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "ImageSizeViewController.h"
#import <CJBaseUIKit/UIImage+CJTransformSize.h>

@interface ImageSizeViewController ()

@end

@implementation ImageSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *oldImage = [UIImage imageNamed:@"bgCar.jpg"];
    self.imageView1_old.image = oldImage;
    NSData *compressImageData = [oldImage cj_compressWithMaxDataLength:40.0f * 1024.0f]; //40k
    UIImage *compressImage = [UIImage imageWithData:compressImageData];
    self.imageView1_new.image = compressImage;
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
