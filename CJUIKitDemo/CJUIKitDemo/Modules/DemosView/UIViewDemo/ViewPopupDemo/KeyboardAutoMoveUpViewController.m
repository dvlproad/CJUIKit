//
//  KeyboardAutoMoveUpViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "KeyboardAutoMoveUpViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <CQDemoKit/CJUIKitToastUtil.h>
#import "UIView+CJPopupInView.h"
#import "UIView+CJAutoMoveUp.h"

#import "CQUpdateContentPopupView.h"

@interface KeyboardAutoMoveUpViewController () {
    
}
@property (nonatomic, strong) UITextField *autoMoveUpView;

@end

@implementation KeyboardAutoMoveUpViewController


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    [self.autoMoveUpView cj_registerKeyboardNotificationWithAutoMoveUpSpacing:0 hasSpacing:YES];
    __weak typeof(self)weakSelf = self;
    [self.autoMoveUpView cj_registerKeyboardNotificationWithWillShowBlock:nil willHideBlock:nil willChangeFrameBlock:^(CGFloat keyboardHeight, CGFloat keyboardTopY, CGFloat duration) {
        [weakSelf.autoMoveUpView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.view).offset(-keyboardHeight);
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"伴随键盘弹出", nil);
    
    
    UITextField *autoMoveUpView = [UITextField new];
    autoMoveUpView.placeholder = @"本视图中的视图自动上移";
    autoMoveUpView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:autoMoveUpView];
    [autoMoveUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(20);
        make.height.mas_equalTo(@44);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide).offset(-60);
    }];
    self.autoMoveUpView = autoMoveUpView;
    
    
    [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    
    // 弹出到屏幕底部+自动上移
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"弹出到屏幕底部+自动上移";
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"底部(弹出的视图在键盘弹出时候能够自动上移)";
            autoLayoutModule.actionBlock = ^{
                CQUpdateContentPopupView *popupView = [[CQUpdateContentPopupView alloc] init];
                [popupView setupTitle:NSLocalizedString(@"编辑昵称", nil) placeholder:@"请输入" updateCompleteBlock:^(NSString * _Nonnull bText) {
                    NSString *message = [NSString stringWithFormat:@"新内容为%@", bText];
                    [CJUIKitToastUtil showMessage:message];
                    [popupView cj_hidePopupView];
                }];
                [popupView cj_registerKeyboardNotificationWithAutoMoveUpSpacing:0 hasSpacing:NO];
                
                CGFloat popupViewHeight = CGRectGetHeight(popupView.frame);
                UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
                [popupView cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:UIEdgeInsetsZero blankBGColor:blankBGColor showComplete:^{
                    NSLog(@"显示完成");
                    
                } tapBlankComplete:^{
                    NSLog(@"点击背景完成");
                    [popupView cj_hidePopupView];
                }];
            };
            [sectionDataModel.values addObject:autoLayoutModule];
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
