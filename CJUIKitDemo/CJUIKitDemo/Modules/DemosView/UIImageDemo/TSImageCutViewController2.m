
//  TSImageCutViewController2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "TSImageCutViewController2.h"
#ifdef TEST_CJBASEUIKIT_POD
#import "UIImageCJCutHelper.h"
#else
#import <CJBaseUIKit/UIImageCJCutHelper.h>
#endif

#import "TwoImageCompareView.h"

#import <CQDemoKit/CQTSContainerViewFactory.h>
#import <CQDemoKit/CQTSButtonFactory.h>

#import "UIImage+CJTransformSize.h"

@interface TSImageCutViewController2 ()

@end

@implementation TSImageCutViewController2

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
    compareView1.titleLabel.text = @"确保图片的宽高比的在什么范围内，如果不在则裁剪";
    compareView1.sliderValueLabel1.text = @"宽高比的最大值/原图宽太宽时候，裁剪宽，保持高";
    compareView1.slider1.minimumValue = 0;
    compareView1.slider1.maximumValue = 2;
    compareView1.slider1.value = 4/3.0;
    compareView1.sliderValueLabel2.text = @"宽高比的最小值/原图高太高时候，裁剪高，保持宽";
    compareView1.slider2.minimumValue = 0;
    compareView1.slider2.maximumValue = 2;
    compareView1.slider2.value = 343/580.0;
    compareView1.sliderValueChangeBlock = ^(TwoImageCompareView *bSelfView) {
        CGFloat widthRatio = bSelfView.slider1.value;
        CGFloat heightRatio = bSelfView.slider2.value;
        bSelfView.sliderValueLabel1.text = [NSString stringWithFormat:@"宽高比的最大值%.2f", widthRatio];
        bSelfView.sliderValueLabel2.text = [NSString stringWithFormat:@"宽高比的最小值%.2f", heightRatio];
        NSString *title = @"确保图片的宽高比的在什么范围内，如果不在则裁剪";
        [self setupCompareView:bSelfView withTitle:title originImage:originImage widthHeightMaxRatio:4/3.0 widthHeightMinRatio:343/580.0];
    };
    [self.view addSubview:compareView1];
    
    
    UIButton *tsButton = [CQTSButtonFactory themeBGButtonWithTitle:@"重新裁剪，测试闪烁" actionBlock:^(UIButton * _Nonnull bButton) {
        [self setupCompareView:compareView1 withTitle:@"宽高比的范围值(最大4/3.0,最小343/580.0)" originImage:originImage widthHeightMaxRatio:4/3.0 widthHeightMinRatio:343/580.0];
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
     widthHeightMaxRatio:(CGFloat)widthHeightMaxRatio
     widthHeightMinRatio:(CGFloat)widthHeightMinRatio
{
//    CGFloat widthHeightMaxRatio = 4/3.0;
//    CGFloat widthHeightMinRatio = 343/580.0;
    UIImage *newImage = [UIImageCJCutHelper cutImage:originImage fromRegionType:UIImageCutFromRegionCenter tooWidthKeepRatio:widthHeightMaxRatio tooHeightKeepRatio:widthHeightMinRatio noTooWidthOrHeightKeepRatio:1/1.0];
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
