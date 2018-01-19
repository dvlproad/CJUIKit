//
//  DemoTableViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DemoTableViewController.h"

#import "CJDefaultTableViewCell+ConfigureForDataModel.h"
#import "CJSubTitleTabelViewCell+ConfigureForDataModel.h"
#import "CJRightDetailTableViewCell+ConfigureForDataModel.h"
#import "CJLeftDetailTableViewCell+ConfigureForDataModel.h"
#import "CustomTableViewCell.h"

#import "TestDataUtil.h"

static NSString * const CJDefaultTableViewCellIdentifier = @"CJDefaultTableViewCell";
static NSString * const CJSubTitleTabelViewCellIdentifier = @"CJSubTitleTabelViewCell";
static NSString * const CJRightDetailTableViewCellIdentifier = @"CJRightDetailTableViewCell";
static NSString * const CJLeftDetailTableViewCellIdentifier = @"CJLeftDetailTableViewCell";

@interface DemoTableViewController () <UITableViewDataSource, UITableViewDelegate> {
    BOOL isAllSelected;
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *datas;

@property (nonatomic, strong) UIBarButtonItem *editBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *selectAllBarButtonItem;

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"各种基础cell的Demo";
    
    self.editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editMyTableView:)];
    self.selectAllBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllDataModels)];
    self.navigationItem.rightBarButtonItem = self.editBarButtonItem;
    
    [self setupTableView];
    
    self.datas = [TestDataUtil testDataForDemoTableViewController];
}

- (IBAction)editMyTableView:(UIBarButtonItem *)sender {
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
    
    NSUInteger sectionCount = [self.datas count];
    for (NSInteger section = 0; section < sectionCount; section++) {
        CJSectionDataModel *sectionDataModel = [self.datas objectAtIndex:section];
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

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /* ①、注册tableView所需的cell */
    /* 知识点(cell的注册):
    为了避免注册UITableViewCell后只能使用默认的样式，我们这里不注册，而是在委托方法里初始化
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    */
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomTableViewCell"];
    [self.tableView registerClass:[CJDefaultTableViewCell class]
           forCellReuseIdentifier:CJDefaultTableViewCellIdentifier];
    [self.tableView registerClass:[CJSubTitleTabelViewCell class]
           forCellReuseIdentifier:CJSubTitleTabelViewCellIdentifier];
    [self.tableView registerClass:[CJRightDetailTableViewCell class]
           forCellReuseIdentifier:CJRightDetailTableViewCellIdentifier];
    [self.tableView registerClass:[CJLeftDetailTableViewCell class]
           forCellReuseIdentifier:CJLeftDetailTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomTableViewCell"];
    
    /* ②、设置tableView的数据源dataSource及其他协议等 */
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;//编辑模式下是否可以多选，没设置的话在选择时候容易导致图片被覆盖而没显示
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.datas objectAtIndex:section];
    return sectionDataModel.values.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.datas objectAtIndex:section];
    
    return sectionDataModel.theme;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.datas objectAtIndex:indexPath.section];
    TestDataModel *dataModel = [sectionDataModel.values objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        CJDefaultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CJDefaultTableViewCellIdentifier forIndexPath:indexPath];
        [cell configureForDataModel:dataModel];
        return cell;
        
    } else if (indexPath.section == 1) {
        CJSubTitleTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CJSubTitleTabelViewCellIdentifier forIndexPath:indexPath];
        cell.cjDetailTextLabel.backgroundColor = [UIColor greenColor];
        cell.showCJImageView = NO;
        [cell configureForDataModel:dataModel];
        
        return cell;
        
    } else if (indexPath.section == 2) {
        CJRightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CJRightDetailTableViewCellIdentifier forIndexPath:indexPath];
        cell.cjDetailTextLabel.backgroundColor = [UIColor greenColor];
        cell.cjDetailTextLabelWidth = 150;
        [cell configureForDataModel:dataModel];
        
        return cell;
        
    } else if (indexPath.section == 3) {
        CJLeftDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CJLeftDetailTableViewCellIdentifier forIndexPath:indexPath];
        cell.cjDetailTextLabel.backgroundColor = [UIColor greenColor];
        [cell configureForDataModel:dataModel];
        
        return cell;
    } else if (indexPath.section == 4) {
        CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell" forIndexPath:indexPath];
        cell.lab1.text = dataModel.name;
        cell.lab2.text = dataModel.nickname;
        cell.lab1.backgroundColor = [UIColor greenColor];
        cell.lab2.backgroundColor = [UIColor redColor];
        cell.imageV.image = [UIImage imageNamed:@"icon.png"];
        return cell;
        
    } else {
        /* 知识点(cell的注册):
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath]; //查询系统文档，其解释为 newer dequeue method guarantees a cell is returned and resized properly, assuming identifier is registered，即这个方法是只有你的这个cell identifier已经在之前registered过了，这边才能使用这个方法，否则如果没注册过identifier使用的时候会崩溃。此时对于没有注册过的，我们可以采用如下方法，该方法由于是在identifier未注册的时候使用，所以其允许我们使用cell实例的初始化方法
         */
        
        if (indexPath.row == 0 || indexPath.row == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"systemCellValue1"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"systemCellValue1"];
            }
            
            
            cell.textLabel.text = @"UITableViewCellStyleValue1";
            cell.detailTextLabel.text = @"系统cell.detailTextLabel";
            
            return cell;
            
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"systemCellDefault"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"systemCellDefault"];
            }
            
            cell.textLabel.text = @"UITableViewCellStyleDefault";
            
            return cell;
        }
        
        
        
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了%ld-%ld", indexPath.section, indexPath.row);
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
