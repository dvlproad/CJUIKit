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
#import "TextFieldViewController.h"
#import "TestTextFieldOffsetViewController.h"
#import "TextViewController.h"
#import "SliderHomeViewController.h"
#import "SearchBarViewController.h"

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
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"AutoLayout";
        {
            CJModuleModel *autoLayoutModule = [[CJModuleModel alloc] init];
            autoLayoutModule.title = @"AutoLayout";
            autoLayoutModule.classEntry = [AutoLayoutHomeViewController class];
            
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // 测试push UINavigationController
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Push";
        {
            CJModuleModel *autoLayoutModule = [[CJModuleModel alloc] init];
            autoLayoutModule.title = @"testPushNavigationController";
            autoLayoutModule.selector = @selector(testPushNavigationController);
            
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Interface
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Interface相关(xib/storyboard)";
        {
            CJModuleModel *xibModule = [[CJModuleModel alloc] init];
            xibModule.title = @"xib";
            xibModule.classEntry = [NestedXibViewController class];
            xibModule.isCreateByXib = YES;
            
            [sectionDataModel.values addObject:xibModule];
        }
        {
            CJModuleModel *xibModule = [[CJModuleModel alloc] init];
            xibModule.title = @"后视图改变前视图的值的实现事例";
            xibModule.classEntry = [BeChangeViewController class];
            xibModule.isCreateByXib = NO;
            
            [sectionDataModel.values addObject:xibModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIImage
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIImage相关";
        {
            CJModuleModel *imageChangeColorModule = [[CJModuleModel alloc] init];
            imageChangeColorModule.title = @"UIImage相关";
            imageChangeColorModule.classEntry = [ImageHomeViewController class];
            [sectionDataModel.values addObject:imageChangeColorModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //UIWindow
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIWindow";
        {
            CJModuleModel *floatingWindowModule = [[CJModuleModel alloc] init];
            floatingWindowModule.title = @"FloatingWindow（悬浮视图）";
            floatingWindowModule.classEntry = [FloatingWindowViewController class];
            floatingWindowModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:floatingWindowModule];
        }
        
        {
            CJModuleModel *floatingWindowModule = [[CJModuleModel alloc] init];
            floatingWindowModule.title = @"SuspendWindow（悬浮球）";
            floatingWindowModule.classEntry = [SuspendWindowViewController class];
            floatingWindowModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:floatingWindowModule];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView相关";
        {
            CJModuleModel *dragViewModule = [[CJModuleModel alloc] init];
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
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UINavigationBar相关";
        {
            CJModuleModel *navigationBarModule = [[CJModuleModel alloc] init];
            navigationBarModule.title = @"UINavigationBar(导航栏的设置)";
            navigationBarModule.classEntry = [NavigationBarHomeViewController class];
            navigationBarModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:navigationBarModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView的子类相关";
        {
            //UIButton
            CJModuleModel *buttonModule = [[CJModuleModel alloc] init];
            buttonModule.title = @"UIButton";
            buttonModule.classEntry = [ButtonHomeViewController class];
            buttonModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:buttonModule];
        }
        {
            //TextField
            CJModuleModel *textFieldModule = [[CJModuleModel alloc] init];
            textFieldModule.title = @"TextField";
            textFieldModule.classEntry = [TextFieldViewController class];
            textFieldModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:textFieldModule];
        }
        {
            //TextField
            CJModuleModel *textFieldModule = [[CJModuleModel alloc] init];
            textFieldModule.title = @"TextFieldOffset";
            textFieldModule.classEntry = [TestTextFieldOffsetViewController class];
            textFieldModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:textFieldModule];
        }
        {
            //TextView
            CJModuleModel *textViewModule = [[CJModuleModel alloc] init];
            textViewModule.title = @"TextView";
            textViewModule.classEntry = [TextViewController class];
            textViewModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:textViewModule];
        }
        {
            //CJBadgeButton
            CJModuleModel *badgeButtonModule = [[CJModuleModel alloc] init];
            badgeButtonModule.title = @"CJBadgeButton";
            badgeButtonModule.classEntry = [ColorViewController class];
            badgeButtonModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:badgeButtonModule];
        }
        {
            //CJSearchBar
            CJModuleModel *cjSearchBarModuleModel = [[CJModuleModel alloc] init];
            cjSearchBarModuleModel.title = @"CJSearchBar";
            cjSearchBarModuleModel.classEntry = [SearchBarViewController class];
            [sectionDataModel.values addObject:cjSearchBarModuleModel];
        }
        
        {
            //UISlider
            CJModuleModel *cjSearchBarModuleModel = [[CJModuleModel alloc] init];
            cjSearchBarModuleModel.title = @"UISlider";
            cjSearchBarModuleModel.classEntry = [SliderHomeViewController class];
            cjSearchBarModuleModel.isCreateByXib = NO;
            [sectionDataModel.values addObject:cjSearchBarModuleModel];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Cell
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Cell相关";
        {
            CJModuleModel *cellModule = [[CJModuleModel alloc] init];
            cellModule.title = @"BaseTableViewCell";
            cellModule.classEntry = [BaseTableViewCellViewController class];
            [sectionDataModel.values addObject:cellModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIScrollView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIScrollView相关";
        {
            CJModuleModel *scrollViewModule = [[CJModuleModel alloc] init];
            scrollViewModule.title = @"ScrollView(纯代码创建1)";
            scrollViewModule.classEntry = [CodeScrollViewController1 class];
            [sectionDataModel.values addObject:scrollViewModule];
        }
        {
            CJModuleModel *scrollViewModule = [[CJModuleModel alloc] init];
            scrollViewModule.title = @"ScrollView(纯代码创建3)";
            scrollViewModule.classEntry = [CodeScrollViewController3 class];
            [sectionDataModel.values addObject:scrollViewModule];
        }
        {
            CJModuleModel *scrollViewModule = [[CJModuleModel alloc] init];
            scrollViewModule.title = @"KeyboardAvoiding";
            scrollViewModule.classEntry = [KeyboardAvoidingViewController class];
            [sectionDataModel.values addObject:scrollViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIViewController
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIViewController相关";
        {
            CJModuleModel *backModule = [[CJModuleModel alloc] init];
            backModule.title = @"BackBarButtonItem (系统返回按钮事件)";
            backModule.classEntry = [BackSystemItemViewController class];
            backModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:backModule];
        }
        {
            CJModuleModel *backModule = [[CJModuleModel alloc] init];
            backModule.title = @"BackBarButtonItem (自定义返回按钮事件)";
            backModule.classEntry = [BackCustomItemViewController class];
            backModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:backModule];
        }
        {
            CJModuleModel *systemComposeViewModule = [[CJModuleModel alloc] init];
            systemComposeViewModule.title = @"SystemComposeViewController";
            systemComposeViewModule.classEntry = [SystemComposeViewController class];
            systemComposeViewModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:systemComposeViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }

    
    //ChangeEnvironment
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"ChangeEnvironment相关";
        {
            CJModuleModel *xibModule = [[CJModuleModel alloc] init];
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
