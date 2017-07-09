//
//  SwitchSliderViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "SwitchSliderViewController.h"
#import "UIImage+CJCreate.h"
#import "UIImage+CJTransformSize.h"


@interface SwitchSliderViewController () {
    
}

@end

@implementation SwitchSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"SwitchSliderViewController", nil);
    
    [self commonSetupToSwitchSlider:self.switchSlider];
    
    [self commonSetupToSwitchSlider:self.shimmeringSwitchSlider.switchSlider];
    [self.shimmeringSwitchSlider.switchSlider reloadSlider];
    
    
    /*
     CGRect baseSliderFrame = self.sliderControl3.frame;
     baseSliderFrame.size.height = 40;
     self.sliderControl3.frame = baseSliderFrame;
     self.sliderControl3.backgroundColor = [UIColor greenColor];
     */
    UIImage *trackImage = [UIImage imageNamed:@"slider_maximum_trackimage"];
    trackImage = [trackImage resizableImageWithCapInsets:UIEdgeInsetsMake(3, 7, 3, 7) resizingMode:UIImageResizingModeStretch];
    [self.sliderControl3.trackImageView setImage:trackImage];
    
    self.sliderControl3.valueAccoringType = CJSliderValueAccoringTypeThumbMinX;
    self.sliderControl3.mainThumb.alpha = 0.3;
    self.sliderControl3.trackHeight = 30;
    self.sliderControl3.thumbSize = CGSizeMake(60, 30);
    UIImage *mainThumbImage = [UIImage imageNamed:@"bg.jpg"];
    UIImage *image3 = [mainThumbImage cj_transformImageToSize:CGSizeMake(160, 80)];
    [self.sliderControl3.mainThumb setImage:image3 forState:UIControlStateNormal];
    self.sliderControl3.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:0 max:0.70 toValue:0],
                                        [[CJAdsorbModel alloc] initWithMin:0.7 max:1 toValue:1]];
    self.sliderControl3.delegate = self;
}


- (void)commonSetupToSwitchSlider:(CJSwitchSlider *)switchSlider {
    NSMutableArray *sliderStatusModels = [[NSMutableArray alloc] init];
    
    {
        CJSwitchSliderStatusModel *statusModel = [[CJSwitchSliderStatusModel alloc] init];
        statusModel.image = [UIImage imageNamed:@"icon_ddlb_jd.png"];
        statusModel.goNextStepWhenSwitchEventOccur = YES;
        [sliderStatusModels addObject:statusModel];
    }
    
    {
        CJSwitchSliderStatusModel *statusModel = [[CJSwitchSliderStatusModel alloc] init];
        statusModel.image = [UIImage imageNamed:@"icon_ddlb_hd.png"];
        statusModel.goNextStepWhenSwitchEventOccur = YES;
        [sliderStatusModels addObject:statusModel];
    }
    
    {
        CJSwitchSliderStatusModel *statusModel = [[CJSwitchSliderStatusModel alloc] init];
        statusModel.image = [UIImage cj_imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(30, 30)];
        [sliderStatusModels addObject:statusModel];
    }
    
    switchSlider.trackHeight = 65;
    switchSlider.thumbSize = CGSizeMake(58, 31);
    switchSlider.statusModels = sliderStatusModels;
    [switchSlider.mainThumb setImage:[UIImage imageNamed:@"btn_hd.png"] forState:UIControlStateNormal];
    [switchSlider showStep:0];
    
    [switchSlider setSwitchEventOccuBlock:^(NSInteger execStep){
        NSLog(@"第%ld个步骤执行", execStep);
    }];
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
    if (slider == self.sliderControl3) {
        self.sliderControlValueLabel3.text = [NSString stringWithFormat:@"选取的值是: %.2f", value];
    }
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
