//
//  CJImagePickerViewController.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJImagePickerViewController.h"
#import "CJImagePickerViewController+UpdateGroupArray.h"

#import "CJValidateAuthorizationUtil.h"

#import "CJMultiColumnPhotoTableViewCell.h"

#import <AVFoundation/AVFoundation.h>

#import "CJPhotoBrowser.h"
#import "MBProgressHUD+CJPhotoBrowser.h"
#import "CJAlumbImageUtil.h"

#import "CJAlumbViewController.h"


@interface CJImagePickerViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) int type;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *selectedArray;    /**< 当前选择的图片 */
@property (nonatomic, assign) BOOL hasMoreFav;
@property (nonatomic, assign) BOOL hasMoreAlbum;
@property (nonatomic, strong) UILabel * number;


@end






@implementation CJImagePickerViewController

- (void)dealloc {
    _pickCompleteBlock = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NFUpdatePickerImageGroupArray" object:nil];
    
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _canMaxChooseImageCount = 9;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_selectedArray  removeAllObjects];
    _number.text = @"(0)";
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainGroupArray:) name:@"NFUpdatePickerImageGroupArray" object:nil];
    
    
    UIBarButtonItem *leftItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"相册", nil)
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(showPhotoes)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem =
    [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"取消", nil)
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(dismissVC)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setupViews];

    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL isAlbumEnable = [CJValidateAuthorizationUtil checkEnableForDeviceComponentType:CJDeviceComponentTypeAlbum inViewController:self];
        if(isAlbumEnable == NO){
            return;
        }
        [NSThread detachNewThreadSelector:@selector(reloadPhotoLibrary) toTarget:weakSelf withObject:nil];
       //[NSThread detachNewThreadSelector:@selector(obtainData) toTarget:ws withObject:nil]; 
    });
    
    
    
    _sectionDataModels = [[NSMutableArray alloc] init];
    AlumbSectionDataModel *sectionDataModel = [[AlumbSectionDataModel alloc] init];
    [_sectionDataModels addObject:sectionDataModel];
    
    _selectedArray = [[NSMutableArray alloc] init];
}





- (void)setupViews {
    __weak typeof(self)weakSelf = self;
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
    }];
    CJMultiColumnPhotoTableViewCell *registerCell = [[CJMultiColumnPhotoTableViewCell alloc] init];
    [_tableView registerClass:[registerCell class] forCellReuseIdentifier:@"cell"];
    
    
    /* 底部("预览"按钮、“完成”按钮、"选择的图片个数") */
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [UIColor colorWithRed:209/255.0f green:209/255.0f blue:209/255.0f alpha:1].CGColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tableView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
    
    UIButton * btnPreiview = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPreiview setTitle:@"预览" forState:UIControlStateNormal];
    [btnPreiview setTitleColor:blueTextColor forState:UIControlStateNormal];
    btnPreiview.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [bottomView addSubview:btnPreiview];
    [btnPreiview addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
    [btnPreiview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(10);
    }];
    
    
    _number = [[UILabel alloc] init];
    _number.font = [UIFont systemFontOfSize:16.0f];
    _number.text = @"(0)";
    _number.textColor = blueTextColor;
    _number.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:_number];
    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.right.mas_equalTo(-10);
        make.width.and.height.mas_equalTo(25);
    }];
    
    UIButton * btnSent = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnSent setTitle:@"完成" forState:UIControlStateNormal];
    [btnSent setTitleColor:blueTextColor forState:UIControlStateNormal];
    btnSent.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [bottomView addSubview:btnSent];
    [btnSent addTarget:self action:@selector(sent) forControlEvents:UIControlEventTouchUpInside];
    [btnSent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.right.mas_equalTo(_number.mas_left).mas_equalTo(25);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
}

///点击左上"相册"：进入到相册控制器
- (void)showPhotoes
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CJAlumbViewController" bundle:nil];
//    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"CJAlumbViewController"];
    CJAlumbViewController *viewController = [[CJAlumbViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

///点击右上“取消”
-(void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}






- (void)preview
{
    if (_selectedArray.count == 0) {
        return;
    }
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:_selectedArray.count];
    for (int i = 0; i<_selectedArray.count; i++) {
        AlumbImageModel * item = _selectedArray[i];
        CJPhotoModel *photo = [[CJPhotoModel alloc] init];
        photo.url = [NSURL URLWithString:item.url];
        if (item.type == 1) {
            photo.fav = YES;
        }
        photo.imageItem = item;
        [photos addObject:photo];
    }
    
    __weak typeof(self)weakSelf = self;
    
    // 2.显示相册
    CJPhotoBrowser *browser = [[CJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    browser.maxCount = self.canMaxChooseImageCount;
    browser.selectedNum = (int)_selectedArray.count;
     __weak CJPhotoBrowser * view = browser;
    browser.psentCallBack = ^(BOOL success)
    {
        
        for (CJPhotoModel * photo in view.photos) {
            if (!photo.imageItem.selected) {
                [weakSelf.selectedArray removeObject:photo.imageItem];
            }
        }
        weakSelf.number.text = [NSString stringWithFormat:@"(%d)", (int)weakSelf.selectedArray.count];
        [weakSelf hcRefreshViewDidDataUpdated];
         if (success) {
         [self sent];
        }
       
    };
    
    
   
    
    browser.callback = ^(BOOL needRefresh){
         
        for (CJPhotoModel * photo in view.photos) {
            if (!photo.imageItem.selected) {
                [weakSelf.selectedArray removeObject:photo.imageItem];
            }
        }
        weakSelf.number.text = [NSString stringWithFormat:@"(%d)", (int)weakSelf.selectedArray.count];
        [weakSelf hcRefreshViewDidDataUpdated];

       if (needRefresh) {
             [self sent];
        }
       
           };
    [browser show];
    
}

- (void)sent
{
    
    if (_selectedArray.count == 0) {
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (AlumbImageModel * item in _selectedArray) {
        if ([item.url hasPrefix:@"assets"]) {

            ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
            [assetLibrary assetForURL:[NSURL URLWithString:item.url] resultBlock:^(ALAsset *asset)  {
                UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                image = [CJAlumbImageUtil cj_fixOrientation:image];
                NSData *data = UIImageJPEGRepresentation(image, 0.8);
                NSString * path = [NSString stringWithFormat:@"%.0f.jpg", [[NSDate date] timeIntervalSince1970] * 1000];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
                NSString *document = [paths objectAtIndex:0];
                path = [[document stringByAppendingPathComponent:@"image"] stringByAppendingPathComponent:path];
                
                [data writeToFile:path atomically:YES];
                item.image = image;
                [array addObject:item];
            }failureBlock:^(NSError *error) {
                
            }];
           }else
           {
               [array addObject:item.url];
           }
           }
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (array.count != weakSelf.selectedArray.count) {
            // DONOTHING
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.pickCompleteBlock) {
                weakSelf.pickCompleteBlock(array);
            }
            
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        });
    });
    
}

#pragma mark - 加载相册内容
- (void)reloadPhotoLibrary
{
    @autoreleasepool {
        
        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              //  [[UIAlertView bk_showAlertViewWithTitle:@"无法访问照片图库" message:nil cancelButtonTitle:@"好" otherButtonTitles:nil handler:nil] show];
                [self hcRefreshViewDidDataUpdated];
            });
        };
        
        //迭代AlAssetsGroup的block：每迭代一次就把相应的AlAssetsGroup保存在一个可变的数组之中。AlAssetsGroup中的一些属性表明了这个相册的特征。
        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result,NSUInteger index, BOOL *stop){
            if (result!=NULL) {
                
                if ([[result valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto]) {
                    
                    NSString *url=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
                    AlumbImageModel * item = [[AlumbImageModel alloc] init];
                    item.url = url;
                    item.type = 1;
                    
                    AlumbSectionDataModel *sectionDataModel = self.sectionDataModels[0];
                    [sectionDataModel.values insertObject:item atIndex:0];
                }
            }
            
        };
        
        ALAssetsLibraryGroupsEnumerationResultsBlock libraryGroupsEnumeration = ^(ALAssetsGroup* group,BOOL* stop){
            
            if (group!=nil) {
                self.title = [group valueForProperty:ALAssetsGroupPropertyName];
                if (self.title.length == 0) {
                    self.title = @"选择照片";
                }

                [group enumerateAssetsUsingBlock:groupEnumerAtion];
            }
            if (stop) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hcRefreshViewDidDataUpdated];
                });
            }
        };
        
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        dispatch_async(dispatch_get_main_queue(), ^{
            //迭代获取相册ALAssetsGroup
            [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                   usingBlock:libraryGroupsEnumeration
                                 failureBlock:failureblock];
        });
    }
}


- (void)showPhotoViewer:(CJPhotoGridCell *)photoGridCell
{
    NSIndexPath *indexPath = photoGridCell.indexPath;
    AlumbSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < sectionDataModel.values.count; i++) {
        AlumbImageModel * item = sectionDataModel.values[i];
     
        CJPhotoModel *photo = [[CJPhotoModel alloc] init];
        if (item.type == 1) {
            photo.fav = YES;
        }
        photo.url = [NSURL URLWithString:item.url];
        photo.imageItem = item;
        [array addObject:photo];
    }
    
    __weak typeof(self)weakSelf = self;
    
    // 2.显示相册
    CJPhotoBrowser *browser = [[CJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = indexPath.item; // 弹出相册时显示的第一张图片是？
    browser.photos = array; // 设置所有的图片
    browser.maxCount = self.canMaxChooseImageCount;
    browser.selectedNum = self.selectedArray.count;
    
    __weak CJPhotoBrowser * view = browser;
    browser.psentCallBack = ^(BOOL success)
    {
         
        
        for (CJPhotoModel * photo in view.photos) 
        {
            
            [weakSelf.selectedArray removeObject:photo.imageItem];
            
            if (photo.imageItem.selected && weakSelf.selectedArray.count < weakSelf.canMaxChooseImageCount) {
                [weakSelf.selectedArray addObject:photo.imageItem];
            } else {
                photo.imageItem.selected = NO;
            }
            
        }
        
        weakSelf.number.text = [NSString stringWithFormat:@"(%d)", (int)weakSelf.selectedArray.count];
        [weakSelf hcRefreshViewDidDataUpdated];

        if (success) 
        {
       
            [self sent];
        }
        };
    browser.callback = ^(BOOL needRefresh){
       
        for (CJPhotoModel * photo in view.photos) 
        {
            
            [weakSelf.selectedArray removeObject:photo.imageItem];
            
            if (photo.imageItem.selected && weakSelf.selectedArray.count < weakSelf.canMaxChooseImageCount) {
                [weakSelf.selectedArray addObject:photo.imageItem];
            } else {
                photo.imageItem.selected = NO;
            }
            
        }
            weakSelf.number.text = [NSString stringWithFormat:@"(%d)", (int)weakSelf.selectedArray.count];
            [weakSelf hcRefreshViewDidDataUpdated];
         if (needRefresh ) {
            [self sent];
        }
        
    };
    [browser show];

}

- (void)onImageSelectedChanged:(CJPhotoGridCell *)photoGridCell
{
    NSIndexPath *indexPath = photoGridCell.indexPath;
    AlumbSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    AlumbImageModel * item = sectionDataModel.values[indexPath.item];
    item.selected = !item.selected;
    photoGridCell.selected = item.selected;
    if (item.selected) {
        if (_selectedArray.count >= self.canMaxChooseImageCount) {
            item.selected = NO;
            NSString *message = [NSString stringWithFormat:@"最多只能选%zd张图片", self.canMaxChooseImageCount];
            [MBProgressHUD showMessag:message toView:self.view];
            return;
        }
        [_selectedArray addObject:item];
    } else {
        [_selectedArray removeObject:item];
    }
    _number.text = [NSString stringWithFormat:@"(%d)", (int)_selectedArray.count];
}

#pragma mark - UIScrollView Delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [_tableView hcTableViewDidScroll];
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [_tableView hcTableViewWillBeginDragging];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [_tableView hcTableViewDidEndDragging];
//}

#pragma mark - HCRefreshView Delegate
- (void)hcRefreshViewDidPullDownToRefresh
{
}

- (void)hcRefreshViewDidPullUpToLoad
{
}

- (void)hcRefreshViewDidDataUpdated
{
//    [_tableView hcTableViewDidDataUpdated];
    [self.tableView reloadData];
}

#pragma mark - UITableView Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return _sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AlumbSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    if (0 == fmod(sectionDataModel.values.count, 4)) {
        return sectionDataModel.values.count / 4;
    } else {
        return sectionDataModel.values.count / 4 + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (tableView.frame.size.width - 25) / 4;
    return width + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJMultiColumnPhotoTableViewCell *cell = (CJMultiColumnPhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    cell.gridCellImageButtonTapBlock = ^ (CJPhotoGridCell *photoGridCell) {
        [weakSelf showPhotoViewer:photoGridCell];
    };
    
    cell.gridCellCheckButtonTapBlock = ^ (CJPhotoGridCell *photoGridCell) {
        [weakSelf onImageSelectedChanged:photoGridCell];
    };
    
    
    
    NSInteger section = indexPath.section;
    AlumbSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    for (int i = 0; i < 4; i++) {
        NSInteger index = 4 * indexPath.row + i;
        
        AlumbImageModel *imageItem = nil;
        if (index < sectionDataModel.values.count) {
            imageItem = sectionDataModel.values[index];
        }
        
        CJPhotoGridCell *photoGridCell = [cell.contentView viewWithTag:1000+i];
        photoGridCell.indexPath = [NSIndexPath indexPathForItem:index inSection:section];
        photoGridCell.imageItem = imageItem;
        
        //更新gridCellWidth的约束(之前的等宽是根据frame设置的)
        CGFloat gridCellWidth = (CGRectGetWidth(tableView.frame) - 25) / 4;
        [photoGridCell mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(5 * (i+1) + gridCellWidth * i);
            make.width.height.mas_equalTo(gridCellWidth);
        }];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
