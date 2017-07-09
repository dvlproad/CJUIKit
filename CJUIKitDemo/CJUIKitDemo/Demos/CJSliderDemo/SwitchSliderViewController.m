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
    
    [self commonSetupToSwitchSlider:self.switchSlider];
    
    [self commonSetupToSwitchSlider:self.shimmeringSwitchSlider.switchSlider];
    [self.shimmeringSwitchSlider.switchSlider reloadSlider];
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
