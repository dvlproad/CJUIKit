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
    tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]; // #f5f5f5
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIColor *lineColor = [UIColor whiteColor];
    
//    cell.contentView.bounds = CGRectInset(cell.bounds, -40, -10);
//    cell.contentView.backgroundColor = [UIColor redColor];
//
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor lightGrayColor];
////    [cell.contentView insertSubview:view aboveSubview:cell.contentView];
//    [cell.contentView insertSubview:view belowSubview:cell.contentView];
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        cell.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]; // #f5f5f5;
        
        // 圆角角度 & offset
        CGFloat cornerRadius = 20.f;
        CGFloat offset = 40.f;
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds, offset, 0);    // 获取显示区域大小
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            CGPathAddRect(pathRef, nil, bounds);
        }
        
        // 创建两个layer
        CAShapeLayer *normalLayer = [[CAShapeLayer alloc] init];
        CAShapeLayer *selectLayer = [[CAShapeLayer alloc] init];
        // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
        normalLayer.path = pathRef;
        selectLayer.path = pathRef;
        CFRelease(pathRef);
        
        
        
        // 填充颜色和描边颜色修改
        normalLayer.fillColor = [UIColor whiteColor].CGColor;
        selectLayer.fillColor = [UIColor whiteColor].CGColor;
        normalLayer.strokeColor = lineColor.CGColor;
        selectLayer.strokeColor = lineColor.CGColor;
        
        
        // 添加图层到nomarBgView中,圆角显示就完成了，
        UIView *nomarBgView = [[UIView alloc] initWithFrame:bounds];
        nomarBgView.backgroundColor = [UIColor clearColor];
        [nomarBgView.layer insertSublayer:normalLayer atIndex:0];
        cell.backgroundView = nomarBgView;
        
        
        // 但是如果没有取消cell的点击效果，还是会出现一个灰色的长方形的形状，再用上面创建的selectLayer给cell添加一个selectedBackgroundView
        UIView *selectBgView = [[UIView alloc] initWithFrame:bounds];
        selectBgView.backgroundColor = [UIColor clearColor];
        [selectBgView.layer insertSublayer:selectLayer atIndex:0];
        cell.selectedBackgroundView = selectBgView;
    }
}
//*/

//*
// 其他参考:[iOS UITableView设置section圆角](https://www.jianshu.com/p/739408a7aae1?utm_campaign=hugo)
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置cell 背景色为透明
    cell.backgroundColor = UIColor.clearColor;
    
    // 圆角角度 & offset
    CGFloat radius = 10.f;
    CGFloat offset = 10.f;
    // 获取显示区域大小
    CGRect bounds = CGRectInset(cell.bounds, offset, 0);
    // 获取每组行数
    NSInteger rowNum = [tableView numberOfRowsInSection:indexPath.section];
    // 贝塞尔曲线
    UIBezierPath *bezierPath = nil;
    if (rowNum == 1) {
        // 一组只有一行（四个角全部为圆角）
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                           byRoundingCorners:UIRectCornerAllCorners
                                                 cornerRadii:CGSizeMake(radius, radius)];
    } else {
        if (indexPath.row == 0) {
            // 每组第一行（添加左上和右上的圆角）
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                     cornerRadii:CGSizeMake(radius, radius)];
            
        } else if (indexPath.row == rowNum - 1) {
            // 每组最后一行（添加左下和右下的圆角）
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                                     cornerRadii:CGSizeMake(radius, radius)];
        } else {
            // 每组不是首位的行不设置圆角
            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
        }
    }
    
    [self __configCell:cell withBounds:bounds path:bezierPath.CGPath];
}
//*/


- (void)__configCell:(UITableViewCell *)cell withBounds:(CGRect)bounds path:(CGPathRef)path {
    UIColor *lineColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0]; //#e5e5e5
    
    // 创建两个layer
    CAShapeLayer *normalLayer = [[CAShapeLayer alloc] init];
    CAShapeLayer *selectLayer = [[CAShapeLayer alloc] init];
    // 设置填充颜色
    normalLayer.fillColor = [UIColor whiteColor].CGColor;
    selectLayer.fillColor = [UIColor whiteColor].CGColor;
    normalLayer.strokeColor = lineColor.CGColor;
    selectLayer.strokeColor = lineColor.CGColor;
    // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
    normalLayer.path = path;
    selectLayer.path = path;
    
    
    // 添加图层到nomarBgView中,圆角显示就完成了，
    UIView *nomarBgView = [[UIView alloc] initWithFrame:bounds];
    nomarBgView.backgroundColor = [UIColor clearColor];
    [nomarBgView.layer insertSublayer:normalLayer atIndex:0];
    cell.backgroundView = nomarBgView;
    
    // 但是如果没有取消cell的点击效果，还是会出现一个灰色的长方形的形状，再用上面创建的selectLayer给cell添加一个selectedBackgroundView
    UIView *selectBgView = [[UIView alloc] initWithFrame:bounds];
    selectBgView.backgroundColor = [UIColor clearColor];
    [selectBgView.layer insertSublayer:selectLayer atIndex:0];
    cell.selectedBackgroundView = selectBgView;
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
