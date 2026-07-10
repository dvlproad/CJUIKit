//
//  CJImagePickerViewController.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJImagePickerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "CJImagePickerTableView.h"


@interface CJImagePickerViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) int type;

@property (nonatomic, strong) CJImagePickerTableView *tableView;

@property (nonatomic, strong) NSMutableArray<CJAlumbImageModel *> *currentGroupAssetModels;    /**< 当前组的图片 */
@property (nonatomic, assign) BOOL hasMoreFav;
@property (nonatomic, assign) BOOL hasMoreAlbum;
@property (nonatomic, strong) UILabel * number;


@property (nonatomic, copy) void(^overLimitBlock)(void);
@property (nonatomic, copy) void (^clickImageBlock)(CJAlumbImageModel *imageModel); /**< 图片的点击操作 */
@property (nonatomic, copy) void(^previewAction)(NSArray *bTotoalImageModels, NSMutableArray<CJAlumbImageModel *> *bSelectedImageModels);
@property (nonatomic, copy) void(^pickFinishBlock)(UIViewController *bVC, NSArray<CJAlumbImageModel *> *bSelectedImageModels);



@end






@implementation CJImagePickerViewController

/*
 *  初始化
 *
 *  @param overLimitBlock       超过最大选择图片数量的限制回调
 *  @param clickImageBlock      点击图片执行的事件
 *  @param previewAction        点击底部左侧"预览"执行的事件
 *  @param pickFinishBlock      点击底部右侧"完成"执行的事件
 *
 *  @return 照片选择器
 */
- (instancetype)initWithOverLimitBlock:(void(^)(void))overLimitBlock
                       clickImageBlock:(void(^)(CJAlumbImageModel *imageModel))clickImageBlock
                         previewAction:(void(^)(NSArray *bTotoalImageModels, NSMutableArray<CJAlumbImageModel *> *bSelectedImageModels))previewAction
                       pickFinishBlock:(void(^)(UIViewController *bVC, NSArray<CJAlumbImageModel *> *bSelectedImageModels))pickFinishBlock
{
    if (self = [super init]) {
        self.overLimitBlock = overLimitBlock;
        self.clickImageBlock = clickImageBlock;
        self.previewAction = previewAction;
        self.pickFinishBlock = pickFinishBlock;
        
        _canMaxChooseImageCount = 9;
    }
    return self;
}

- (void)dealloc {
    _pickCompleteBlock = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NFUpdatePickerImageGroupArray" object:nil];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainGroupArray:) name:@"NFUpdatePickerImageGroupArray" object:nil];
    
    [self setupViews];
    

    [NSThread detachNewThreadSelector:@selector(reloadPhotoLibrary) toTarget:self withObject:nil];
    //[NSThread detachNewThreadSelector:@selector(obtainData) toTarget:ws withObject:nil];
    
    
    _currentGroupAssetModels = [[NSMutableArray alloc] init];
}


#pragma mark - Event
/// 点击底部左侧的-‘“预览”：预览照片
- (void)preview {
    if (self.previewAction) {
        self.previewAction(self.currentGroupAssetModels, self.tableView.selectedArray);
    }
}

/// 点击底部右侧的-‘“完成”
- (void)doneAction {
    if (self.pickFinishBlock) {
        self.pickFinishBlock(self, self.tableView.selectedArray);
    }
}


- (void)obtainGroupArray:(NSNotification *)notification {
    self.assetsGroup = notification.object;
    [self obtainData];
}

- (void)obtainData
{
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    if (!self.assets) {
        self.assets = [[NSMutableArray alloc] init];
    } else {
        [self.assets removeAllObjects];
    }
    
    [self.currentGroupAssetModels removeAllObjects];
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset) {
            [self.assets addObject:asset];
            if ([[asset valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto]) {
                NSString *url = [NSString stringWithFormat:@"%@",asset.defaultRepresentation.url];//图片的url
                CJAlumbImageModel *item = [[CJAlumbImageModel alloc] init];
                item.url = url;
                item.type = 1;
                
                [self.currentGroupAssetModels insertObject:item atIndex:0];
            }
            
        } else if (self.assets.count > 0) {
            [self hcRefreshViewDidDataUpdated];
        }
    };
    
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}




#pragma mark - SetupViews & Lazy
- (void)setupViews {
    // 图片列表
    __weak typeof(self)weakSelf = self;
    _tableView = [[CJImagePickerTableView alloc] initWithSelectedCountChangeBlock:^(NSMutableArray<CJAlumbImageModel *> *bSelectedArray) {
        weakSelf.number.text = [NSString stringWithFormat:@"(%zd)", bSelectedArray.count];
    } overLimitBlock:^{
        NSString *message = [NSString stringWithFormat:@"最多只能选%zd张图片", self.canMaxChooseImageCount];
        [self __showMessag:message toView:self.view];
        
    } clickImageBlock:^(CJAlumbImageModel *imageModel) {
        
    }];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
    }];
    
    // 底部（"预览"+"完成"）
    [self setupBottomView];
    
}

- (void)setupBottomView {
    /* 底部("预览"按钮、“完成”按钮、"选择的图片个数") */
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [UIColor colorWithRed:209/255.0f green:209/255.0f blue:209/255.0f alpha:1].CGColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
    
    UIButton *btnPreiview = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:blueTextColor forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [bottomView addSubview:doneButton];
    [doneButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.right.mas_equalTo(_number.mas_left).mas_equalTo(25);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
}


- (void)hcRefreshViewDidDataUpdated {
    [self.tableView reloadWithData:self.currentGroupAssetModels];
}



#pragma mark - 加载相册内容
- (void)reloadPhotoLibrary
{
    @autoreleasepool {
        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              //  [[UIAlertView bk_showAlertViewWithTitle:@"无法访问照片图库" message:nil cancelButtonTitle:@"好" otherButtonTitles:nil handler:nil] show];
                [self hcRefreshViewDidDataUpdated];
                [self.tableView reloadData];
            });
        };
        
        //迭代AlAssetsGroup的block：每迭代一次就把相应的AlAssetsGroup保存在一个可变的数组之中。AlAssetsGroup中的一些属性表明了这个相册的特征。
        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result,NSUInteger index, BOOL *stop){
            if (result!=NULL) {
                
                if ([[result valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto]) {
                    
                    NSString *url=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
                    CJAlumbImageModel * item = [[CJAlumbImageModel alloc] init];
                    item.url = url;
                    item.type = 1;
                    
                    [self.currentGroupAssetModels insertObject:item atIndex:0];
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

#pragma mark - Private Method
- (MBProgressHUD *)__showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    return hud;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
