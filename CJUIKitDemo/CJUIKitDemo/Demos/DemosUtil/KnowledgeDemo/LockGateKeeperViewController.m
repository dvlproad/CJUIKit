//
//  LockGateKeeperViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/11.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LockGateKeeperViewController.h"
#import "DemoButtonFactory.h"

@interface LockGateKeeperViewController () {
    
}
@property (nonatomic, strong) NSLock *lock;

@end

@implementation LockGateKeeperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"测试使用Lock实现gateKeeper", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cjTestButton1 = [DemoButtonFactory blueButton];
    [cjTestButton1 setTitle:@"开始_测试使用Lock实现gateKeeper" forState:UIControlStateNormal];
    [cjTestButton1 addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton1];
    
    UIButton *cjTestButton2 = [DemoButtonFactory blueButton];
    [cjTestButton2 setTitle:@"暂停_测试使用Lock实现gateKeeper" forState:UIControlStateNormal];
    [cjTestButton2 addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton2];
    
    UIButton *cjTestButton3 = [DemoButtonFactory blueButton];
    [cjTestButton3 setTitle:@"结束_测试使用Lock实现gateKeeper" forState:UIControlStateNormal];
    [cjTestButton3 addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton3];
    
    NSArray<UIButton *> *buttons = @[cjTestButton1, cjTestButton2, cjTestButton3];
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:44 leadSpacing:100 tailSpacing:20];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.lock = [[NSLock alloc] init];
}


- (void)start {
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    [self.lock lock];
    dispatch_async(quene, ^{
        NSLog(@"run task 1");
        sleep(2);
        NSLog(@"complete task 1");
        [self.lock unlock];
    });
    
    [self.lock lock];
    dispatch_async(quene, ^{
        NSLog(@"run task 2");
    });
    [self.lock lock];
    dispatch_async(quene, ^{
        NSLog(@"run task 3");
    });
    [self.lock lock];
    dispatch_async(quene, ^{
        NSLog(@"run task 4");
    });
    [self.lock lock];
    dispatch_async(quene, ^{
        NSLog(@"run task 5");
    });
}

- (void)pause {
    
}

- (void)stop {
    
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
