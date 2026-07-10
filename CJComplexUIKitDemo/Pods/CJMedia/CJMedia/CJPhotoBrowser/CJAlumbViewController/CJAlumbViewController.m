//
//  CJAlumbViewController.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJAlumbViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "CJPhotoGroupTableViewCell.h"

@interface CJAlumbViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *groupArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewTop;

@property  (nonatomic, strong)  ALAssetsLibrary *assetsLibrary;
@end

@implementation CJAlumbViewController

- (ALAssetsLibrary *)assetsLibrary
{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

- (NSMutableArray *)groupArray
{
    if (!_groupArray) {
        _groupArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _groupArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; 
    self.title = @"相册";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.view addSubview:self.tableview];
    [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
    }];
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerClass:[CJPhotoGroupTableViewCell class]forCellReuseIdentifier:@"CJPhotoGroupTableViewCell"];
    
    
    [self.groupArray removeAllObjects ];
    
    __weak typeof(self)weakSelf = self;
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0)
        {
            [weakSelf.groupArray addObject:group];
        }
        else
        {
            [weakSelf.tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    };
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        //[self showNotAllowed];
    };
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                      usingBlock:listGroupBlock
                                    failureBlock:failureBlock];
    
    // Then all other groups
    NSUInteger type =
    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
    
    [self.assetsLibrary enumerateGroupsWithTypes:type
                                      usingBlock:listGroupBlock
                                    failureBlock:failureBlock];
}

-(void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CJPhotoGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CJPhotoGroupTableViewCell" forIndexPath:indexPath];
        
    ALAssetsGroup *group = [self.groupArray objectAtIndex:indexPath.row];

    cell.headView.image = [UIImage imageWithCGImage:[group posterImage]];
    cell.name.text = [group valueForProperty:ALAssetsGroupPropertyName];
    cell.num.text = [NSString stringWithFormat:@"(%@)",[@(group.numberOfAssets) stringValue]];
  
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@",self.groupArray[indexPath.row]);
    
    ALAssetsGroup *group = [self.groupArray objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NFUpdatePickerImageGroupArray" object:group];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
