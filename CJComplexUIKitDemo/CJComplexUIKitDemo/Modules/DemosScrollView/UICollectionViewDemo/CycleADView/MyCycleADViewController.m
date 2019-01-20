//
//  MyCycleADViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/12.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyCycleADViewController.h"
#import "MemoryADCollectionViewCell.h"
#import "MyADModel.h"

@interface MyCycleADViewController ()

@end

@implementation MyCycleADViewController

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SDCycleScrollView *adScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    adScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:adScrollView];
    [adScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_equalTo(74);
        make.left.mas_equalTo(self.view).mas_equalTo(10);
        make.right.mas_equalTo(self.view).mas_equalTo(-10);
        make.height.mas_equalTo(500);
    }];
    self.adScrollView = adScrollView;
    
    NSMutableArray *memoryADModels = [self getMemoryADModels];
    self.adDataModels = memoryADModels;
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    NSMutableArray *imagesURLStrings = [[NSMutableArray alloc] init];
    for (MyADModel *adModel in memoryADModels) {
        [titles addObject:adModel.text];
        [imagesURLStrings addObject:adModel.imageName];
    }
    
    self.adScrollView.titlesGroup = titles;
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.adScrollView.imageURLStringsGroup = imagesURLStrings;
    });
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

// 不需要自定义轮播cell的请忽略下面的代理方法
// 如果要实现自定义cell的轮播图，必须先实现customCollectionViewCellClassForCycleScrollView:和setupCustomCell:forIndex:代理方法

- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view
{
    if (view != self.adScrollView) {
        return nil;
    }
    return [MemoryADCollectionViewCell class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view
{
    MemoryADCollectionViewCell *myCell = (MemoryADCollectionViewCell *)cell;
    //    [myCell.imageView sd_setImageWithURL:];
    
    MyADModel *adModel = self.adDataModels[index];
    NSString *imageName = adModel.imageName;
    UIImage *image = [UIImage imageNamed:imageName];
    myCell.imageView.image = image;
    
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
