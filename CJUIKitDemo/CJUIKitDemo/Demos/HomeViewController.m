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
#import "ImageViewController.h"
#import "TextFieldViewController.h"
#import "TextViewController.h"
#import "ScrollViewController.h"
#import "TableViewController.h"
#import "KeyboardAvoidingViewController.h"
#import "SliderViewController.h"
#import "SearchBarViewController.h"


#import "ImageChangeColorViewController.h"

#import "NavigationBarChangeBGViewController.h"
#import "NavigationBarChangePositonViewController.h"
#import "PullScaleTopImageViewController.h"

#import "CJMJRefreshViewController.h"

#import "ProcessLineViewController.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Home首页", nil);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.datas = [[NSMutableArray alloc] init];
    self.indexTitles = [[NSMutableArray alloc] init];
    
    //ViewCategoryViewController
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        ModuleModel *ViewCategoryModule = [[ModuleModel alloc] init];
        ViewCategoryModule.title = @"Drag And KeepBounds 1 (视图的拖曳和吸附)";
        ViewCategoryModule.classEntry = [ViewCategoryViewController class];
        [array addObject:ViewCategoryModule];
        
        ModuleModel *ViewDragCategoryModule = [[ModuleModel alloc] init];
        ViewDragCategoryModule.title = @"Drag And KeepBounds 2 (视图的拖曳和吸附)";
        ViewDragCategoryModule.classEntry = [DragViewController class];
        [array addObject:ViewDragCategoryModule];
        
        [self.datas addObject:array];
        [self.indexTitles addObject:@"UIView相关"];
    }
    
    
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        //CJImageView
        ModuleModel *cjImageViewModuleModel = [[ModuleModel alloc] init];
        cjImageViewModuleModel.title = @"CJImageView";
        cjImageViewModuleModel.classEntry = [ImageViewController class];
        [array addObject:cjImageViewModuleModel];
        
        ModuleModel *buttonModule = [[ModuleModel alloc] init];
        buttonModule.title = @"UIButton";
        buttonModule.classEntry = [ButtonViewController class];
        [array addObject:buttonModule];
        
        //CJSelectTextTextField
        ModuleModel *CJSelectTextTextFieldModuleModel = [[ModuleModel alloc] init];
        CJSelectTextTextFieldModuleModel.title = @"CJSelectTextTextField";
        CJSelectTextTextFieldModuleModel.classEntry = [TextFieldViewController class];
        [array addObject:CJSelectTextTextFieldModuleModel];
        
        //CJTextView
        ModuleModel *cjTextViewModuleModel = [[ModuleModel alloc] init];
        cjTextViewModuleModel.title = @"CJTextView";
        cjTextViewModuleModel.classEntry = [TextViewController class];
        [array addObject:cjTextViewModuleModel];
        
        ModuleModel *cjScrollViewModuleModel = [[ModuleModel alloc] init];
        cjScrollViewModuleModel.title = @"用代码创建的CJScrollView";
        cjScrollViewModuleModel.classEntry = [ScrollViewController class];
        [array addObject:cjScrollViewModuleModel];
        
        ModuleModel *TableViewModule = [[ModuleModel alloc] init];
        TableViewModule.title = @"TableView";
        TableViewModule.classEntry = [TableViewController class];
        [array addObject:TableViewModule];
        
        //CJSlider
        ModuleModel *cjSliderModuleModel = [[ModuleModel alloc] init];
        cjSliderModuleModel.title = @"CJSliderControl";
        cjSliderModuleModel.classEntry = [SliderViewController class];
        [array addObject:cjSliderModuleModel];
        
        //CJSearchBar
        ModuleModel *cjSearchBarModuleModel = [[ModuleModel alloc] init];
        cjSearchBarModuleModel.title = @"CJSearchBar";
        cjSearchBarModuleModel.classEntry = [SearchBarViewController class];
        [array addObject:cjSearchBarModuleModel];
        
        ModuleModel *UIImageModuleModel = [[ModuleModel alloc] init];
        UIImageModuleModel.title = @"UIImage";
        UIImageModuleModel.classEntry = [ImageChangeColorViewController class];
        [array addObject:UIImageModuleModel];
        
        //UINavigationBar
        ModuleModel *UINavigationBarModuleModel1 = [[ModuleModel alloc] init];
        UINavigationBarModuleModel1.title = @"UINavigationBar(常见的导航栏背景色改变隐藏)";
        UINavigationBarModuleModel1.classEntry = [NavigationBarChangeBGViewController class];
        [array addObject:UINavigationBarModuleModel1];
        
        ModuleModel *UINavigationBarModuleModel2 = [[ModuleModel alloc] init];
        UINavigationBarModuleModel2.title = @"UINavigationBar(类似斗鱼的导航栏移动隐藏)";
        UINavigationBarModuleModel2.classEntry = [NavigationBarChangePositonViewController class];
        [array addObject:UINavigationBarModuleModel2];
        
        [self.datas addObject:array];
        [self.indexTitles addObject:@"UIView的子类相关"];
    }
    
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        ModuleModel *keyboardAvoidingModuleModel = [[ModuleModel alloc] init];
        keyboardAvoidingModuleModel.title = @"KeyboardAvoiding";
        keyboardAvoidingModuleModel.classEntry = [KeyboardAvoidingViewController class];
        [array addObject:keyboardAvoidingModuleModel];
        
        ModuleModel *cjMJRefreshComponentModuleModel = [[ModuleModel alloc] init];
        cjMJRefreshComponentModuleModel.title = @"CJMJRefreshComponent";
        cjMJRefreshComponentModuleModel.classEntry = [CJMJRefreshViewController class];
        [array addObject:cjMJRefreshComponentModuleModel];
        
        [self.datas addObject:array];
        [self.indexTitles addObject:@"其他"];
    }
    
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        //FloatingWindow
        ModuleModel *FloatingWindowModule = [[ModuleModel alloc] init];
        FloatingWindowModule.title = @"FloatingWindow（悬浮视图）";
        FloatingWindowModule.classEntry = [FloatingWindowViewController class];
        [array addObject:FloatingWindowModule];
        
        //PullScaleTopImageViewController
        ModuleModel *pullScaleTopImageModuleModel = [[ModuleModel alloc] init];
        pullScaleTopImageModuleModel.title = @"顶部图片下拉放大，上拉缩小";
        pullScaleTopImageModuleModel.classEntry = [PullScaleTopImageViewController class];
        [array addObject:pullScaleTopImageModuleModel];
        
        [self.datas addObject:array];
        [self.indexTitles addObject:@"其他"];
    }
    
    //QuartzCore
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        //ProcessLineViewController
        ModuleModel *processLineViewModule = [[ModuleModel alloc] init];
        processLineViewModule.title = @"流程线";
        processLineViewModule.classEntry = [ProcessLineViewController class];
        [array addObject:processLineViewModule];
        
        [self.datas addObject:array];
        [self.indexTitles addObject:@"QuartzCore相关(如画线)"];
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.datas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self.datas objectAtIndex:section];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *indexTitle = [self.indexTitles objectAtIndex:section];
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [self.datas objectAtIndex:indexPath.section];
    
    ModuleModel *moduleModel = [array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    
    NSArray *array = [self.datas objectAtIndex:indexPath.section];
    
    ModuleModel *moduleModel = [array objectAtIndex:indexPath.row];
    Class classEntry = moduleModel.classEntry;
    NSString *nibName = NSStringFromClass(moduleModel.classEntry);
    
    
    UIViewController *viewController = nil;
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    if ([clsString isEqualToString:NSStringFromClass([UIViewController class])] ||
        [clsString isEqualToString:NSStringFromClass([ScrollViewController class])])
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
