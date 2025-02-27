//
//  ImageChangeColorViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ImageChangeColorViewController.h"
#import "UIImage+CJChangeColor.h"
#import "CJQRCodeUtil.h"

@interface ImageChangeColorViewController ()


@end

@implementation ImageChangeColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *originImage = [UIImage imageNamed:@"imageOriginColor"];
//    UIImage *originImage = [UIImage imageNamed:@"qq"];
    
    self.navigationItem.title = NSLocalizedString(@"ImageChangeColor首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Helper
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"原图";
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"原图";
            helperModule.normalImage = originImage;
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
            helperModule.title = @"改变图片大小 resizeToSize";
            helperModule.normalImage = [originImage cj_resizeToSize:CGSizeMake(100, 100)];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"tintColor";
            helperModule.content = @"kCGBlendModeDestinationIn";
            helperModule.normalImage = [originImage cj_imageWithTintColor:[UIColor orangeColor]];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"tintColor";
            helperModule.content = @"kCGBlendModeOverlay";
            helperModule.normalImage = [originImage cj_imageWithGradientTintColor:[UIColor orangeColor]];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"changeQRCodeImage";
            helperModule.normalImage = [CJQRCodeUtil changeQRCodeImage:originImage withColor:[UIColor orangeColor]];
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
            helperModule.title = @"tintColor";
            UIImage *newImage = originImage;
            newImage = [newImage cj_resizeToSize:CGSizeMake(30, 30)];
            helperModule.normalImage = newImage;
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CQDMModuleModel *helperModule = [[CQDMModuleModel alloc] init];
            helperModule.title = @"tintColor";
            UIImage *newImage = originImage;
            newImage = [newImage cj_resizeToSize:CGSizeMake(50, 50)];
            newImage = [newImage cj_imageWithTintColor:[UIColor whiteColor]];
            newImage = [newImage cj_addBackgroundColor:[UIColor redColor] backgroundSize:CGSizeMake(100, 100) imageSize:CGSizeMake(50, 50) cornerRadius:50];
            helperModule.normalImage = newImage;
            [sectionDataModel.values addObject:helperModule];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.perMaxCount = 2;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
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
