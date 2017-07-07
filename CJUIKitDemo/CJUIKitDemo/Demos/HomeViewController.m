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
    
    //ViewCategoryViewController
    ModuleModel *ViewCategoryModule = [[ModuleModel alloc] init];
    ViewCategoryModule.title = @"ViewCategoryModule";
    ViewCategoryModule.classEntry = [ViewCategoryViewController class];
    [self.datas addObject:ViewCategoryModule];
    
    
    ModuleModel *ViewDragCategoryModule = [[ModuleModel alloc] init];
    ViewDragCategoryModule.title = @"Drag And KeepBounds";
    ViewDragCategoryModule.classEntry = [DragViewController class];
    [self.datas addObject:ViewDragCategoryModule];
    
    //FloatingWindow
    ModuleModel *FloatingWindowModule = [[ModuleModel alloc] init];
    FloatingWindowModule.title = @"FloatingWindow（悬浮视图）";
    FloatingWindowModule.classEntry = [FloatingWindowViewController class];
    [self.datas addObject:FloatingWindowModule];
    
    //CJImageView
    ModuleModel *cjImageViewModuleModel = [[ModuleModel alloc] init];
    cjImageViewModuleModel.title = @"CJImageView";
    cjImageViewModuleModel.classEntry = [ImageViewController class];
    [self.datas addObject:cjImageViewModuleModel];
    
    ModuleModel *buttonModule = [[ModuleModel alloc] init];
    buttonModule.title = @"UIButton";
    buttonModule.classEntry = [ButtonViewController class];
    [self.datas addObject:buttonModule];
    
    //CJSelectTextTextField
    ModuleModel *CJSelectTextTextFieldModuleModel = [[ModuleModel alloc] init];
    CJSelectTextTextFieldModuleModel.title = @"CJSelectTextTextField";
    CJSelectTextTextFieldModuleModel.classEntry = [TextFieldViewController class];
    [self.datas addObject:CJSelectTextTextFieldModuleModel];
    
    //CJTextView
    ModuleModel *cjTextViewModuleModel = [[ModuleModel alloc] init];
    cjTextViewModuleModel.title = @"CJTextView";
    cjTextViewModuleModel.classEntry = [TextViewController class];
    [self.datas addObject:cjTextViewModuleModel];
    
    ModuleModel *cjScrollViewModuleModel = [[ModuleModel alloc] init];
    cjScrollViewModuleModel.title = @"用代码创建的CJScrollView";
    cjScrollViewModuleModel.classEntry = [ScrollViewController class];
    [self.datas addObject:cjScrollViewModuleModel];
    
    ModuleModel *TableViewModule = [[ModuleModel alloc] init];
    TableViewModule.title = @"TableView";
    TableViewModule.classEntry = [TableViewController class];
    [self.datas addObject:TableViewModule];
    
    ModuleModel *keyboardAvoidingModuleModel = [[ModuleModel alloc] init];
    keyboardAvoidingModuleModel.title = @"KeyboardAvoiding";
    keyboardAvoidingModuleModel.classEntry = [KeyboardAvoidingViewController class];
    [self.datas addObject:keyboardAvoidingModuleModel];
    
    //CJSlider
    ModuleModel *cjSliderModuleModel = [[ModuleModel alloc] init];
    cjSliderModuleModel.title = @"CJSliderControl";
    cjSliderModuleModel.classEntry = [SliderViewController class];
    [self.datas addObject:cjSliderModuleModel];
    
    //CJSearchBar
    ModuleModel *cjSearchBarModuleModel = [[ModuleModel alloc] init];
    cjSearchBarModuleModel.title = @"CJSearchBar";
    cjSearchBarModuleModel.classEntry = [SearchBarViewController class];
    [self.datas addObject:cjSearchBarModuleModel];
    
    ModuleModel *UIImageModuleModel = [[ModuleModel alloc] init];
    UIImageModuleModel.title = @"UIImage";
    UIImageModuleModel.classEntry = [ImageChangeColorViewController class];
    [self.datas addObject:UIImageModuleModel];
    
    //UINavigationBar
    ModuleModel *UINavigationBarModuleModel1 = [[ModuleModel alloc] init];
    UINavigationBarModuleModel1.title = @"UINavigationBar(常见的导航栏背景色改变隐藏)";
    UINavigationBarModuleModel1.classEntry = [NavigationBarChangeBGViewController class];
    [self.datas addObject:UINavigationBarModuleModel1];
    
    ModuleModel *UINavigationBarModuleModel2 = [[ModuleModel alloc] init];
    UINavigationBarModuleModel2.title = @"UINavigationBar(类似斗鱼的导航栏移动隐藏)";
    UINavigationBarModuleModel2.classEntry = [NavigationBarChangePositonViewController class];
    [self.datas addObject:UINavigationBarModuleModel2];
    
    //PullScaleTopImageViewController
    ModuleModel *pullScaleTopImageModuleModel = [[ModuleModel alloc] init];
    pullScaleTopImageModuleModel.title = @"顶部图片下拉放大，上拉缩小";
    pullScaleTopImageModuleModel.classEntry = [PullScaleTopImageViewController class];
    [self.datas addObject:pullScaleTopImageModuleModel];
    
    ModuleModel *cjMJRefreshComponentModuleModel = [[ModuleModel alloc] init];
    cjMJRefreshComponentModuleModel.title = @"CJMJRefreshComponent";
    cjMJRefreshComponentModuleModel.classEntry = [CJMJRefreshViewController class];
    [self.datas addObject:cjMJRefreshComponentModuleModel];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModuleModel *moduleModel = [self.datas objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    
    ModuleModel *moduleModel = [self.datas objectAtIndex:indexPath.row];
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
