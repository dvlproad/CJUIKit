//
//  ChangeEnvironmentViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/12.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "ChangeEnvironmentViewController.h"

#ifdef TEST_CJBASEUIKIT_POD
#import "CQDMSectionDataModel.h"
#import "CQDMModuleModel.h"
#else
#import <CJBaseUtil/CQDMSectionDataModel.h>   //在CJDataUtil中
#import <CJBaseUtil/CQDMModuleModel.h>        //在CJDataUtil中
#endif

/**
 *  app环境
 */
typedef NS_ENUM(NSUInteger, EnvironmentType) {
    EnvironmentTypeUnknown,     /**< 未知环境 */
    EnvironmentTypeProduct,     /**< 生产环境 */
    EnvironmentTypePreProduct,  /**< 预生产环境 */
    EnvironmentTypeDevelop1,    /**< 开发环境1 */
    EnvironmentTypeDevelop2     /**< 开发环境2 */
};


@interface ChangeEnvironmentViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;   /**< 当前选择的index */

@end


@implementation ChangeEnvironmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"ChangeEnvironment(改变app环境)", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", nil) style:UIBarButtonItemStylePlain target:self action:@selector(changeEnvironment)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //ChangeEnvironment
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"ChangeEnvironment相关";
        {
            CQDMModuleModel *environmentModule = [[CQDMModuleModel alloc] init];
            environmentModule.title = @"Product(生产环境)";
            environmentModule.classEntry = [ChangeEnvironmentViewController class];
            
            [sectionDataModel.values addObject:environmentModule];
        }
        
        {
            CQDMModuleModel *environmentModule = [[CQDMModuleModel alloc] init];
            environmentModule.title = @"PreProduct(预生产环境)";
            environmentModule.classEntry = [ChangeEnvironmentViewController class];
            
            [sectionDataModel.values addObject:environmentModule];
        }
        
        {
            CQDMModuleModel *environmentModule = [[CQDMModuleModel alloc] init];
            environmentModule.title = @"Develop1(开发环境1)";
            environmentModule.classEntry = [ChangeEnvironmentViewController class];
            
            [sectionDataModel.values addObject:environmentModule];
        }
        
        {
            CQDMModuleModel *environmentModule = [[CQDMModuleModel alloc] init];
            environmentModule.title = @"Develop2(开发环境2)";
            environmentModule.classEntry = [ChangeEnvironmentViewController class];
            
            [sectionDataModel.values addObject:environmentModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    self.sectionDataModels = sectionDataModels;
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)changeEnvironment {
    if (self.changeEnvironmentCompleteBlock) {
        self.changeEnvironmentCompleteBlock(self.selectedIndexPath);
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CQDMModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = moduleModel.title;
    cell.detailTextLabel.text = moduleModel.content;
    
    if (indexPath == self.selectedIndexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"didSelectRowAtIndexPath = %zd %zd", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
    oldCell.accessoryType = UITableViewCellAccessoryNone;
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.selectedIndexPath = indexPath;
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
