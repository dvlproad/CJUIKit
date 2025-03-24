//
//  ImageShakeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/6/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ImageShakeViewController.h"
#import <Masonry/Masonry.h>
#import <CQDemoKit/CQTSContainerViewFactory.h>
#import "UIImage+CJRotateAngle.h"

@interface ImageShakeViewController () {
    
}
@property (nonatomic, strong) UILabel *sliderValueLabel;    /**< 旋转的角度值 */
@property (nonatomic, strong) UISlider *slider;             /**< 设置旋转角度的滑块 */

@property (nonatomic, strong) UIImageView *imageView1;  /**< 图片本身旋转 */
@property (nonatomic, strong) UIImageView *imageView2;  /**< 图片本身旋转 */

@property (nonatomic, strong) UIImageView *imageView3;  /**< 图片视图旋转 */

@end


@implementation ImageShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = NSLocalizedString(@"UIImage(旋转任意角度)", nil);
    
    [self setupViews];
    self.sliderValueLabel.text = @"当前旋转的角度为0°";
    
    UIImage *image = [UIImage imageNamed:@"bg.jpg"];
    self.imageView1.image = image;
    self.imageView2.image = image;
    self.imageView3.image = image;
    
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 360;
    [self.slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    self.slider.value = 0;
}

- (void)setupViews {
    UILabel *sliderValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:sliderValueLabel];
    [sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(20);
    }];
    self.sliderValueLabel = sliderValueLabel;
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
    [self.view addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(sliderValueLabel.mas_bottom).mas_offset(10);
    }];
    self.slider = slider;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView1.backgroundColor = [UIColor redColor];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView2.backgroundColor = [UIColor redColor];
    NSArray<UIView *> *compareViews = @[imageView1, imageView2];
    UIView *container = [CQTSContainerViewFactory containerViewAlongAxis:MASAxisTypeHorizontal withSubviews:compareViews fixedSpacing:10];
    [self.view addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80*2 + 10);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(slider.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(168);
    }];
    self.imageView1 = imageView1;
    self.imageView2 = imageView2;
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView3.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView3];
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(container.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(168);
    }];
    self.imageView3 = imageView3;
}

- (void)sliderValueChange:(UISlider *)slider {
    CGFloat angle = slider.value;
    self.sliderValueLabel.text = [NSString stringWithFormat:@"当前旋转的角度为%.2f°", angle];
    
    CGFloat rotaAngle = angle/180.0*M_PI;
    self.imageView1.layer.transform = CATransform3DMakeRotation(rotaAngle, 0.5, 0.5, 0);
    self.imageView2.layer.transform = CATransform3DMakeRotation(rotaAngle, 0, 1, 0);
    self.imageView3.layer.transform = CATransform3DMakeRotation(rotaAngle, 0, 0, 1);
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
