//
//  HomeViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HomeViewController.h"

#import "ImageViewController.h"
#import "TextFieldViewController.h"
#import "TextViewController.h"
#import "ScrollViewController.h"
#import "KeyboardAvoidingViewController.h"
#import "SliderViewController.h"
#import "SearchBarViewController.h"


#import "ImageChangeColorViewController.h"
#import "NavigationBarViewController.h"

#import "CJMJRefreshViewController.h"

#import "ModuleModel.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Home首页", nil);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.datas = [[NSMutableArray alloc] init];
    
    //CJImageView
    ModuleModel *cjImageViewModuleModel = [[ModuleModel alloc] init];
    cjImageViewModuleModel.title = @"CJImageView";
    cjImageViewModuleModel.classEntry = [ImageViewController class];
    [self.datas addObject:cjImageViewModuleModel];
    
    //CJTextField
    ModuleModel *cjTextFieldModuleModel = [[ModuleModel alloc] init];
    cjTextFieldModuleModel.title = @"CJTextField";
    cjTextFieldModuleModel.classEntry = [TextFieldViewController class];
    [self.datas addObject:cjTextFieldModuleModel];
    
    //CJTextView
    ModuleModel *cjTextViewModuleModel = [[ModuleModel alloc] init];
    cjTextViewModuleModel.title = @"CJTextView";
    cjTextViewModuleModel.classEntry = [TextViewController class];
    [self.datas addObject:cjTextViewModuleModel];
    
    ModuleModel *cjScrollViewModuleModel = [[ModuleModel alloc] init];
    cjScrollViewModuleModel.title = @"用代码创建的CJScrollView";
    cjScrollViewModuleModel.classEntry = [ScrollViewController class];
    [self.datas addObject:cjScrollViewModuleModel];
    
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
    
    ModuleModel *UINavigationBarModuleModel = [[ModuleModel alloc] init];
    UINavigationBarModuleModel.title = @"UINavigationBar";
    UINavigationBarModuleModel.classEntry = [NavigationBarViewController class];
    [self.datas addObject:UINavigationBarModuleModel];
    
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
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    if ([clsString isEqualToString:NSStringFromClass([UIViewController class])] ||
        [clsString isEqualToString:NSStringFromClass([ScrollViewController class])]) {
        UIViewController *viewController = [[classEntry alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        viewController.title = NSLocalizedString(moduleModel.title, nil);
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    
    UIViewController *viewController = [[classEntry alloc] initWithNibName:nibName bundle:nil];
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
