//
//  HomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HomeViewController.h"

#import "ModuleModel.h"

#import "ViewCategoryViewController.h"
#import "DragViewController.h"

#import "FloatingWindowViewController.h"

#import "ButtonViewController.h"

//image
#import "ImageViewController.h"
#import "QRCodeViewController.h"

#import "TextFieldViewController.h"
#import "TextViewController.h"
#import "KeyboardAvoidingViewController.h"
#import "SliderViewController.h"
#import "SearchBarViewController.h"


#import "ImageChangeColorViewController.h"

#import "NavigationBarChangeBGViewController.h"
#import "NavigationBarChangePositonViewController.h"
#import "PullScaleTopImageViewController.h"

#import "CJMJRefreshViewController.h"

#import "ProcessLineViewController.h"
#import "CountDownTimeViewController.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Home首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Interface
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Interface相关(xib/storyboard)";
        {
            ModuleModel *xibModule = [[ModuleModel alloc] init];
            xibModule.title = @"xib(待补充)";
            xibModule.classEntry = [UIViewController class];
            
            [sectionDataModel.values addObject:xibModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //ViewCategoryViewController
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView相关";
        {
            ModuleModel *ViewCategoryModule = [[ModuleModel alloc] init];
            ViewCategoryModule.title = @"Drag And KeepBounds 1 (视图的拖曳和吸附)";
            ViewCategoryModule.classEntry = [ViewCategoryViewController class];
            [sectionDataModel.values addObject:ViewCategoryModule];
        }
        {
            ModuleModel *ViewDragCategoryModule = [[ModuleModel alloc] init];
            ViewDragCategoryModule.title = @"Drag And KeepBounds 2 (视图的拖曳和吸附)";
            ViewDragCategoryModule.classEntry = [DragViewController class];
            [sectionDataModel.values addObject:ViewDragCategoryModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView的子类相关";
        {
            //CJImageView
            ModuleModel *cjImageViewModuleModel = [[ModuleModel alloc] init];
            cjImageViewModuleModel.title = @"CJImageView";
            cjImageViewModuleModel.classEntry = [ImageViewController class];
            [sectionDataModel.values addObject:cjImageViewModuleModel];
        }
        {
            ModuleModel *buttonModule = [[ModuleModel alloc] init];
            buttonModule.title = @"UIButton";
            buttonModule.classEntry = [ButtonViewController class];
            [sectionDataModel.values addObject:buttonModule];
        }
        {
            //CJSelectTextTextField
            ModuleModel *CJSelectTextTextFieldModuleModel = [[ModuleModel alloc] init];
            CJSelectTextTextFieldModuleModel.title = @"CJSelectTextTextField";
            CJSelectTextTextFieldModuleModel.classEntry = [TextFieldViewController class];
            [sectionDataModel.values addObject:CJSelectTextTextFieldModuleModel];
        }
        {
            //CJTextView
            ModuleModel *cjTextViewModuleModel = [[ModuleModel alloc] init];
            cjTextViewModuleModel.title = @"CJTextView";
            cjTextViewModuleModel.classEntry = [TextViewController class];
            [sectionDataModel.values addObject:cjTextViewModuleModel];
        }
        {
            //CJSlider
            ModuleModel *cjSliderModuleModel = [[ModuleModel alloc] init];
            cjSliderModuleModel.title = @"CJSliderControl";
            cjSliderModuleModel.classEntry = [SliderViewController class];
            [sectionDataModel.values addObject:cjSliderModuleModel];
        }
        {
            //CJSearchBar
            ModuleModel *cjSearchBarModuleModel = [[ModuleModel alloc] init];
            cjSearchBarModuleModel.title = @"CJSearchBar";
            cjSearchBarModuleModel.classEntry = [SearchBarViewController class];
            [sectionDataModel.values addObject:cjSearchBarModuleModel];
        }
        {
            //UIImage
            ModuleModel *UIImageModuleModel = [[ModuleModel alloc] init];
            UIImageModuleModel.title = @"UIImage";
            UIImageModuleModel.classEntry = [ImageChangeColorViewController class];
            [sectionDataModel.values addObject:UIImageModuleModel];
        }
        {
            ModuleModel *QRCodeModule = [[ModuleModel alloc] init];
            QRCodeModule.title = @"QRCode";
            QRCodeModule.classEntry = [QRCodeViewController class];
            [sectionDataModel.values addObject:QRCodeModule];
        }
        {
            //UINavigationBar
            ModuleModel *UINavigationBarModuleModel1 = [[ModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(常见的导航栏背景色改变隐藏)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarChangeBGViewController class];
            [sectionDataModel.values addObject:UINavigationBarModuleModel1];
        }
        {
            ModuleModel *UINavigationBarModuleModel2 = [[ModuleModel alloc] init];
            UINavigationBarModuleModel2.title = @"UINavigationBar(类似斗鱼的导航栏移动隐藏)";
            UINavigationBarModuleModel2.classEntry = [NavigationBarChangePositonViewController class];
            [sectionDataModel.values addObject:UINavigationBarModuleModel2];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"其他";
        {
            ModuleModel *keyboardAvoidingModuleModel = [[ModuleModel alloc] init];
            keyboardAvoidingModuleModel.title = @"KeyboardAvoiding";
            keyboardAvoidingModuleModel.classEntry = [KeyboardAvoidingViewController class];
            [sectionDataModel.values addObject:keyboardAvoidingModuleModel];
        }
        {
            ModuleModel *cjMJRefreshComponentModuleModel = [[ModuleModel alloc] init];
            cjMJRefreshComponentModuleModel.title = @"CJMJRefreshComponent";
            cjMJRefreshComponentModuleModel.classEntry = [CJMJRefreshViewController class];
            [sectionDataModel.values addObject:cjMJRefreshComponentModuleModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"其他";
        {
            //FloatingWindow
            ModuleModel *FloatingWindowModule = [[ModuleModel alloc] init];
            FloatingWindowModule.title = @"FloatingWindow（悬浮视图）";
            FloatingWindowModule.classEntry = [FloatingWindowViewController class];
            [sectionDataModel.values addObject:FloatingWindowModule];
        }
        {
            //PullScaleTopImageViewController
            ModuleModel *pullScaleTopImageModuleModel = [[ModuleModel alloc] init];
            pullScaleTopImageModuleModel.title = @"顶部图片下拉放大，上拉缩小";
            pullScaleTopImageModuleModel.classEntry = [PullScaleTopImageViewController class];
            [sectionDataModel.values addObject:pullScaleTopImageModuleModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //QuartzCore
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"QuartzCore相关(如画线)";
        {
            //ProcessLineViewController
            ModuleModel *processLineViewModule = [[ModuleModel alloc] init];
            processLineViewModule.title = @"流程线(ProcessLineView)";
            processLineViewModule.classEntry = [ProcessLineViewController class];
            [sectionDataModel.values addObject:processLineViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //其他
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"其他";
        {
            //CountDownTimeViewController
            ModuleModel *countDownTimeModule = [[ModuleModel alloc] init];
            countDownTimeModule.title = @"倒计时 CountDownTime";
            countDownTimeModule.classEntry = [CountDownTimeViewController class];
            [sectionDataModel.values addObject:countDownTimeModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    ModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    ModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    Class classEntry = moduleModel.classEntry;
    NSString *nibName = NSStringFromClass(moduleModel.classEntry);
    
    
    UIViewController *viewController = nil;
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    if ([clsString isEqualToString:NSStringFromClass([UIViewController class])])
    {
        viewController = [[classEntry alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        
    } else if ([classEntry isSubclassOfClass:[NavigationBarBaseViewController class]]) {
        viewController = [[classEntry alloc] initWithNibName:@"NavigationBarBaseViewController" bundle:nil];
        
    } else {
        viewController = [[classEntry alloc] initWithNibName:nibName bundle:nil];
    }
    viewController.title = NSLocalizedString(moduleModel.title, nil);
    [self.navigationController pushViewController:viewController animated:YES];
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
