//
//  UIViewController+CJSystemBackButtonHandler.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/9/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIViewController+CJSystemBackButtonHandler.h"

@implementation UIViewController (CJSystemBackButtonHandler)

@end




@implementation UINavigationController (CJShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {

	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

	BOOL shouldPop = YES;
	UIViewController* vc = [self topViewController];
	if([vc respondsToSelector:@selector(cj_navigationShouldPopOnBackButton)]) {
		shouldPop = [vc cj_navigationShouldPopOnBackButton];
	}

	if(shouldPop) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self popViewControllerAnimated:YES];
		});
	} else {
		// Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
		for(UIView *subview in [navigationBar subviews]) {
			if(0. < subview.alpha && subview.alpha < 1.) {
				[UIView animateWithDuration:.25 animations:^{
					subview.alpha = 1.;
				}];
			}
		}
	}

	return NO;
}

@end
