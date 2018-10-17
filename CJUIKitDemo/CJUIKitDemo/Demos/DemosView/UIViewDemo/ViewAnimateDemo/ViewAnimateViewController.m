//
//  ViewAnimateViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ViewAnimateViewController.h"

#import "CJModuleModel.h"

#import "PullScaleTopImageViewController.h"
#import "ProcessLineViewController.h"
#import "CountDownTimeViewController.h"

#import "UIView+CJAnimation.h"


@interface ViewAnimateViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation ViewAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"View动画", nil);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //UIViewAnimationTransition
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIViewAnimationTransition";
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"None(生硬效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"FlipFromLeft(左翻转效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"FlipFromRight(右翻转效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"CurlUp(上翻页效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"CurlDown(下翻页效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //CommonTransition:Fade淡入淡出、MoveIn覆盖、Push推挤、Reveal揭开
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"CommonTransition";
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"Fade(淡化效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"MoveIn(覆盖效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"Push(推挤效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"Reveal(揭开效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //CustomTransition
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"CustomTransition";
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"Cube(3D立方效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"SuckEffect(吮吸效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"OglFlip(翻转效果)";
            [sectionDataModel.values addObject:animationModule];
        }{
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"RippleEffect(波纹效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"PageCurl(翻页效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"PageUnCurl(反翻页效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"CameraIrisHollowOpen(开镜头效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"CameraIrisHollowClose(关镜头效果)";
            [sectionDataModel.values addObject:animationModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    
    
    
    self.sectionDataModels = sectionDataModels;
    
    
    UIImage *backgroundImage = [UIImage imageNamed:@"animationBg02.jpg"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
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
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CJModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    */
    
    //transitionDirection
//    CJTransitionDirection transitionDirection = moduleModel.unReadNumber;
//    moduleModel.unReadNumber++;
//    if (moduleModel.unReadNumber > 3) {
//        moduleModel.unReadNumber = 0;
//    }
    
    if (indexPath.section == 0) {
        UIViewAnimationTransition transition = (UIViewAnimationTransition)indexPath.row;
        [self.tableView cj_animationWithAnimationTransition:transition];
        
    } else if (indexPath.section == 1) {
        CJAnimateCommonType animationType = (CJAnimateCommonType)indexPath.row;
        
        CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
        [self.tableView cj_commonTransitionFrom:transitionDirection
                              withAnimationType:animationType];
    } else if (indexPath.section == 2) {
        CJAnimateCustomType animationType = (CJAnimateCustomType)indexPath.row;
        
        CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
        [self.tableView cj_customTransitionFrom:transitionDirection
                              withAnimationType:animationType];
    }
    
    
    static int i = 0;
    if (i == 0) {
        UIImage *backgroundImage = [UIImage imageNamed:@"animationBg01.jpg"];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        i = 1;
    } else {
        UIImage *backgroundImage = [UIImage imageNamed:@"animationBg02.jpg"];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        i = 0;
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
