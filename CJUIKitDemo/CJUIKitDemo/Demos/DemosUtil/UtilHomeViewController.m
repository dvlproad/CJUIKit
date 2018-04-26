//
//  UtilHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UtilHomeViewController.h"

#import "CJModuleModel.h"

#import "DeviceInfoViewController.h"

#import "DataUtilViewController.h"

#import "ToastViewController.h"
#import "AlertViewController.h"

#import "KeyboardUtilViewController.h"

@interface UtilHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation UtilHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Util首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Util
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Util相关";
        {
            CJModuleModel *deviceInfoModule = [[CJModuleModel alloc] init];
            deviceInfoModule.title = @"DeviceInfo";
            deviceInfoModule.classEntry = [DeviceInfoViewController class];
            [sectionDataModel.values addObject:deviceInfoModule];
        }
        {
            CJModuleModel *dataUtilModule = [[CJModuleModel alloc] init];
            dataUtilModule.title = @"DataUtil";
            dataUtilModule.classEntry = [DataUtilViewController class];
            [sectionDataModel.values addObject:dataUtilModule];
        }
        {
            CJModuleModel *toastUtilModule = [[CJModuleModel alloc] init];
            toastUtilModule.title = @"Toast";
            toastUtilModule.classEntry = [ToastViewController class];
            [sectionDataModel.values addObject:toastUtilModule];
        }
        {
            CJModuleModel *alertUtilModule = [[CJModuleModel alloc] init];
            alertUtilModule.title = @"Alert";
            alertUtilModule.classEntry = [AlertViewController class];
            [sectionDataModel.values addObject:alertUtilModule];
        }
        {
            CJModuleModel *keyboardUtilModule = [[CJModuleModel alloc] init];
            keyboardUtilModule.title = @"KeyboardUtil(键盘高度)";
            keyboardUtilModule.classEntry = [KeyboardUtilViewController class];
            [sectionDataModel.values addObject:keyboardUtilModule];
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
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
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
