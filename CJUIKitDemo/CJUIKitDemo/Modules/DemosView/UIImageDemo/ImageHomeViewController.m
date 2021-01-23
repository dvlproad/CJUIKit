//
//  ImageHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ImageHomeViewController.h"

#import "ImageGetterViewController.h"
#import "ImageChangeColorViewController.h"
#import "ImageRotateViewController.h"

#import "ImageSizeViewController.h"
#import "ImageCompressViewController.h"

#import "GifViewController.h"

@interface ImageHomeViewController ()

@end

@implementation ImageHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"Image首页", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //UIImage
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIImage相关";
        {
            CQDMModuleModel *imageChangeColorModule = [[CQDMModuleModel alloc] init];
            imageChangeColorModule.title = @"UIImage(图片获取)";
            imageChangeColorModule.classEntry = [ImageGetterViewController class];
            [sectionDataModel.values addObject:imageChangeColorModule];
        }
        {
            CQDMModuleModel *imageChangeColorModule = [[CQDMModuleModel alloc] init];
            imageChangeColorModule.title = @"UIImage(改变颜色)";
            imageChangeColorModule.classEntry = [ImageChangeColorViewController class];
            imageChangeColorModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:imageChangeColorModule];
        }
        {
            CQDMModuleModel *imageRotateModule = [[CQDMModuleModel alloc] init];
            imageRotateModule.title = @"UIImage(旋转任意角度)";
            imageRotateModule.classEntry = [ImageRotateViewController class];
            imageRotateModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:imageRotateModule];
        }
        {
            CQDMModuleModel *imageRotateModule = [[CQDMModuleModel alloc] init];
            imageRotateModule.title = @"UIImage Size (图片裁剪前后比对)";
            imageRotateModule.classEntry = [ImageSizeViewController class];
            [sectionDataModel.values addObject:imageRotateModule];
        }
        {
            CQDMModuleModel *imageRotateModule = [[CQDMModuleModel alloc] init];
            imageRotateModule.title = @"UIImage Compress (图片压缩前后比对)";
            imageRotateModule.classEntry = [ImageCompressViewController class];
            [sectionDataModel.values addObject:imageRotateModule];
        }
        {
            CQDMModuleModel *gifModule = [[CQDMModuleModel alloc] init];
            gifModule.title = @"Gif显示";
            gifModule.classEntry = [GifViewController class];
            [sectionDataModel.values addObject:gifModule];
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
