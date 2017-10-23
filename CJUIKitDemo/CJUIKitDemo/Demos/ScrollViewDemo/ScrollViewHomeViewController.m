//
//  ScrollViewHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ScrollViewHomeViewController.h"

#import "ModuleModel.h"

//UIScrollView
#import "SvDemo_Refresh.h"

//UITableView
#import "DemoTableViewController.h"
#import "ReuseDataSourceTableViewController.h"
#import "TvDemo_Complex.h"
#import "OpenTableViewController.h"
#import "ChooseColor01.h"

//UICollectionView
#import "CvDemo_Complex.h"

#import "MyEqualCellSizeCollectionViewController.h"
#import "MyEqualCellSizeViewController.h"
#import "MyCycleADViewController.h"

#import "OpenCollectionViewController.h"
#import "CustomLayoutCollectionViewController.h"

@interface ScrollViewHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation ScrollViewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"ScrollViewHome首页", nil);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.datas = [[NSMutableArray alloc] init];
    self.indexTitles = [[NSMutableArray alloc] init];
    
    //UIScrollView
    {
        NSMutableArray *moduleModels = [[NSMutableArray alloc] init];
        
        ModuleModel *baseScrollViewModule = [[ModuleModel alloc] init];
        baseScrollViewModule.title = @"ScrollView的最基本约束";
        baseScrollViewModule.classEntry = [UIViewController class];
        [moduleModels addObject:baseScrollViewModule];
        
        ModuleModel *refreshScrollViewModule = [[ModuleModel alloc] init];
        refreshScrollViewModule.title = @"ScrollView的刷新(MJRefresh)";
        refreshScrollViewModule.classEntry = [SvDemo_Refresh class];
        [moduleModels addObject:refreshScrollViewModule];
        
        [self.datas addObject:moduleModels];
        [self.indexTitles addObject:@"UIScrollView相关"];
    }
    
    
    //UITableView
    {
        NSMutableArray *moduleModels = [[NSMutableArray alloc] init];
        
        ModuleModel *baseDemoModule = [[ModuleModel alloc] init];
        baseDemoModule.title = @"BaseDemo";
        baseDemoModule.classEntry = [DemoTableViewController class];
        [moduleModels addObject:baseDemoModule];
        
        ModuleModel *reuseDataSourceTableModule = [[ModuleModel alloc] init];
        reuseDataSourceTableModule.title = @"ReuseDataSourceTable";
        reuseDataSourceTableModule.classEntry = [ReuseDataSourceTableViewController class];
        [moduleModels addObject:reuseDataSourceTableModule];
        
        ModuleModel *complexDemoModule = [[ModuleModel alloc] init];
        complexDemoModule.title = @"ComplexDemo";
        complexDemoModule.classEntry = [TvDemo_Complex class];
        [moduleModels addObject:complexDemoModule];
        
        ModuleModel *openTableModule = [[ModuleModel alloc] init];
        openTableModule.title = @"OpenTable";
        openTableModule.classEntry = [OpenTableViewController class];
        [moduleModels addObject:openTableModule];
        
        ModuleModel *chooseColorModule = [[ModuleModel alloc] init];
        chooseColorModule.title = @"ChooseColor01";
        chooseColorModule.classEntry = [ChooseColor01 class];
        [moduleModels addObject:chooseColorModule];
        
        [self.datas addObject:moduleModels];
        [self.indexTitles addObject:@"UITableView相关"];
    }
    
    
    //UICollectionView
    {
        NSMutableArray *moduleModels = [[NSMutableArray alloc] init];
        
        ModuleModel *complexDemoModule = [[ModuleModel alloc] init];
        complexDemoModule.title = @"ComplexDemo";
        complexDemoModule.classEntry = [CvDemo_Complex class];
        [moduleModels addObject:complexDemoModule];
        
        ModuleModel *MyEqualCellSizeCollectionViewModule = [[ModuleModel alloc] init];
        MyEqualCellSizeCollectionViewModule.title = @"MyEqualCellSizeCollectionView(等cell大小)";
        MyEqualCellSizeCollectionViewModule.classEntry = [MyEqualCellSizeCollectionViewController class];
        [moduleModels addObject:MyEqualCellSizeCollectionViewModule];
        
        ModuleModel *MyEqualCellSizeViewModule = [[ModuleModel alloc] init];
        MyEqualCellSizeViewModule.title = @"MyEqualCellSizeView(嵌套的等cell大小)";
        MyEqualCellSizeViewModule.classEntry = [MyEqualCellSizeViewController class];
        [moduleModels addObject:MyEqualCellSizeViewModule];
        
        
        ModuleModel *cycleScrollViewModule = [[ModuleModel alloc] init];
        cycleScrollViewModule.title = @"MyCycleADView(无限循环的视图)";
        cycleScrollViewModule.classEntry = [MyCycleADViewController class];
        [moduleModels addObject:cycleScrollViewModule];
        
        ModuleModel *openCollectionViewModule = [[ModuleModel alloc] init];
        openCollectionViewModule.title = @"OpenCollectionView(可展开)";
        openCollectionViewModule.classEntry = [OpenCollectionViewController class];
        [moduleModels addObject:openCollectionViewModule];
        
        ModuleModel *customLayoutModule = [[ModuleModel alloc] init];
        customLayoutModule.title = @"CustomLayout(自定义布局)";
        customLayoutModule.classEntry = [CustomLayoutCollectionViewController class];
        [moduleModels addObject:customLayoutModule];
        
        [self.datas addObject:moduleModels];
        [self.indexTitles addObject:@"UICollectionView相关"];
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
    
    NSArray *moduleModels = [self.datas objectAtIndex:indexPath.section];
    
    ModuleModel *moduleModel = [moduleModels objectAtIndex:indexPath.row];
    Class classEntry = moduleModel.classEntry;
    NSString *nibName = NSStringFromClass(moduleModel.classEntry);
    
    
    UIViewController *viewController = nil;
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    if ([clsString isEqualToString:NSStringFromClass([UIViewController class])])
    {
        viewController = [[classEntry alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
    } else if ([clsString isEqualToString:NSStringFromClass([ChooseColor01 class])]) {
        viewController = [[ChooseColor01 alloc] initWithStyle:UITableViewStyleGrouped];
        
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
