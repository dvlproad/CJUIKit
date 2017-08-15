//
//  ProcessLineViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/8/14.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ProcessLineViewController.h"
#import "CustomTripProgressView.h"
#import "ProcessLineView.h"

@interface ProcessLineViewController ()

@property (nonatomic, weak) IBOutlet ProcessLineView *processLineView1;
@property (nonatomic, weak) IBOutlet ProcessLineView *processLineView2;
@property (nonatomic, weak) IBOutlet ProcessLineView *processLineView3;
@property (nonatomic, weak) IBOutlet ProcessLineView *processLineView4;
@property (nonatomic, weak) IBOutlet ProcessLineView *processLineView5;

@end

@implementation ProcessLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CustomTripProgressView *tripProgressView = [[CustomTripProgressView alloc] initWithFrame:CGRectMake(20, 100, 300, 40) andTitles:@[@"1", @"2", @"3", @"4", @"5"]];
    [tripProgressView setSelectIndex:2];
    [self.view addSubview:tripProgressView];
    
    ProcessLineView *processLineView = [[ProcessLineView alloc] initWithFrame:CGRectMake(20, 200, 300, 40)];
    processLineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:processLineView];
    
    
    
    
    self.processLineView1.processLineViewType = ProcessLineViewTypeDone;
    self.processLineView1.processLineViewIndexType = ProcessLineViewIndexTypeStart;
    
    self.processLineView2.processLineViewType = ProcessLineViewTypeDone;
//    self.processLineView2.processLineViewIndexType = ProcessLineViewIndexTypeOther;
    
    self.processLineView3.processLineViewType = ProcessLineViewTypeDoing;
//    self.processLineView3.processLineViewIndexType = ProcessLineViewIndexTypeOther;
    
    self.processLineView4.processLineViewType = ProcessLineViewTypeToDo;
//    self.processLineView4.processLineViewIndexType = ProcessLineViewIndexTypeOther;
    
    self.processLineView5.processLineViewType = ProcessLineViewTypeToDo;
    self.processLineView5.processLineViewIndexType = ProcessLineViewIndexTypeLast;
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
