//
//  FoundatioHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "FoundatioHomeViewController.h"

#import "ModuleModel.h"

#import "StringViewController.h"
#import "AttributedStringViewController.h"

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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.datas = [[NSMutableArray alloc] init];
    
    ModuleModel *NSStringModule = [[ModuleModel alloc] init];
    NSStringModule.title = @"NSString";
    NSStringModule.classEntry = [StringViewController class];
    [self.datas addObject:NSStringModule];
    
    
    ModuleModel *NSAttributedStringModule = [[ModuleModel alloc] init];
    NSAttributedStringModule.title = @"NSAttributedString";
    NSAttributedStringModule.classEntry = [AttributedStringViewController class];
    [self.datas addObject:NSAttributedStringModule];
    
    
    ModuleModel *NSDateModule = [[ModuleModel alloc] init];
    NSDateModule.title = @"NSDate";
    NSDateModule.classEntry = [DateViewController class];
    [self.datas addObject:NSDateModule];
    
    //TypeConvert
    ModuleModel *TypeConvertModule = [[ModuleModel alloc] init];
    TypeConvertModule.title = @"TypeConvertModule（类型转换）";
    TypeConvertModule.classEntry = [TypeConvertViewController class];
    [self.datas addObject:TypeConvertModule];
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
    if ([clsString isEqualToString:NSStringFromClass([UIViewController class])])
    {
        viewController = [[classEntry alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        
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
