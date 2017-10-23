//
//  CvDemo_Complex+Event.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CvDemo_Complex+Event.h"
#import <UIViewController+MJPopupViewController.h>

@implementation CvDemo_Complex (Event)

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Detail *vc = [[Detail alloc]initWithNibName:@"Detail" bundle:nil];
    vc.info = [lists objectAtIndex:indexPath.item];
    vc.delegate = self;
    [vc.view setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 40, [[UIScreen mainScreen] bounds].size.height - 140)];
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop];
}

- (void)goCancel:(Detail *)vc{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

- (void)goOK:(Detail *)vc{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.title = @"第二页 UIViewController";
    vc2.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc2 animated:YES];
}


@end
