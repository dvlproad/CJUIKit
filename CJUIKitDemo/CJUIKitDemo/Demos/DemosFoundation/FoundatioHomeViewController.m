//
//  FoundatioHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "FoundatioHomeViewController.h"

#import "EncryptStringViewController.h"
#import "AttributedStringViewController.h"
#import "ValidateStringViewController.h"

#import "DateViewController.h"
#import "TypeConvertViewController.h"


@interface FoundatioHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation FoundatioHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Home首页", nil);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //NSString
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSString相关";
        {
            CJModuleModel *NSStringModule = [[CJModuleModel alloc] init];
            NSStringModule.title = @"EncryptString";
            NSStringModule.classEntry = [EncryptStringViewController class];
            [sectionDataModel.values addObject:NSStringModule];
        }
        {
            CJModuleModel *NSAttributedStringModule = [[CJModuleModel alloc] init];
            NSAttributedStringModule.title = @"NSAttributedString";
            NSAttributedStringModule.classEntry = [AttributedStringViewController class];
            [sectionDataModel.values addObject:NSAttributedStringModule];
        }
        {
            CJModuleModel *NSAttributedStringModule = [[CJModuleModel alloc] init];
            NSAttributedStringModule.title = @"ValidateString";
            NSAttributedStringModule.classEntry = [ValidateStringViewController class];
            [sectionDataModel.values addObject:NSAttributedStringModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //NSDate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSDate相关";
        {
            CJModuleModel *NSDateModule = [[CJModuleModel alloc] init];
            NSDateModule.title = @"NSDate";
            NSDateModule.classEntry = [DateViewController class];
            [sectionDataModel.values addObject:NSDateModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Json-Model类型转换
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Json-Model类型转换相关";
        {
            //TypeConvert
            CJModuleModel *TypeConvertModule = [[CJModuleModel alloc] init];
            TypeConvertModule.title = @"TypeConvertModule（类型转换）";
            TypeConvertModule.classEntry = [TypeConvertViewController class];
            [sectionDataModel.values addObject:TypeConvertModule];
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
    
    NSArray *noxibViewControllers = @[NSStringFromClass([UIViewController class]),
                                      ];
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    if ([noxibViewControllers containsObject:clsString])
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
