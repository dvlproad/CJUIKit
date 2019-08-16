//
//  WelcomeViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2019/7/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "WelcomeViewController.h"
#import "WelcomeView.h"

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *imageUrl = @"http://pic33.nipic.com/20131007/13639685_123501617185_2.jpg";
    NSURL *imageURL = [NSURL URLWithString:imageUrl];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], @"welcome.mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:filePath];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentYear = [comps year];
    NSString *copyright = [NSString stringWithFormat:@"Copyright © 2001-%ld Weaver Software All Rights Reserved", currentYear];
    
    WelcomeImageType imageType = WelcomeImageTypeStatic;
    BOOL isGif = [[NSUserDefaults standardUserDefaults] boolForKey:@"welcomeBackgroundImageType"];
    if (isGif) {
        imageType = WelcomeImageTypeGif;
    }
    
    WelcomeView *welcomeView = [[WelcomeView alloc] initWithImageURL:imageURL imageType:imageType movieURL:movieURL isImageFirst:YES];
    welcomeView.copyright = copyright;
    welcomeView.image = [UIImage imageNamed:@"launch1242x2280.png"];
    welcomeView.backgroundColor = [UIColor whiteColor];
    [welcomeView showWithDuration:3 showCompleteBlock:^{
//        UIViewController *viewController = [[UIViewController alloc] init];
//        viewController.title = NSLocalizedString(@"测试欢迎页", nil);
//        viewController.view.backgroundColor = [UIColor whiteColor];
//        [self.navigationController pushViewController:viewController animated:YES];
    }];
}

@end
