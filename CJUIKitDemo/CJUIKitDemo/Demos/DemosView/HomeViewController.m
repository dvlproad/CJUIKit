//
//  HomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HomeViewController.h"

#import "CJModuleModel.h"


#import "NestedXibViewController.h"

#import "SampleViewController.h"
//ViewDrag
#import "DragViewController.h"
//ViewPopup
#import "PopupInWindowVC.h"
#import "PopupInViewVC.h"
#import "ShowExtendViewVC.h"
#import "ShowDropDownViewController.h"

#import "FloatingWindowViewController.h"

#import "ButtonViewController.h"

//image
#import "ImageViewController.h"
#import "QRCodeViewController.h"

#import "TextFieldViewController.h"
#import "TextViewController.h"
#import "KeyboardAvoidingViewController.h"

#import "SliderViewController.h"
#import "RangeSliderViewController.h"
#import "SwitchSliderViewController.h"

#import "SearchBarViewController.h"


#import "ImageChangeColorViewController.h"

#import "NavigationBarViewController.h"
#import "NavigationBarChangeBGViewController.h"
#import "NavigationBarChangePositonViewController.h"

#import "CJMJRefreshViewController.h"


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
            CJModuleModel *xibModule = [[CJModuleModel alloc] init];
            xibModule.title = @"xib";
            xibModule.classEntry = [NestedXibViewController class];
            
            [sectionDataModel.values addObject:xibModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIViewController
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIViewController相关";
        {
            CJModuleModel *ViewCategoryModule = [[CJModuleModel alloc] init];
            ViewCategoryModule.title = @"BackBarButtonItem (返回按钮事件)";
            ViewCategoryModule.classEntry = [SampleViewController class];
            [sectionDataModel.values addObject:ViewCategoryModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //UIView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView相关";
        {
            CJModuleModel *dragViewModule = [[CJModuleModel alloc] init];
            dragViewModule.title = @"Drag And KeepBounds (视图的拖曳和吸附)";
            dragViewModule.classEntry = [DragViewController class];
            [sectionDataModel.values addObject:dragViewModule];
        }
        {
            CJModuleModel *popupInWindowModule = [[CJModuleModel alloc] init];
            popupInWindowModule.title = @"PopupInWindow (弹出到Window)";
            popupInWindowModule.classEntry = [PopupInWindowVC class];
            [sectionDataModel.values addObject:popupInWindowModule];
        }
        {
            CJModuleModel *popupInViewModule = [[CJModuleModel alloc] init];
            popupInViewModule.title = @"PopupInView (弹出到任意View)";
            popupInViewModule.classEntry = [PopupInViewVC class];
            [sectionDataModel.values addObject:popupInViewModule];
        }
        {
            CJModuleModel *showExtendViewModule = [[CJModuleModel alloc] init];
            showExtendViewModule.title = @"ShowExtendView (弹出任意视图)";
            showExtendViewModule.classEntry = [ShowExtendViewVC class];
            [sectionDataModel.values addObject:showExtendViewModule];
        }
        {
            CJModuleModel *showDropDownViewModule = [[CJModuleModel alloc] init];
            showDropDownViewModule.title = @"ShowDropDownView (弹出下拉视图)";
            showDropDownViewModule.classEntry = [ShowDropDownViewController class];
            [sectionDataModel.values addObject:showDropDownViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView的子类相关";
        {
            //CJImageView
            CJModuleModel *cjImageViewModuleModel = [[CJModuleModel alloc] init];
            cjImageViewModuleModel.title = @"CJImageView";
            cjImageViewModuleModel.classEntry = [ImageViewController class];
            [sectionDataModel.values addObject:cjImageViewModuleModel];
        }
        {
            CJModuleModel *buttonModule = [[CJModuleModel alloc] init];
            buttonModule.title = @"UIButton";
            buttonModule.classEntry = [ButtonViewController class];
            [sectionDataModel.values addObject:buttonModule];
        }
        {
            //TextField
            CJModuleModel *textFieldModule = [[CJModuleModel alloc] init];
            textFieldModule.title = @"TextField";
            textFieldModule.classEntry = [TextFieldViewController class];
            [sectionDataModel.values addObject:textFieldModule];
        }
        {
            //TextView
            CJModuleModel *textViewModule = [[CJModuleModel alloc] init];
            textViewModule.title = @"TextView";
            textViewModule.classEntry = [TextViewController class];
            [sectionDataModel.values addObject:textViewModule];
        }
        {
            //Slider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"Slider--CJSliderControl";
            sliderModule.classEntry = [SliderViewController class];
            [sectionDataModel.values addObject:sliderModule];
        }
        {
            //RangeSlider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"Slider--RangeSlider";
            sliderModule.classEntry = [RangeSliderViewController class];
            [sectionDataModel.values addObject:sliderModule];
        }
        {
            //SwitchSlider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"Slider--SwitchSlider";
            sliderModule.classEntry = [SwitchSliderViewController class];
            [sectionDataModel.values addObject:sliderModule];
        }
        {
            //CJSearchBar
            CJModuleModel *cjSearchBarModuleModel = [[CJModuleModel alloc] init];
            cjSearchBarModuleModel.title = @"CJSearchBar";
            cjSearchBarModuleModel.classEntry = [SearchBarViewController class];
            [sectionDataModel.values addObject:cjSearchBarModuleModel];
        }
        {
            //UIImage
            CJModuleModel *UIImageModuleModel = [[CJModuleModel alloc] init];
            UIImageModuleModel.title = @"UIImage";
            UIImageModuleModel.classEntry = [ImageChangeColorViewController class];
            [sectionDataModel.values addObject:UIImageModuleModel];
        }
        {
            CJModuleModel *QRCodeModule = [[CJModuleModel alloc] init];
            QRCodeModule.title = @"QRCode";
            QRCodeModule.classEntry = [QRCodeViewController class];
            [sectionDataModel.values addObject:QRCodeModule];
        }
        
        //UINavigationBar
        {
            CJModuleModel *UINavigationBarModuleModel1 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(导航栏的设置)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarViewController class];
            [sectionDataModel.values addObject:UINavigationBarModuleModel1];
        }
        {
            CJModuleModel *UINavigationBarModuleModel1 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(常见的导航栏背景色改变隐藏)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarChangeBGViewController class];
            [sectionDataModel.values addObject:UINavigationBarModuleModel1];
        }
        {
            CJModuleModel *UINavigationBarModuleModel2 = [[CJModuleModel alloc] init];
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
            CJModuleModel *keyboardAvoidingModuleModel = [[CJModuleModel alloc] init];
            keyboardAvoidingModuleModel.title = @"KeyboardAvoiding";
            keyboardAvoidingModuleModel.classEntry = [KeyboardAvoidingViewController class];
            [sectionDataModel.values addObject:keyboardAvoidingModuleModel];
        }
        {
            CJModuleModel *cjMJRefreshComponentModuleModel = [[CJModuleModel alloc] init];
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
            CJModuleModel *FloatingWindowModule = [[CJModuleModel alloc] init];
            FloatingWindowModule.title = @"FloatingWindow（悬浮视图）";
            FloatingWindowModule.classEntry = [FloatingWindowViewController class];
            [sectionDataModel.values addObject:FloatingWindowModule];
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
    CJModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CJModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
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
    viewController.hidesBottomBarWhenPushed = YES;
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
