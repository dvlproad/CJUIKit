//
//  ValidateStringViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ValidateStringViewController.h"
#import "NSString+CJValidate.h"

typedef NS_ENUM(NSUInteger, ValidateStringType) {
    ValidateStringTypeNone = 0,     /**< 不验证 */
    ValidateStringTypeEmail,        /**< 邮箱 */
    ValidateStringTypePhone,        /**< 手机号码 */
    ValidateStringTypeCarNo,        /**< 车牌号 */
    ValidateStringTypeCarType,      /**< 车型 */
    ValidateStringTypeUserName,     /**< 用户名 */
    ValidateStringTypePassword,     /**< 密码 */
    ValidateStringTypeNickname,     /**< 昵称 */
    ValidateStringTypeIdentityCard, /**< 身份证号 */
};

@interface ValidateStringViewController ()

@end

@implementation ValidateStringViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"字符串验证", nil);
    self.fixCellResultLableWidth = 60;  // 固定result的视图宽度（该值大于20才生效），默认为0<20，表示自适应宽度
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 字符串验证
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"字符串验证";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"18012345678";
            dealTextModel.hopeResultText = @"YES";
            dealTextModel.actionTitle = @"验证手机号";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                BOOL success = [oldString cj_validateMobile:CJAreaTypeMainland];
                return success ? @"YES" : @"NO";
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
