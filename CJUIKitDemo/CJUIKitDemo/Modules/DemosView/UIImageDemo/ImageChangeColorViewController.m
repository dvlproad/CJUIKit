//
//  ImageChangeColorViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ImageChangeColorViewController.h"
#import <CQDemoKit/CQTSRipeButtonCollectionView.h>
#import <CQDemoKit/UIView+CQAuxiliaryText.h>
#import "UIImage+CJChangeColor.h"
#import "CJQRCodeUtil.h"

@interface ImageChangeColorViewController () {
    
}
@property (nonatomic, strong) UIImage *originImage;


@end

@implementation ImageChangeColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    UIImage *originImage = [UIImage imageNamed:@"imageOriginColor"]; // TODO: 这张图片就不行
    self.originImage = [UIImage imageNamed:@"qq"];
    
    self.navigationItem.title = NSLocalizedString(@"ImageChangeColor首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    __weak typeof(self)weakSelf = self;
    
    NSArray<NSString *> *buttonTitles = @[@"星星", @"qq", @"按钮03", @"按钮04", @"按钮05", @"按钮06", @"按钮07", @"按钮08", @"按钮09", @"按钮10"];
    CQTSRipeButtonCollectionView *buttonCollectionView = [[CQTSRipeButtonCollectionView alloc] initWithTitles:buttonTitles perMaxCount:1 widthHeightRatio:2.0/1.0 scrollDirection:UICollectionViewScrollDirectionHorizontal didSelectItemAtIndexHandle:^(NSInteger index) {
        NSString *title = buttonTitles[index];
        NSLog(@"点击了“%@”", title);
        if (index == 0) {
            weakSelf.originImage = [UIImage imageNamed:@"imageOriginColor"];
            [weakSelf getSectionDatas];
            [weakSelf.collectionView reloadData];
        } else if (index == 1) {
            weakSelf.originImage = [UIImage imageNamed:@"qq"];
            [weakSelf getSectionDatas];
            [weakSelf.collectionView reloadData];
        }
    }];
    buttonCollectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    buttonCollectionView.cellConfigBlock = ^(UICollectionViewCell * _Nonnull bCell) {
        bCell.contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        bCell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    };
    [self.view addSubview:buttonCollectionView];
    [buttonCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        } else {
            // Fallback on earlier versions
            // topLayoutGuide\bottomLayoutGuide iOS11已经被弃用
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(10);
        }
        make.height.mas_equalTo(60);
    }];
    
    
    self.perMaxCount = 2;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self getSectionDatas];
}

- (void)getSectionDatas {
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Helper
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"原图";
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"原图";
            helperModule.normalImage = self.originImage;
            [sectionDataModel.values addObject:helperModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Helper
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"改变图片颜色";
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"改变图片大小 resizeToSize(实际上有效)";
            helperModule.normalImage = [self.originImage cj_resizeToSize:CGSizeMake(100, 100)];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"tintColor";
            helperModule.content = @"kCGBlendModeDestinationIn";
            helperModule.normalImage = [self.originImage cj_imageWithTintColor:[UIColor orangeColor]];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"tintColor";
            helperModule.content = @"kCGBlendModeOverlay";
            helperModule.normalImage = [self.originImage cj_imageWithGradientTintColor:[UIColor orangeColor]];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"changeQRCodeImage";
            helperModule.normalImage = [CJQRCodeUtil changeQRCodeImage:self.originImage withColor:[UIColor orangeColor]];
            [sectionDataModel.values addObject:helperModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Helper
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"为图片添加背景和修改颜色";

        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"错误示例:不先 resizeToSize 会有问题";
            UIImage *newImage = self.originImage;
            //newImage = [newImage cj_resizeToSize:CGSizeMake(50, 50)];
            newImage = [newImage cj_imageWithTintColor:[UIColor whiteColor]];
            newImage = [newImage cj_addBackgroundColor:[UIColor redColor] backgroundSize:CGSizeMake(100, 100) imageSize:CGSizeMake(50, 50) cornerRadius:50];
            helperModule.normalImage = newImage;
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"正确示例:resizeToSize + tintColor + addBackgroundColor";
            UIImage *newImage = self.originImage;
            newImage = [newImage cj_resizeToSize:CGSizeMake(50, 50)];
            newImage = [newImage cj_imageWithTintColor:[UIColor whiteColor]];
            newImage = [newImage cj_addBackgroundColor:[UIColor redColor] backgroundSize:CGSizeMake(100, 100) imageSize:CGSizeMake(100, 100) cornerRadius:50];
//            newImage = [newImage cj_imageWithTintColor:[UIColor yellowColor]];
            helperModule.normalImage = newImage;
            [sectionDataModel.values addObject:helperModule];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    self.sectionDataModels = sectionDataModels;
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
