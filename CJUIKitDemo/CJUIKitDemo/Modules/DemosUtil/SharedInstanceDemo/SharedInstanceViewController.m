//
//  SharedInstanceViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "SharedInstanceViewController.h"
#import "NormalSharedInstanceClass.h"
#import "PerfectSharedInstanceClass.h"
#import "InheritableSharedInstanceClass.h"

#import "SubNormalSharedInstanceClass.h"
#import "SubInheritableSharedInstanceClass.h"

@interface SharedInstanceViewController ()

@end

@implementation SharedInstanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"SharedInstance首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"唯一性问题";
        {
            CQDMModuleModel *toastUtilModule = [[CQDMModuleModel alloc] init];
            toastUtilModule.title = @"NormalSharedInstanceClass(正常的单例)";
            toastUtilModule.selector = @selector(printNormalSharedInstance);
            [sectionDataModel.values addObject:toastUtilModule];
        }
        {
            CQDMModuleModel *toastUtilModule = [[CQDMModuleModel alloc] init];
            toastUtilModule.title = @"PerfectSharedInstanceClass(完善的单例)";
            toastUtilModule.selector = @selector(printPerfectSharedInstance);
            [sectionDataModel.values addObject:toastUtilModule];
        }
        {
            CQDMModuleModel *toastUtilModule = [[CQDMModuleModel alloc] init];
            toastUtilModule.title = @"InheritableSharedInstanceClass(可继承单例的并发测试)";
            toastUtilModule.selector = @selector(printInheritableSharedInstance_inConcurrence);
            [sectionDataModel.values addObject:toastUtilModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"继承问题";
        {
            CQDMModuleModel *toastUtilModule = [[CQDMModuleModel alloc] init];
            toastUtilModule.title = @"NormalSharedInstanceClass(不可继承的单例)";
            toastUtilModule.selector = @selector(printSubNormalSharedInstance);
            [sectionDataModel.values addObject:toastUtilModule];
        }
        {
            CQDMModuleModel *toastUtilModule = [[CQDMModuleModel alloc] init];
            toastUtilModule.title = @"InheritableSharedInstanceClass(可继承的单例)";
            toastUtilModule.selector = @selector(printSubInheritableSharedInstance);
            [sectionDataModel.values addObject:toastUtilModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

- (void)printNormalSharedInstance {
    NormalSharedInstanceClass *single1 = [NormalSharedInstanceClass sharedInstance];
    NSString *singleMessage1 = [NSString stringWithFormat:@"[1]sharedInstance = %@", single1];
    NSLog(@"%@", singleMessage1);
    
    NormalSharedInstanceClass *single2 = [NormalSharedInstanceClass sharedInstance];
    NSString *singleMessage2 = [NSString stringWithFormat:@"[2]sharedInstance = %@", single2];
    NSLog(@"%@", singleMessage2);
    
    NormalSharedInstanceClass *single3 = [[NormalSharedInstanceClass alloc] init];
    NSString *singleMessage3 = [NSString stringWithFormat:@"[3][[xxx alloc] init] = %@", single3];
    NSLog(@"%@", singleMessage3);
    
    NormalSharedInstanceClass *single4 = [single3 copy];
    NSString *singleMessage4 = [NSString stringWithFormat:@"[4]copy = %@", single4];
    NSLog(@"%@", singleMessage4);
}

- (void)printPerfectSharedInstance {
    PerfectSharedInstanceClass *single1 = [PerfectSharedInstanceClass sharedInstance];
    NSString *singleMessage1 = [NSString stringWithFormat:@"[1]sharedInstance = %@", single1];
    NSLog(@"%@", singleMessage1);
    
    PerfectSharedInstanceClass *single2 = [PerfectSharedInstanceClass sharedInstance];
    NSString *singleMessage2 = [NSString stringWithFormat:@"[2]sharedInstance = %@", single2];
    NSLog(@"%@", singleMessage2);
    
    PerfectSharedInstanceClass *single3 = [[PerfectSharedInstanceClass alloc] init];
    NSString *singleMessage3 = [NSString stringWithFormat:@"[3][[xxx alloc] init] = %@", single3];
    NSLog(@"%@", singleMessage3);
    
    PerfectSharedInstanceClass *single4 = [single3 copy];
    NSString *singleMessage4 = [NSString stringWithFormat:@"[4]copy = %@", single4];
    NSLog(@"%@", singleMessage4);
}

/// 测试 InheritableSharedInstanceClass 在并发时候的问题
- (void)printInheritableSharedInstance_inConcurrence {
    InheritableSharedInstanceClass *single1_thread0 = [InheritableSharedInstanceClass sharedInstance];
    NSString *singleMessage1_thread0 = [NSString stringWithFormat:@"[1.0]sharedInstance = %@", single1_thread0];
    NSLog(@"%@", singleMessage1_thread0);
    
    [NSThread detachNewThreadWithBlock:^{
        InheritableSharedInstanceClass *single1_thread1 = [InheritableSharedInstanceClass sharedInstance];
        NSString *singleMessage1_thread1 = [NSString stringWithFormat:@"[1.1]sharedInstance = %@", single1_thread1];
        NSLog(@"%@", singleMessage1_thread1);
    }];
    
    [NSThread detachNewThreadWithBlock:^{
        InheritableSharedInstanceClass *single1_thread2 = [InheritableSharedInstanceClass sharedInstance];
        NSString *singleMessage1_thread2 = [NSString stringWithFormat:@"[1.2]sharedInstance = %@", single1_thread2];
        NSLog(@"%@", singleMessage1_thread2);
    }];
}

- (void)printSubNormalSharedInstance {
    NormalSharedInstanceClass *single1 = [NormalSharedInstanceClass sharedInstance];
    NSString *singleMessage1 = [NSString stringWithFormat:@"[1]super sharedInstance = %@", single1];
    NSLog(@"%@", singleMessage1);
    
    NormalSharedInstanceClass *single2 = [NormalSharedInstanceClass sharedInstance];
    NSString *singleMessage2 = [NSString stringWithFormat:@"[2]super sharedInstance = %@", single2];
    NSLog(@"%@", singleMessage2);
    
    SubNormalSharedInstanceClass *subSingle1 = [SubNormalSharedInstanceClass sharedInstance];
    NSString *subSingleMessage1 = [NSString stringWithFormat:@"[3]sub sharedInstance = %@", subSingle1];
    NSLog(@"%@", subSingleMessage1);
    
    SubNormalSharedInstanceClass *subSingle2 = [SubNormalSharedInstanceClass sharedInstance];
    NSString *subSingleMessage2 = [NSString stringWithFormat:@"[4]sub sharedInstance = %@", subSingle2];
    NSLog(@"%@", subSingleMessage2);
}
    

- (void)printSubInheritableSharedInstance {
    InheritableSharedInstanceClass *single1 = [InheritableSharedInstanceClass sharedInstance];
    NSString *singleMessage1 = [NSString stringWithFormat:@"[1]super sharedInstance = %@", single1];
    NSLog(@"%@", singleMessage1);
    
    InheritableSharedInstanceClass *single2 = [InheritableSharedInstanceClass sharedInstance];
    NSString *singleMessage2 = [NSString stringWithFormat:@"[2]super sharedInstance = %@", single2];
    NSLog(@"%@", singleMessage2);
    
    SubInheritableSharedInstanceClass *subSingle1 = [SubInheritableSharedInstanceClass sharedInstance];
    NSString *subSingleMessage1 = [NSString stringWithFormat:@"[3]sub sharedInstance = %@", subSingle1];
    NSLog(@"%@", subSingleMessage1);
    
    SubInheritableSharedInstanceClass *subSingle2 = [SubInheritableSharedInstanceClass sharedInstance];
    NSString *subSingleMessage2 = [NSString stringWithFormat:@"[4]sub sharedInstance = %@", subSingle2];
    NSLog(@"%@", subSingleMessage2);
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
