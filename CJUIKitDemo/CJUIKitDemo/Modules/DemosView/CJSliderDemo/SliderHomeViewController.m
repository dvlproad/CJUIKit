//
//  SliderHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "SliderHomeViewController.h"

#import "SliderViewController.h"
#import "RangeSliderViewController.h"
#import "SwitchSliderViewController.h"

@interface SliderHomeViewController ()

@end

@implementation SliderHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"UISlider首页", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //Slider(滑块)
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Slider(滑块)";
        {
            //Slider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"CJSliderControl";
            sliderModule.classEntry = [SliderViewController class];
            sliderModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:sliderModule];
        }
        {
            //RangeSlider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"RangeSlider";
            sliderModule.classEntry = [RangeSliderViewController class];
            sliderModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:sliderModule];
        }
        {
            //SwitchSlider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"SwitchSlider";
            sliderModule.classEntry = [SwitchSliderViewController class];
            sliderModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:sliderModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
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
