//
//  ScrollViewHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ScrollViewHomeViewController.h"

//WebView
#import "EmptyWebViewController.h"

//DataScrollView
#import "SearchTableViewController.h"
#import "UploadNoneImagePickerViewController.h"
#import "UploadDirectlyImagePickerViewController.h"

@interface ScrollViewHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation ScrollViewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"ScrollViewHome首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //WebView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"WebView相关";
        
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"Web（Network & Empty）";
            webViewModule.classEntry = [EmptyWebViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"Web（Local & No Need Empty）";
            webViewModule.classEntry = [CJBaseWebViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    

    
    //DataScrollView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"DataScrollView(带数据源的滚动视图)";
        {
            CJModuleModel *searchTableViewModule = [[CJModuleModel alloc] init];
            searchTableViewModule.title = @"带搜索功能的列表";
            searchTableViewModule.classEntry = [SearchTableViewController class];
            [sectionDataModel.values addObject:searchTableViewModule];
        }
        {
            CJModuleModel *imagePickerCollectionViewModule = [[CJModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"图片选择的集合视图(没上传操作)";
            imagePickerCollectionViewModule.classEntry = [UploadNoneImagePickerViewController class];
            [sectionDataModel.values addObject:imagePickerCollectionViewModule];
        }
        {
            CJModuleModel *imagePickerCollectionViewModule = [[CJModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"图片选择的集合视图(有上传操作)";
            imagePickerCollectionViewModule.classEntry = [UploadDirectlyImagePickerViewController class];
            [sectionDataModel.values addObject:imagePickerCollectionViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CJModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CJModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    
    Class classEntry = moduleModel.classEntry;
    NSString *nibName = NSStringFromClass(moduleModel.classEntry);
    
    
    UIViewController *viewController = nil;
    
    NSArray *noxibViewControllers = @[NSStringFromClass([UIViewController class]),
                                      ];
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    if ([noxibViewControllers containsObject:clsString])
    {
        viewController = [[classEntry alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
    } else if ([clsString isEqualToString:NSStringFromClass([EmptyWebViewController class])]) {
        //NSString *networkUrl = @"https://fir.im/9u12";  //BeyondApp
        NSString *networkUrl = @"http://www.bbxpc.com/app_html/about_us/about.html";  //BBXAPPAbout
        
        EmptyWebViewController *webViewController = [[EmptyWebViewController alloc] init];
        webViewController.view.backgroundColor = [UIColor whiteColor];
        webViewController.title = NSLocalizedString(moduleModel.title, nil);
        webViewController.hidesBottomBarWhenPushed = YES;
        
        webViewController.todoProgressColor = [UIColor yellowColor];
        webViewController.doneProgressColor = [UIColor blueColor];
        webViewController.progressHeight = 10;
        webViewController.networkUrl = networkUrl;
        webViewController.webViewDidFinishNavigationBlcok = ^(WKWebView *webView) {
            if ([webView.URL.absoluteString isEqualToString:networkUrl]) {
                //http://www.cnblogs.com/gchlcc/p/6154844.html
                NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                NSString *jsString = [NSString stringWithFormat:@"setEdition('V%@')", appVersion];
                [webView evaluateJavaScript:jsString completionHandler:^(id _Nullable object, NSError * _Nullable error) {
                    NSLog(@"OC执行JS完成");
                }];
            }
        };
        
        [self.navigationController pushViewController:webViewController animated:YES];
        return;
        
    } else if ([clsString isEqualToString:NSStringFromClass([CJBaseWebViewController class])]) {
        CJBaseWebViewController *webViewController = [[CJBaseWebViewController alloc] init];
        webViewController.view.backgroundColor = [UIColor whiteColor];
        webViewController.title = NSLocalizedString(moduleModel.title, nil);
        webViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webViewController animated:YES];
        
        NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
        [webViewController reloadLocalWebWithUrl:localHtmlUrl]; //加载本地网页
        
        return;
        
    } else {
        viewController = [[classEntry alloc] initWithNibName:nibName bundle:nil];
    }
    viewController.title = NSLocalizedString(moduleModel.title, nil);
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
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
