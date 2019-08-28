//
//  CJUIKitBaseHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseHomeViewController.h"

@interface CJUIKitBaseHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation CJUIKitBaseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"XXX首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.contentView.bounds = CGRectInset(cell.bounds, -40, -10);
//    cell.contentView.backgroundColor = [UIColor redColor];
//
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor lightGrayColor];
////    [cell.contentView insertSubview:view aboveSubview:cell.contentView];
//    [cell.contentView insertSubview:view belowSubview:cell.contentView];
    
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = cell.bounds;
    CGFloat cornerRadius = 10.f;
    
    if (indexPath.row == 0) {//第一个cell
        //上边线
        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + 10, bounds.origin.y + 20);
        //画弧
        CGPathAddArcToPoint(pathRef, nil, bounds.origin.x + 10, bounds.origin.y, bounds.origin.x + 30, bounds.origin.y, cornerRadius);
        //下面三句可以省略掉，写了更容易理解
        //        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + 20, bounds.origin.y);
        //        CGPathAddLineToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 30, bounds.origin.y);
        //        CGPathMoveToPoint(pathRef, nil,  bounds.origin.x + bounds.size.width - 30, bounds.origin.y);
        CGPathAddArcToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 10, bounds.origin.y, bounds.origin.x + bounds.size.width - 10, bounds.origin.y + 20, cornerRadius);
        
        //左边线
        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + 10, bounds.origin.y + 20);
        CGPathAddLineToPoint(pathRef, nil, bounds.origin.x + 10, bounds.size.height);
        //右边线
        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 10, bounds.origin.y + 10);
        CGPathAddLineToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 10, bounds.size.height);
    }
    if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1){//最后一个cell
        //下边线
        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + 10, bounds.origin.y + bounds.size.height);
        CGPathAddLineToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 10, bounds.origin.y + bounds.size.height);
        
        //左边线
        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + 10, bounds.origin.y);
        CGPathAddLineToPoint(pathRef, nil, bounds.origin.x + 10, bounds.size.height);
        //右边线
        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 10, bounds.origin.y);
        CGPathAddLineToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 10, bounds.size.height);
    }
    if (indexPath.row != 0 && indexPath.row != [tableView numberOfRowsInSection:indexPath.section] - 1) {//中间的cell
        //左边线
        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + 10, bounds.origin.y);
        CGPathAddLineToPoint(pathRef, nil, bounds.origin.x + 10, bounds.size.height);
        //右边线
        CGPathMoveToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 10, bounds.origin.y);
        CGPathAddLineToPoint(pathRef, nil, bounds.origin.x + bounds.size.width - 10, bounds.size.height);
    }
    layer.path = pathRef;
    CFRelease(pathRef);
    //颜色修改
    layer.fillColor = [UIColor whiteColor].CGColor;//这个是填充颜色，一个没有封闭的线条，无法做到完全填充
    layer.strokeColor=[UIColor redColor].CGColor;
    layer.borderWidth = 0.5;
    [cell.contentView.layer insertSublayer:layer atIndex:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CJModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = moduleModel.title;
    cell.detailTextLabel.text = moduleModel.content;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"didSelectRowAtIndexPath = %zd %zd", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CJModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    [self execModuleModel:moduleModel];
}


- (void)execModuleModel:(CJModuleModel *)moduleModel {
    if (moduleModel.actionBlock) {
        moduleModel.actionBlock();
        
    } else if (moduleModel.selector) {
        [self performSelectorOnMainThread:moduleModel.selector withObject:nil waitUntilDone:NO];
        
    } else {
        UIViewController *viewController = nil;
        Class classEntry = moduleModel.classEntry;
        NSString *clsString = NSStringFromClass(moduleModel.classEntry);
        if ([clsString isEqualToString:NSStringFromClass([UIViewController class])]) {
            viewController = [[classEntry alloc] init];
            viewController.view.backgroundColor = [UIColor whiteColor];
            
        } else {
            if (moduleModel.isCreateByXib) {
                viewController = [[classEntry alloc] initWithNibName:clsString bundle:nil];
            } else {
                viewController = [[classEntry alloc] init];
            }
        }
        
        viewController.title = NSLocalizedString(moduleModel.title, nil);
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
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
