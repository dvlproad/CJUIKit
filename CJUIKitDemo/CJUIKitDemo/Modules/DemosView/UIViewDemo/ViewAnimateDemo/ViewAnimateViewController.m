//
//  ViewAnimateViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ViewAnimateViewController.h"

#import "CJModuleModel.h"

#import "CountDownTimeViewController.h"

#import "UIView+CJAnimation.h"


@interface ViewAnimateViewController ()
@end

@implementation ViewAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"View动画", nil);
    
    UIImage *backgroundImage = [UIImage imageNamed:@"animationBg02.jpg"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //UIViewAnimationTransition
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIViewAnimationTransition";
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"0.None(生硬效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_animationWithAnimationTransition:UIViewAnimationTransitionNone];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"1.FlipFromLeft(左翻转效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_animationWithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"2.FlipFromRight(右翻转效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_animationWithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"3.CurlUp(上翻页效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_animationWithAnimationTransition:UIViewAnimationTransitionCurlUp];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"4.CurlDown(下翻页效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_animationWithAnimationTransition:UIViewAnimationTransitionCurlDown];
                [self changeBackgroundImage];
            };
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
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_commonTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCommonTypeFade];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"MoveIn(覆盖效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_commonTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCommonTypeMoveIn];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"Push(推挤效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_commonTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCommonTypePush];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"Reveal(揭开效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_commonTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCommonTypeReveal];
                [self changeBackgroundImage];
            };
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
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeCube];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"SuckEffect(吮吸效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeSuckEffect];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"OglFlip(翻转效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeOglFlip];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"RippleEffect(波纹效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeRippleEffect];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"PageCurl(翻页效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypePageCurl];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"PageUnCurl(反翻页效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypePageUnCurl];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"CameraIrisHollowOpen(开镜头效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeCameraIrisHollowOpen];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CJModuleModel *animationModule = [[CJModuleModel alloc] init];
            animationModule.title = @"CameraIrisHollowClose(关镜头效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeCameraIrisHollowClose];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    self.sectionDataModels = sectionDataModels;
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
    cell.backgroundColor = [UIColor clearColor]; //确保背景正确
    
    return cell;
}


- (void)changeBackgroundImage {
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
