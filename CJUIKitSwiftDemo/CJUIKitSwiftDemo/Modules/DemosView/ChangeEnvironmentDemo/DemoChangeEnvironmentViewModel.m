//
//  DemoChangeEnvironmentViewModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/14.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "DemoChangeEnvironmentViewModel.h"
#import <CJPopupView/UIButton+CJPopoverListView.h>
//#import <CJDemoNetwork/CJDemoNetworkClient.h>

@interface DemoChangeEnvironmentViewModel ()

/**< 所有环境的描述 */
@property (nonatomic, strong, readonly) NSArray<NSString *> *environmentDescriptions;
/**< 当前环境索引 */
@property (nonatomic, assign, readonly) NSInteger currentEnvironmentIndex;

@end


@implementation DemoChangeEnvironmentViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _environmentDescriptions = @[@"Product(生产环境)",
                                     @"PreProduct(预生产环境)",
                                     @"Develop1(开发环境1)",
                                     @"Develop2(开发环境2)"
                                     ];
    }
    return self;
}

- (void)setChangeEnvironmentButton:(UIButton *)changeEnvironmentButton {
    _changeEnvironmentButton = changeEnvironmentButton;
    
    [changeEnvironmentButton addTarget:self action:@selector(changeEnvironmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger lastEnvironmentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:@"demo_lastEnvironmentIndex"] integerValue];
    [self updateChangeEnvironmentButtonWithEnvironmentIndex:lastEnvironmentIndex];
}

///更新改变环境按钮的显示值
- (void)updateChangeEnvironmentButtonWithEnvironmentIndex:(NSInteger)environmentIndex {
    if (environmentIndex < 0 || environmentIndex >= self.environmentDescriptions.count) {
        environmentIndex = 0;
    }
    _currentEnvironmentIndex = environmentIndex;
    
    NSString *currentEnvironmentDescription = self.environmentDescriptions[environmentIndex];
    [self.changeEnvironmentButton setTitle:currentEnvironmentDescription forState:UIControlStateNormal];
}

///改变环境按钮的事件
- (void)changeEnvironmentButtonAction:(UIButton *)button {
    __weak typeof(self)weakSelf = self;
    [button cj_showDownPopoverListViewWithTitles:self.environmentDescriptions selectRowBlock:^(NSInteger selectedIndex) {
        [weakSelf updateCurrentEnvironmentIndex:selectedIndex];
    }];
}

- (void)updateCurrentEnvironmentIndex:(NSInteger)currentEnvironmentIndex {
    [[NSUserDefaults standardUserDefaults] setObject:@(currentEnvironmentIndex) forKey:@"demo_lastEnvironmentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //更新改变环境按钮的显示值
    [self updateChangeEnvironmentButtonWithEnvironmentIndex:currentEnvironmentIndex];
    
    //更新网络环境
    NSArray *networkEnvironments = @[@"xxx.xxx.com",
                                     @"xxxpre.xxx.com",
                                     @"xxxtest.xxx.com",
                                     @"xxxtest02.xxx.com"
                                     ];
    //DemoNetworkEnvironmentModel *environmentModel = [[DemoNetworkEnvironmentModel alloc] init];
    //environmentModel.schema = kSchema;
    //environmentModel.ip = KDefaultIP;
    //environmentModel.domain = kDefaultDomain;
    //[DemoNetworkClient sharedInstance].environmentModel = environmentModel;
    if (currentEnvironmentIndex < 0 || currentEnvironmentIndex >= networkEnvironments.count) {
        currentEnvironmentIndex = 0;
    }
    NSString *newDomain = networkEnvironments[currentEnvironmentIndex];
    //[CJDemoNetworkClient sharedInstance].environmentModel.domain = newDomain;
    
    //环境改变完之后的回调
    if (self.completeChangeEnvironment) {
        self.completeChangeEnvironment(currentEnvironmentIndex);
    }
}

@end
