//
//  UploadNoneImagePickerViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/3/31.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UploadNoneImagePickerViewController.h"

@interface UploadNoneImagePickerViewController ()

@end

@implementation UploadNoneImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"图片选择(没上传操作)", nil);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"批量选择照片，但没有上传操作";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_equalTo(120);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    CJImageAddDeletePickUploadCollectionView *collectionView = [[CJImageAddDeletePickUploadCollectionView alloc] init];
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
    
//    self.uploadImageCollectionView.belongToViewController = self;
    self.uploadImageCollectionView.mediaType = CJMediaTypeImage;
//    self.uploadImageCollectionView.equalCellSizeSetting.maxDataModelShowCount = 5; //TODO:
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
