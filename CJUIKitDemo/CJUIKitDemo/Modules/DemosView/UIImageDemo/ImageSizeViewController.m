
//  ImageSizeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "ImageSizeViewController.h"
#ifdef TEST_CJBASEUIKIT_POD
#import "UIImage+CJTransformSize.h"
#else
#import <CJBaseUIKit/UIImage+CJTransformSize.h>
#endif

#import "DemoCacheUtil.h"

#import "TwoImageCompareView.h"

#import <CQDemoKit/CQTSContainerViewFactory.h>

@interface ImageSizeViewController ()

@end

@implementation ImageSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = NSLocalizedString(@"图片裁剪前后比对", nil);
    
    UIImage *oldImage = [UIImage imageNamed:@"bgCar.jpg"];
    self.imageView1_old.image = oldImage;
    NSData *compressImageData = [oldImage cj_compressWithMaxDataLength:40.0f * 1024.0f]; //40k
    NSLog(@"压缩后数据大小:%.4f MB",(double)compressImageData.length/1024.0f/1024.0f);
    [DemoCacheUtil saveImageData:compressImageData forModuleType:DemoModuleTypeAsset];
    UIImage *compressImage = [UIImage imageWithData:compressImageData];
    self.imageView1_new.image = compressImage;
    
    self.pathLabel1.numberOfLines = 0;
    self.pathLabel1.text = NSHomeDirectory();
    NSLog(@"NSHomeDirectory() = %@", NSHomeDirectory());
    
    
    [self setupViews];
}

#pragma mark - SetupViews
- (void)setupViews {
    UIImage *originImage1 = [UIImage imageNamed:@"longVertical.jpg"];
    
    CGSize cutSize1 = CGSizeMake(30, 100);
    TwoImageCompareView *compareView1 = [self compareViewWithOriginImage:originImage1 cutSize:cutSize1];
    
    CGSize cutSize2 = CGSizeMake(50, 100);
    TwoImageCompareView *compareView2 = [self compareViewWithOriginImage:originImage1 cutSize:cutSize2];
    
    CGSize cutSize3 = CGSizeMake(100, 100);
    TwoImageCompareView *compareView3 = [self compareViewWithOriginImage:originImage1 cutSize:cutSize3];
    
    CGSize cutSize4 = CGSizeMake(120, 100);
    TwoImageCompareView *compareView4 = [self compareViewWithOriginImage:originImage1 cutSize:cutSize4];
    
    NSArray<UIView *> *compareViews = @[compareView1, compareView2, compareView3, compareView4];
    UIView *container = [CQTSContainerViewFactory containerViewAlongAxis:MASAxisTypeVertical withSubviews:compareViews];
    
    [self.view addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pathLabel1.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(4*100+3*10);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
}

#pragma mark - Private Method
- (TwoImageCompareView *)compareViewWithOriginImage:(UIImage *)originImage cutSize:(CGSize)cutSize {
    TwoImageCompareView *compareView1 = [[TwoImageCompareView alloc] initWithFrame:CGRectZero];
    compareView1.backgroundColor = [UIColor redColor];
    compareView1.imageView1.layer.masksToBounds = YES;
    compareView1.imageView2.layer.masksToBounds = YES;
    compareView1.imageView1.contentMode = UIViewContentModeScaleAspectFit; // 为了显示原图，好作为新图的比对
    compareView1.imageView2.contentMode = UIViewContentModeScaleAspectFit;
    
//    UIImage *newImage = [UIImage cutCenterImageSize:cutSize iMg:originImage];
    UIImage *newImage = [UIImage cutImage:originImage tooWidthTrimmedWidthKeepHeightWithRatio:4/3.0 tooHeightTrimmedHeightKeepWithWithRatio:343/580.0];
    compareView1.imageView1.image = originImage;
    compareView1.imageView2.image = newImage;
    
    return compareView1;
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
