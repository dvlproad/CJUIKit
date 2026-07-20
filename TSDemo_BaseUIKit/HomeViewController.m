//
//  HomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HomeViewController.h"

#import "AutoLayoutHomeViewController.h"
#import "NestedXibViewController.h"
#import "BeChangeViewController.h"

//image
#import "ColorViewController.h"

//UIView
#import "ViewHomeViewController.h"

#import "ButtonHomeViewController.h"
#import "TextFieldHomeViewController.h" // TextField + TextView
#import "SliderHomeViewController.h"

//Cell
#import "BaseTableViewCellViewController.h"

//ScrollView
#import "CodeScrollViewController1.h"
#import "CodeScrollViewController3.h"
#import "KeyboardAvoidingViewController.h"

//UIWindow
#import "FloatingWindowViewController.h"
#import "SuspendWindowViewController.h"

#import "NavigationBarHomeViewController.h"
#import "ImageHomeViewController.h"


//UIViewController
#import "BackSystemItemViewController.h"
#import "BackCustomItemViewController.h"
#import "SystemComposeViewController.h"

//ChangeEnvironment
#import "ChangeEnvHomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"CJBaseUIKit首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //AutoLayout
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"AutoLayout";
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"AutoLayout";
            autoLayoutModule.classEntry = [AutoLayoutHomeViewController class];
            
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // 测试push UINavigationController
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Push";
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"testPushNavigationController";
            autoLayoutModule.selector = @selector(testPushNavigationController);
            
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Interface
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Interface相关(xib/storyboard)";
        {
            CQDMModuleModel *xibModule = [[CQDMModuleModel alloc] init];
            xibModule.title = @"xib";
            xibModule.classEntry = [NestedXibViewController class];
            xibModule.isCreateByXib = YES;
            
            [sectionDataModel.values addObject:xibModule];
        }
        {
            CQDMModuleModel *xibModule = [[CQDMModuleModel alloc] init];
            xibModule.title = @"后视图改变前视图的值的实现事例";
            xibModule.classEntry = [BeChangeViewController class];
            xibModule.isCreateByXib = NO;
            
            [sectionDataModel.values addObject:xibModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIImage
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIImage相关";
        {
            CQDMModuleModel *imageChangeColorModule = [[CQDMModuleModel alloc] init];
            imageChangeColorModule.title = @"UIImage相关";
            imageChangeColorModule.classEntry = [ImageHomeViewController class];
            [sectionDataModel.values addObject:imageChangeColorModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //UIWindow
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIWindow";
        {
            CQDMModuleModel *floatingWindowModule = [[CQDMModuleModel alloc] init];
            floatingWindowModule.title = @"FloatingWindow（悬浮视图）";
            floatingWindowModule.classEntry = [FloatingWindowViewController class];
            floatingWindowModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:floatingWindowModule];
        }
        
        {
            CQDMModuleModel *floatingWindowModule = [[CQDMModuleModel alloc] init];
            floatingWindowModule.title = @"SuspendWindow（悬浮球）";
            floatingWindowModule.classEntry = [SuspendWindowViewController class];
            floatingWindowModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:floatingWindowModule];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIView
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView相关";
        {
            CQDMModuleModel *dragViewModule = [[CQDMModuleModel alloc] init];
            dragViewModule.title = @"UIView首页(Drag+Popup+Animate)";
            dragViewModule.content = @"(Drag+Popup+Animate)";
            dragViewModule.classEntry = [ViewHomeViewController class];
            dragViewModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:dragViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UINavigationBar
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UINavigationBar相关";
        {
            CQDMModuleModel *navigationBarModule = [[CQDMModuleModel alloc] init];
            navigationBarModule.title = @"UINavigationBar(导航栏的设置)";
            navigationBarModule.classEntry = [NavigationBarHomeViewController class];
            navigationBarModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:navigationBarModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView的子类相关";
        {
            //UIButton
            CQDMModuleModel *buttonModule = [[CQDMModuleModel alloc] init];
            buttonModule.title = @"UIButton";
            buttonModule.classEntry = [ButtonHomeViewController class];
            [sectionDataModel.values addObject:buttonModule];
        }
        {
            // TextField + TextView
            CQDMModuleModel *textInputModule = [[CQDMModuleModel alloc] init];
            textInputModule.title = @"TextField + TextView";
            textInputModule.classEntry = [TextFieldHomeViewController class];
            [sectionDataModel.values addObject:textInputModule];
        }
        
        {
            //CJBadgeButton
            CQDMModuleModel *badgeButtonModule = [[CQDMModuleModel alloc] init];
            badgeButtonModule.title = @"CJBadgeButton";
            badgeButtonModule.classEntry = [ColorViewController class];
            [sectionDataModel.values addObject:badgeButtonModule];
        }
        
        {
            //UISlider
            CQDMModuleModel *sliderModule = [[CQDMModuleModel alloc] init];
            sliderModule.title = @"UISlider";
            sliderModule.classEntry = [SliderHomeViewController class];
            [sectionDataModel.values addObject:sliderModule];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Cell
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Cell相关";
        {
            CQDMModuleModel *cellModule = [[CQDMModuleModel alloc] init];
            cellModule.title = @"BaseTableViewCell";
            cellModule.classEntry = [BaseTableViewCellViewController class];
            [sectionDataModel.values addObject:cellModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIScrollView
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIScrollView相关";
        {
            CQDMModuleModel *scrollViewModule = [[CQDMModuleModel alloc] init];
            scrollViewModule.title = @"ScrollView(纯代码创建1)";
            scrollViewModule.classEntry = [CodeScrollViewController1 class];
            [sectionDataModel.values addObject:scrollViewModule];
        }
        {
            CQDMModuleModel *scrollViewModule = [[CQDMModuleModel alloc] init];
            scrollViewModule.title = @"ScrollView(纯代码创建3)";
            scrollViewModule.classEntry = [CodeScrollViewController3 class];
            [sectionDataModel.values addObject:scrollViewModule];
        }
        {
            CQDMModuleModel *scrollViewModule = [[CQDMModuleModel alloc] init];
            scrollViewModule.title = @"KeyboardAvoiding";
            scrollViewModule.classEntry = [KeyboardAvoidingViewController class];
            [sectionDataModel.values addObject:scrollViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIViewController
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIViewController相关";
        {
            CQDMModuleModel *backModule = [[CQDMModuleModel alloc] init];
            backModule.title = @"BackBarButtonItem (系统返回按钮事件)";
            backModule.classEntry = [BackSystemItemViewController class];
            backModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:backModule];
        }
        {
            CQDMModuleModel *backModule = [[CQDMModuleModel alloc] init];
            backModule.title = @"BackBarButtonItem (自定义返回按钮事件)";
            backModule.classEntry = [BackCustomItemViewController class];
            backModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:backModule];
        }
        {
            CQDMModuleModel *systemComposeViewModule = [[CQDMModuleModel alloc] init];
            systemComposeViewModule.title = @"SystemComposeViewController";
            systemComposeViewModule.classEntry = [SystemComposeViewController class];
            systemComposeViewModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:systemComposeViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }

    
    //ChangeEnvironment
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"ChangeEnvironment相关";
        {
            CQDMModuleModel *xibModule = [[CQDMModuleModel alloc] init];
            xibModule.title = @"ChangeEnvironment(改变网络环境)";
            xibModule.classEntry = [ChangeEnvHomeViewController class];
            [sectionDataModel.values addObject:xibModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}


- (void)testPushNavigationController {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"测试";
    viewController.view.backgroundColor = [UIColor yellowColor];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    if (self.navigationController) {
        //不能push navigationController
//        [self.navigationController pushViewController:navigationController animated:YES];
    }
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
