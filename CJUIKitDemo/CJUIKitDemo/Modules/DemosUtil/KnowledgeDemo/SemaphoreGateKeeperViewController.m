//
//  SemaphoreGateKeeperViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/11.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "SemaphoreGateKeeperViewController.h"
#import "DemoButtonFactory.h"

@interface SemaphoreGateKeeperViewController () {
    
}
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation SemaphoreGateKeeperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"测试使用semaphore实现gateKeeper", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cjTestButton1 = [DemoButtonFactory blueButton];
    [cjTestButton1 setTitle:@"开始_测试使用semaphore实现gateKeeper" forState:UIControlStateNormal];
    [cjTestButton1 addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton1];
    
    UIButton *cjTestButton2 = [DemoButtonFactory blueButton];
    [cjTestButton2 setTitle:@"暂停_测试使用semaphore实现gateKeeper" forState:UIControlStateNormal];
    [cjTestButton2 addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton2];
    
    UIButton *cjTestButton3 = [DemoButtonFactory blueButton];
    [cjTestButton3 setTitle:@"结束_测试使用semaphore实现gateKeeper" forState:UIControlStateNormal];
    [cjTestButton3 addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton3];
    
    NSArray<UIButton *> *buttons = @[cjTestButton1, cjTestButton2, cjTestButton3];
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:44 leadSpacing:100 tailSpacing:20];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
}


- (void)start {
    NSLog(@"-------   semaphoreGateKeeper测试   ------------");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    self.semaphore = semaphore;
    
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSInteger concurrencyCount = 3;  //并发数
    //任务1
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(quene, ^{
        NSLog(@"run task 1");
        sleep(3);
        NSLog(@"complete task 1");
        
        for (NSInteger i = 0; i < concurrencyCount; i++) {
            dispatch_semaphore_signal(semaphore);
        }
////        semaphore = dispatch_semaphore_create(1000);
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////            semaphore = nil;
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //更新界面
//                semaphore = nil;
//            });
//        });
    });
    
    
    for (NSInteger i = 0; i < 10; i++) {
        [self createNewTaskWithIndex:i+1];
    }
}

- (void)createNewTaskWithIndex:(NSInteger)taskIndex {
    dispatch_time_t timeout = DISPATCH_TIME_FOREVER;
//    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 6.0f * NSEC_PER_SEC);
    
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_wait(self.semaphore, timeout);
    dispatch_async(quene, ^{
        NSLog(@"task %zd run", taskIndex);
        sleep(3);
        NSLog(@"task %zd complete", taskIndex);
        dispatch_semaphore_signal(self.semaphore);
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
