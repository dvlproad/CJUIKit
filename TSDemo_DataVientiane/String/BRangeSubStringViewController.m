//
//  BRangeSubStringViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BRangeSubStringViewController.h"
#import <CJDataVientianeSDK/CJSubStringUtil.h>

@interface BRangeSubStringViewController ()

@end

@implementation BRangeSubStringViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"暂无示例，之前的代码和 CMaxSubStringViewController1 的完全重复了", nil);
    self.fixTextViewHeight = 60;  // 固定textView的视图高度（该值大于44才生效），默认固定为44
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"暂无示例，之前的代码和 CMaxSubStringViewController1 的完全重复了";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"";
            dealTextModel.text = @"";
            dealTextModel.hopeResultText = @"";
            dealTextModel.actionTitle = @"";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                [CJSubStringUtil substringExceptRange:NSMakeRange(1, 0) forString:@"1234567890"];
                [CJSubStringUtil substringExceptRange:NSMakeRange(1, 1) forString:@"1234567890"];
                [CJSubStringUtil substringExceptRange:NSMakeRange(1, 9) forString:@"1234567890"];
                
                
                NSString *maxSubstring = nil;
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
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
