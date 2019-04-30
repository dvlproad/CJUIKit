//
//  BaseTableViewCellViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "BaseTableViewCellViewController.h"
#import "CJBaseTableViewCell+ConfigureForDataModel.h"
#import "TestDataUtil.h"

@interface BaseTableViewCellViewController () <UITableViewDataSource, UITableViewDelegate> {
    BOOL isAllSelected;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *sectionDataModels;

@property (nonatomic, strong) UIBarButtonItem *editBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *selectAllBarButtonItem;

@end

@implementation BaseTableViewCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"各种基础cell的Demo";
    self.editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editMyTableView:)];
    self.selectAllBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllDataModels)];
    self.navigationItem.rightBarButtonItem = self.editBarButtonItem;
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    [self setupTableView];
    
    self.sectionDataModels = [TestDataUtil testDataForDemoTableViewController];
}

- (void)setupTableView {
    /* ①、注册tableView所需的cell */
    /* 知识点(cell的注册):
    为了避免注册UITableViewCell后只能使用默认的样式，我们这里不注册，而是在委托方法里初始化
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[CJDefaultTableViewCell class]
           forCellReuseIdentifier:CJDefaultTableViewCellIdentifier];
    [self.tableView registerClass:[CJSubTitleTabelViewCell class]
           forCellReuseIdentifier:CJSubTitleTabelViewCellIdentifier];
    [self.tableView registerClass:[CJRightDetailTableViewCell class]
           forCellReuseIdentifier:CJRightDetailTableViewCellIdentifier];
    [self.tableView registerClass:[CJLeftDetailTableViewCell class]
           forCellReuseIdentifier:CJLeftDetailTableViewCellIdentifier];
    */
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomTableViewCell"];
    
    /* ②、设置tableView的数据源dataSource及其他协议等 */
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;//编辑模式下是否可以多选，没设置的话在选择时候容易导致图片被覆盖而没显示
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Event
- (void)editMyTableView:(UIBarButtonItem *)sender {
    if (self.tableView.isEditing == NO) {
        [self.tableView setEditing:YES animated:YES];
        self.editBarButtonItem.title = @"确定";
        
        isAllSelected = NO;
        self.navigationItem.rightBarButtonItems = @[self.editBarButtonItem, self.selectAllBarButtonItem];
    } else {
        [self.tableView setEditing:NO animated:YES];
        self.editBarButtonItem.title = @"编辑";
        self.navigationItem.rightBarButtonItems = @[self.editBarButtonItem];
    }
}

- (void)selectAllDataModels {
    self.selectAllBarButtonItem.title = isAllSelected ? @"取消全选" : @"全选";
    
    NSUInteger sectionCount = [self.sectionDataModels count];
    for (NSInteger section = 0; section < sectionCount; section++) {
        CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
        NSUInteger rowCount = sectionDataModel.values.count;
        for (NSInteger row = 0; row < rowCount; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            
            if (isAllSelected) {
                [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            } else {
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
        }
    }
    isAllSelected = !isAllSelected;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    return sectionDataModel.values.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    return sectionDataModel.theme;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    TestDataModel *dataModel = [sectionDataModel.values objectAtIndex:indexPath.row];

    switch (indexPath.section) {
        case 0: {
            static NSString *defaultCellIdentifier = @"CJBaseTableViewCell_Default";
            CJBaseTableViewCell *cell = (CJBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:defaultCellIdentifier];
            if (cell == nil) {
                cell = [[CJBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellIdentifier];
            }
            [cell default_configureForDataModel:dataModel];
            return cell;
            break;
        }
        case 1: { //rightDetail
            static NSString *value1CellIdentifier = @"CJBaseTableViewCell_Value1";
            CJBaseTableViewCell *cell = (CJBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:value1CellIdentifier];
            if (cell == nil) {
                cell = [[CJBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:value1CellIdentifier];
            }
            
            cell.cjDetailTextLabel.backgroundColor = [UIColor greenColor];
            [cell leftDetail_configureForDataModel:dataModel];
            
            return cell;
            break;
        }
        case 2: { //leftDetail
            static NSString *value2CellIdentifier = @"CJBaseTableViewCell_Value2";
            CJBaseTableViewCell *cell = (CJBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:value2CellIdentifier];
            if (cell == nil) {
                cell = [[CJBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:value2CellIdentifier];
            }
            
            cell.cjDetailTextLabel.backgroundColor = [UIColor greenColor];
            cell.cjDetailTextLabelWidth = 150;
            [cell rightDetail_configureForDataModel:dataModel];
            return cell;
            break;
        }
        case 3: {
            static NSString *subtitleCellIdentifier = @"CJBaseTableViewCell_Subtitle";
            CJBaseTableViewCell *cell = (CJBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:subtitleCellIdentifier];
            if (cell == nil) {
                cell = [[CJBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:subtitleCellIdentifier];
            }
            
            cell.cjDetailTextLabel.backgroundColor = [UIColor greenColor];
            cell.showCJImageView = NO;
            [cell subTitle_configureForDataModel:dataModel];
            return cell;
            break;
        }
        case 4: {
            /* 知识点(cell的注册):
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath]; //查询系统文档，其解释为 newer dequeue method guarantees a cell is returned and resized properly, assuming identifier is registered，即这个方法是只有你的这个cell identifier已经在之前registered过了，这边才能使用这个方法，否则如果没注册过identifier使用的时候会崩溃。此时对于没有注册过的，我们可以采用如下方法，该方法由于是在identifier未注册的时候使用，所以其允许我们使用cell实例的初始化方法
             */
            if (indexPath.row == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellStyleDefault"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellStyleDefault"];
                }
                cell.textLabel.text = @"UITableViewCellStyleDefault";
                cell.detailTextLabel.text = @"系统cell.detailTextLabel";
                return cell;
                
            } else if (indexPath.row == 1) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellStyleValue1"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCellStyleValue1"];
                }
                cell.textLabel.text = @"UITableViewCellStyleValue1";
                cell.detailTextLabel.text = @"系统cell.detailTextLabel";
                return cell;
                
            } else if (indexPath.row == 2) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellStyleValue2"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"UITableViewCellStyleValue2"];
                }
                cell.textLabel.text = @"UITableViewCellStyleValue2";
                cell.detailTextLabel.text = @"系统cell.detailTextLabel";
                return cell;
                
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellStyleSubtitle"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCellStyleSubtitle"];
                }
                cell.textLabel.text = @"UITableViewCellStyleSubtitle";
                cell.detailTextLabel.text = @"系统cell.detailTextLabel";
                return cell;
            }
            break;
        }
        default: {
            return nil;
            break;
        }
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了%zd-%zd", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableView.isEditing) {
        //附：在这里对左边选择的圆圈按钮进行定制，系统默认的为蓝色，这里有时候可能层级会发生过变化，因此做了判断。
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIImage *checkboxImage =  [UIImage imageNamed:@"cjCheckBoxOrangeYES"];
        if (cell.subviews.count > 3) {
            if (cell.subviews[3].subviews[0]) {
                ((UIImageView *)(cell.subviews[3].subviews[0])).image = checkboxImage;
            }
        } else {
            if (cell.subviews[2].subviews[0]) {
                ((UIImageView *)(cell.subviews[2].subviews[0])).image = checkboxImage;
            }
        }
        
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - 列表的编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (tableView.isEditing == NO) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
}


//设置可删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//左滑动出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark - 要实现删除等操作cell的动作，至少需要实现这个方法，其他方法都可以省略
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
//    // 从数据源中删除
//    [_data removeObjectAtIndex:indexPath.row];
//    // 从列表中删除
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
}

-(void)didReceiveMemoryWarning {
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
