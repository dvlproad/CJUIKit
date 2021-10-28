
//  TSImageCutViewController1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TSImageCutViewController1.h"
#ifdef TEST_CJBASEUIKIT_POD
#import "UIImageCJCutHelper.h"
#else
#import <CJBaseUIKit/UIImageCJCutHelper.h>
#endif

#import "TwoImageCompareView.h"

#import <CQDemoKit/CQTSContainerViewFactory.h>
#import <CQDemoKit/CQTSButtonFactory.h>

#import "UIImage+CJTransformSize.h"

@interface TSImageCutViewController1 ()

@end

@implementation TSImageCutViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = NSLocalizedString(@"图片裁剪前后比对", nil);
    
    UILabel *homeDirectoryLabel = [[UILabel alloc] init];
    [self.view addSubview:homeDirectoryLabel];
    [homeDirectoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
    }];
    homeDirectoryLabel.numberOfLines = 0;
    homeDirectoryLabel.text = NSHomeDirectory();
    NSLog(@"NSHomeDirectory() = %@", NSHomeDirectory());
    
    
    [self setupViews];
}

#pragma mark - SetupViews
- (void)setupViews {
    UIImage *originImage = [UIImage imageNamed:@"longVertical.jpg"];
    
    TwoImageCompareView *compareView1 = [self compareView];
    compareView1.imageView1.image = originImage;
    compareView1.titleLabel.text = @"从原图中裁剪出指定宽高比的图片";
    compareView1.sliderValueLabel1.text = @"新宽为原宽的比例";
    compareView1.slider1.minimumValue = 0;
    compareView1.slider1.maximumValue = 1;
    compareView1.slider1.value = 1;
    compareView1.sliderValueLabel2.text = @"新高为原高的比例";
    compareView1.slider2.minimumValue = 0;
    compareView1.slider2.maximumValue = 1;
    compareView1.slider2.value = 1;
    compareView1.sliderValueChangeBlock = ^(TwoImageCompareView *bSelfView) {
        CGFloat widthRatio = bSelfView.slider1.value;
        CGFloat heightRatio = bSelfView.slider2.value;
        bSelfView.sliderValueLabel1.text = [NSString stringWithFormat:@"新宽为原宽的比例%.2f", widthRatio];
        bSelfView.sliderValueLabel2.text = [NSString stringWithFormat:@"新高为原高的比例%.2f", heightRatio];
        NSString *title = @"宽太宽时候，裁剪宽，保持高";
        [self setupCompareView:bSelfView withTitle:title originImage:originImage widthRatio:widthRatio heightRatio:heightRatio];
    };
    [self.view addSubview:compareView1];
    
    
    UIButton *tsButton = [CQTSButtonFactory themeBGButtonWithTitle:@"重新裁剪，测试闪烁" actionBlock:^(UIButton * _Nonnull bButton) {
        [self setupCompareView:compareView1 withTitle:@"宽0.3,高1.0" originImage:originImage widthRatio:0.3 heightRatio:1.0];
    }];
    [self.view addSubview:tsButton];
    [tsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(150);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
  
    
    [compareView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tsButton.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(300);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
}


#pragma mark - Private Method
- (TwoImageCompareView *)compareView {
    TwoImageCompareView *compareView = [[TwoImageCompareView alloc] initWithFrame:CGRectZero];
    compareView.backgroundColor = [UIColor redColor];
    compareView.imageView1.layer.masksToBounds = YES;
    compareView.imageView2.layer.masksToBounds = YES;
    compareView.imageView1.contentMode = UIViewContentModeScaleAspectFit; // 为了显示原图，好作为新图的比对
    compareView.imageView2.contentMode = UIViewContentModeScaleAspectFit;
    
    return compareView;
}

- (void)setupCompareView:(TwoImageCompareView *)compareView
               withTitle:(NSString *)title
             originImage:(UIImage *)originImage
              widthRatio:(CGFloat)widthRatio
             heightRatio:(CGFloat)heightRatio
{
    CGFloat oldImageWidth = originImage.size.width;
    CGFloat oldImageHeight = originImage.size.height;

    CGFloat newWidth = oldImageWidth * widthRatio;
    CGFloat newHeight = oldImageHeight * heightRatio;
    CGSize newPixelSize = CGSizeMake(newWidth, newHeight);
//    UIImage *newImage = [UIImageCJCutHelper cutImage:originImage fromRegionType:UIImageCutFromRegionCenter withNewPixelSize:newPixelSize];
    
    UIImage *newImage = [originImage cj_transformImageToSize:newPixelSize];
    
    compareView.titleLabel.text = title;
    compareView.imageView1.image = originImage;
    compareView.imageView2.image = newImage;
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
