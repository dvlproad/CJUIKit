//
//  MJExtensionViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/2.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MJExtensionViewController.h"
#import "DemoBusFlightModel.h"

@interface MJExtensionViewController ()

@end

@implementation MJExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //DemoBusFlightStationModel
    NSDictionary *busFlightStationDictionary1 = @{@"id": @"1001",
                                                  @"sequence": @"101",
                                                 };
    NSDictionary *busFlightStationDictionary2 = @{@"id": @"1001",
                                                  @"sequence": @"102",
                                                  };
    NSDictionary *busFlightStationDictionary3 = @{@"id": @"1001",
                                                  @"sequence": @"103",
                                                  };
    
    //DemoBusFlightModel
    NSDictionary *busFlightDictionary = @{@"id": @"1001",
                                          @"station_infos": @[busFlightStationDictionary1,
                                                              busFlightStationDictionary2,
                                                              busFlightStationDictionary3]
                                          };
    
    DemoBusFlightModel *busFlightModel = [DemoBusFlightModel mj_objectWithKeyValues:busFlightDictionary];
    NSLog(@"busFlightModel = %@", busFlightModel);
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
