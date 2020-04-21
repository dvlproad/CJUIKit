//
//  UploadDirectlyImagePickerViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/3/31.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UploadDirectlyImagePickerViewController.h"

#import "IjinbuNetworkClient+Login.h"
#import "IjinbuNetworkClient+UploadFile.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "TSButtonFactory.h"

@interface UploadDirectlyImagePickerViewController ()

@end

@implementation UploadDirectlyImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"图片选择(有上传操作)", nil);
    
    //执行上传之前，确保登录了
    [[IjinbuNetworkClient sharedInstance] requestijinbuLogin_name:@"15800000007" pasd:@"123456" completeBlock:^(IjinbuResponseModel *responseModel) {
        if (responseModel.status == 1) {
            NSLog(@"登录成功");
        } else {
            NSLog(@"登录失败");
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"批量选取照片，并在选择后上传";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_equalTo(120);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CJUploadImageCollectionView *collectionView = [[CJUploadImageCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(380);
    }];
    self.uploadImageCollectionView = collectionView;
    
    UIButton *themeBGButton1 = [TSButtonFactory themeBGButton];
    [themeBGButton1 setTitle:@"reloadCollectionView" forState:UIControlStateNormal];
    [themeBGButton1 addTarget:self action:@selector(reloadCollectionView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:themeBGButton1];
    [themeBGButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(collectionView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *themeBGButton2 = [TSButtonFactory themeBGButton];
    [themeBGButton2 setTitle:@"开始上传/继续上传没上传完的" forState:UIControlStateNormal];
    [themeBGButton2 addTarget:self action:@selector(uploadUnFinishImageModel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:themeBGButton2];
    [themeBGButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(themeBGButton1.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(themeBGButton1);
        make.centerX.mas_equalTo(themeBGButton1);
        make.height.mas_equalTo(themeBGButton1);
    }];

//    UIButton *themeBGButton3 = [TSButtonFactory themeBGButton];
//    [themeBGButton3 setTitle:@"CJExtralItemSettingTailing" forState:UIControlStateNormal];
//    [themeBGButton3 addTarget:self action:@selector(extralItemSettingTailing:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:themeBGButton3];
//    [themeBGButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(themeBGButton2.mas_bottom).mas_offset(10);
//        make.left.mas_equalTo(themeBGButton1);
//        make.centerX.mas_equalTo(themeBGButton1);
//        make.height.mas_equalTo(themeBGButton1);
//    }];
    
    
    
    self.uploadImageCollectionView.backgroundColor = [UIColor redColor];
//    self.uploadImageCollectionView.belongToViewController = self;
    self.uploadImageCollectionView.mediaType = CJMediaTypeImage;
//    self.uploadImageCollectionView.equalCellSizeSetting.maxDataModelShowCount = 5; //TODO:
    
    __weak typeof(self)weakSelf = self;
    [self.uploadImageCollectionView setPickImageCompleteBlock:^{
        [weakSelf.uploadImageCollectionView reloadData];
    }];
    
    
    /* 设置上传 */
    NSInteger uploadItemToWhere = 0; /** 可选：上传到哪里(一个项目中可能有好几个地方都要上传) */
    self.uploadImageCollectionView.uploadActionType = CJUploadActionTypeDirectly;
    self.uploadImageCollectionView.createDetailedUploadRequestBlock = ^NSURLSessionDataTask *(NSArray<CJUploadFileModel *> *uploadFileModels, CJUploadFileModelsOwner *itemThatSaveUploadInfo, void (^uploadInfoChangeBlock)(CJUploadFileModelsOwner *item)) {
        NSURLSessionDataTask *dataTask =
        [IjinbuNetworkClient detailedRequestUploadItems:uploadFileModels
                                                toWhere:uploadItemToWhere
                                andsaveUploadInfoToItem:itemThatSaveUploadInfo
                                  uploadInfoChangeBlock:uploadInfoChangeBlock];
        
        return dataTask;
    };
}


///开始上传/继续上传没上传完的
- (IBAction)uploadUnFinishImageModel:(id)sender {
    NSLog(@"对collectionView，开始上传/继续上传没上传完的");
}


- (IBAction)reloadCollectionView:(id)sender {
    [self.uploadImageCollectionView reloadData];
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
