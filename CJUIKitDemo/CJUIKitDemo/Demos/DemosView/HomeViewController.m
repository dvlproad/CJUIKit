//
//  HomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HomeViewController.h"

#import "NestedXibViewController.h"
#import "BeChangeViewController.h"

//image
#import "ColorViewController.h"

//UIView
#import "SampleViewController.h"
//ViewDrag
#import "DragViewController.h"
//ViewPopup
#import "PopupInWindowVC.h"
#import "PopupInViewVC.h"
#import "ShowExtendViewVC.h"
#import "ShowDropDownViewController.h"
//ViewAnimate
#import "ViewAnimateViewController.h"

//UIWindow
#import "FloatingWindowViewController.h"
#import "SuspendWindowViewController.h"

#import "ButtonViewController.h"

#import "TextFieldViewController.h"
#import "TextViewController.h"
#import "KeyboardAvoidingViewController.h"

#import "SliderViewController.h"
#import "RangeSliderViewController.h"
#import "SwitchSliderViewController.h"

#import "SearchBarViewController.h"


#import "ImageChangeColorViewController.h"
#import "ImageRotateViewController.h"

#import "NavigationBarViewController.h"
#import "NavigationBarRemoveUnderlineViewController.h"
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
    
    self.navigationItem.title = NSLocalizedString(@"CJBaseUIKit首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    
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
        {
            CJModuleModel *xibModule = [[CJModuleModel alloc] init];
            xibModule.title = @"后视图改变前视图的值的实现事例";
            xibModule.classEntry = [BeChangeViewController class];
            
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
            imageChangeColorModule.title = @"UIImage(改变颜色)";
            imageChangeColorModule.classEntry = [ImageChangeColorViewController class];
            [sectionDataModel.values addObject:imageChangeColorModule];
        }
        {
            CJModuleModel *imageRotateModule = [[CJModuleModel alloc] init];
            imageRotateModule.title = @"UIImage(旋转任意角度)";
            imageRotateModule.classEntry = [ImageRotateViewController class];
            [sectionDataModel.values addObject:imageRotateModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //UIWindow
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIWindow";
        {
            CJModuleModel *FloatingWindowModule = [[CJModuleModel alloc] init];
            FloatingWindowModule.title = @"FloatingWindow（悬浮视图）";
            FloatingWindowModule.classEntry = [FloatingWindowViewController class];
            [sectionDataModel.values addObject:FloatingWindowModule];
        }
        
        {
            CJModuleModel *FloatingWindowModule = [[CJModuleModel alloc] init];
            FloatingWindowModule.title = @"SuspendWindow（悬浮球）";
            FloatingWindowModule.classEntry = [SuspendWindowViewController class];
            [sectionDataModel.values addObject:FloatingWindowModule];
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
            CJModuleModel *animateViewModule = [[CJModuleModel alloc] init];
            animateViewModule.title = @"ViewAnimate (View动画)";
            animateViewModule.classEntry = [ViewAnimateViewController class];
            [sectionDataModel.values addObject:animateViewModule];
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
    
    //UINavigationBar
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UINavigationBar相关";
        {
            CJModuleModel *UINavigationBarModuleModel1 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(导航栏的设置)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarViewController class];
            [sectionDataModel.values addObject:UINavigationBarModuleModel1];
        }
        {
            CJModuleModel *UINavigationBarModuleModel1 = [[CJModuleModel alloc] init];
            UINavigationBarModuleModel1.title = @"UINavigationBar(去除导航条最下面的横线)";
            UINavigationBarModuleModel1.classEntry = [NavigationBarRemoveUnderlineViewController class];
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
        sectionDataModel.theme = @"UIView的子类相关";
        {
            //UIButton
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
            //CJBadgeButton
            CJModuleModel *cjImageViewModuleModel = [[CJModuleModel alloc] init];
            cjImageViewModuleModel.title = @"CJBadgeButton";
            cjImageViewModuleModel.classEntry = [ColorViewController class];
            [sectionDataModel.values addObject:cjImageViewModuleModel];
        }
        {
            //CJSearchBar
            CJModuleModel *cjSearchBarModuleModel = [[CJModuleModel alloc] init];
            cjSearchBarModuleModel.title = @"CJSearchBar";
            cjSearchBarModuleModel.classEntry = [SearchBarViewController class];
            [sectionDataModel.values addObject:cjSearchBarModuleModel];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Slider(滑块)
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Slider(滑块)";
        {
            //Slider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"CJSliderControl";
            sliderModule.classEntry = [SliderViewController class];
            [sectionDataModel.values addObject:sliderModule];
        }
        {
            //RangeSlider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"RangeSlider";
            sliderModule.classEntry = [RangeSliderViewController class];
            [sectionDataModel.values addObject:sliderModule];
        }
        {
            //SwitchSlider
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"SwitchSlider";
            sliderModule.classEntry = [SwitchSliderViewController class];
            [sectionDataModel.values addObject:sliderModule];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = moduleModel.title;
    cell.detailTextLabel.text = moduleModel.content;
    
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
    
    NSArray *noxibViewControllers = @[NSStringFromClass([UIViewController class]),
                                      NSStringFromClass([NavigationBarRemoveUnderlineViewController class]),
                                      NSStringFromClass([FloatingWindowViewController class]),
                                      NSStringFromClass([SuspendWindowViewController class]),
                                      NSStringFromClass([ColorViewController class])
                                    ];
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    
    if ([noxibViewControllers containsObject:clsString])
    {
        viewController = [[classEntry alloc] init];
        if ([clsString isEqualToString:NSStringFromClass([UIViewController class])]) {
            viewController.view.backgroundColor = [UIColor whiteColor];
        }
        
        
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
