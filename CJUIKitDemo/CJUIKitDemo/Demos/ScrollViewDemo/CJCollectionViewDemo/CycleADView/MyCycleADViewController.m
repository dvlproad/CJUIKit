//
//  MyCycleADViewController.m
//  AllScrollViewDemo
//
//  Created by 李超前 on 2017/9/12.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyCycleADViewController.h"

@interface MyCycleADViewController ()

@end

@implementation MyCycleADViewController

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MyCycleADView *cycleADView = [[MyCycleADView alloc] initWithFrame:CGRectZero];
    cycleADView.backgroundColor = [UIColor redColor];
    [self.view addSubview:cycleADView];
    [cycleADView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_equalTo(74);
        make.left.mas_equalTo(self.view).mas_equalTo(10);
        make.right.mas_equalTo(self.view).mas_equalTo(-10);
        make.height.mas_equalTo(500);
    }];
    self.cycleADView = cycleADView;
    
    NSMutableArray *memoryADModels = [self getMemoryADModels];
    self.cycleADView.dataModels = memoryADModels;
}


- (NSMutableArray<MyADModel *> *)getMemoryADModels {
    NSMutableArray *adModels = [[NSMutableArray alloc] init];
    
    //提出问题Pose a question
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADPose01.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADPose02.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    //解释问题：Explain a question
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADExplain01.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    //需要的基础知识：Knowledge
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADKnowledge01.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADKnowledge02.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADKnowledge03.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADKnowledge04.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADKnowledge05.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADKnowledge06.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADKnowledge07.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    //使用示例/场景:Example
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADExample01.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADExample02.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADExample03.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADExample04.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADExample05.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    //学习它需要的时间：Time
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADTime01.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADTime02.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    //学习后能达到的效果：Result
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADResult01.gif";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    {
        MyADModel *adModel = [[MyADModel alloc] init];
        adModel.imageName = @"MemoryADResult02.jpg";
        adModel.text = @"";
        [adModels addObject:adModel];
    }
    
    return adModels;
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
