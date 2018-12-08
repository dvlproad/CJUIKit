//
//  NSObjectCJHelperViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "NSObjectCJHelperViewController.h"

@interface NSObjectCJHelperViewController () {
    
}
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end

@implementation NSObjectCJHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"StringEvent首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Toast
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"字符串相关";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"控制台输出 [NSNull null] 的值";
            toastModule.actionBlock = ^{
                NSNull *string1 = [NSNull null];
                NSLog(@"[NSNull null] = %@", string1);
                
                NSString *string2 = NSStringFromClass([NSNull class]);
                NSLog(@"NSStringFromClass([NSNull class] = %@", string2);
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"字符串判空，调用实例，无法正确判断";
            toastModule.actionBlock = ^{
//                NSString *string;
//                NSLog(@"%@ isEmpty == %@", string, [string cj_isEmpty] ? @"YES" : @"NO");
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"字符串判空，调用类方法，可以正确判断";
            toastModule.actionBlock = ^{
                NSString *string;
                NSLog(@"%@ isEmpty == %@", string, [NSObjectCJHelper isEmptyForObject:string] ? @"YES" : @"NO");
                
//                NSString *string = @"";
//                NSLog(@"%@ isEmpty == %@", string, [string cj_isEmpty] ? @"YES" : @"NO");
            };
            [sectionDataModel.values addObject:toastModule];
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
