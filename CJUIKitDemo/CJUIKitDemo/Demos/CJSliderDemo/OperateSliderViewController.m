//
//  OperateSliderViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "OperateSliderViewController.h"
#import "UIImage+CJCreate.h"
#import "UIImage+CJTransformSize.h"


@interface OperateSliderViewController () {
    
}

@end

@implementation OperateSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSMutableArray *sliderStatusModels = [[NSMutableArray alloc] init];
    
    {
        CJSliderStatusModel *statusModel = [[CJSliderStatusModel alloc] init];
        statusModel.image = [UIImage imageNamed:@"icon_ddlb_jd.png"];
        [sliderStatusModels addObject:statusModel];
    }
    
    {
        CJSliderStatusModel *statusModel = [[CJSliderStatusModel alloc] init];
        statusModel.image = [UIImage imageNamed:@"icon_ddlb_hd.png"];
        [sliderStatusModels addObject:statusModel];
    }
    
    {
        CJSliderStatusModel *statusModel = [[CJSliderStatusModel alloc] init];
        statusModel.image = [UIImage cj_imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(30, 30)];
        [sliderStatusModels addObject:statusModel];
    }
    
    CJSwitchSlider *switchSlider = self.shimmeringSwitchSlider.switchSlider;
    switchSlider.statusModels = sliderStatusModels;
    [switchSlider updateStateForIndex:0];
    
    [switchSlider setSwitchSuccessBlock:^(NSInteger step){
        NSLog(@"第%ld个步骤完成", step);
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
