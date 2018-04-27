//
//  ShowDropDownViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/8/31.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ShowDropDownViewController.h"
#import "UIView+CJShowExtendView.h"

@interface ShowDropDownViewController () {
    
}
@property (nonatomic, weak) IBOutlet UIButton *button;

@end

@implementation ShowDropDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        CGFloat width = CGRectGetWidth(button.frame);
        CGFloat height = 200;
        
        CGFloat popupViewX = CGRectGetMinX(button.frame);
        
        UIView *popupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, height)];
        popupView.clipsToBounds = YES;
        popupView.backgroundColor = [UIColor greenColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(20, 50, width-40, 44)];
        [btn setTitle:@"生成随机数，并设置" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [popupView addSubview:btn];
        
        [button cj_showExtendView:popupView inView:self.view locationAccordingView:button relativePosition:CJPopupViewPositionBelow showComplete:^{
            NSLog(@"显示完成");
        } tapBlankComplete:^() {
            NSLog(@"点击背景完成");
            button.selected = !button.selected;
            
            [button cj_hideExtendViewAnimated:YES];
        }];
        
    } else {
        [button cj_hideExtendViewAnimated:YES];
    }
}

- (IBAction)btnAction:(id)sender {
    NSString *text = [NSString stringWithFormat:@"%d", rand()%10];
    NSLog(@"text = %@", text);
    [self.button setTitle:text forState:UIControlStateNormal];
    
    self.button.selected = !self.button.selected;
    [self.button cj_hideExtendViewAnimated:YES];
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
