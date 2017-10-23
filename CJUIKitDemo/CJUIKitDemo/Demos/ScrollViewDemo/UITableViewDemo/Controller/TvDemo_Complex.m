//
//  TvDemo_Complex.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "TvDemo_Complex.h"
#import "DemoInfo.h"

#import "CustomTableViewCell.h"
#import "SHeaderHome2.h"

@interface TvDemo_Complex ()

@end

@implementation TvDemo_Complex

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"TvDemo_Complex", nil);
    
    sectionArray = @[@"早餐", @"午餐", @"晚餐", @"夜宵"];
    datas = [NSMutableArray arrayWithArray:@[@"豆浆", @"牛奶", @"面包"]];
    
    self.tv.dataSource = self;
    self.tv.delegate = self;
    
    UINib *registerNib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [self.tv registerNib:registerNib forCellReuseIdentifier:@"CustomTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

//Display customization 在Cell将要显示时调用此方法，可以在这里修改重用的Cell的一些属性，例如颜色。
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:@"icon.png"];
    cell.lab1.text = [datas objectAtIndex:indexPath.row];
    cell.lab2.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
    
    return cell;
}






- (IBAction)addInfo:(id)sender{
    
}


#pragma mark - SectionHeader & SectionFooter
//设置分区header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 48;
}

//设置分区footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

//每section的header显示的内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"header%ld", section];
}

//每section的footer显示的内容
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"footer%ld", section];
}

//通知委托将要显示分区header的视图
//11）tableView:willDisplayHeaderView:forSection:

//通知委托将要显示分区footer的视图
//12）tableView:willDisplayFooterView:forSection:



//设置分区的header的视图，可以为它添加图片或者其他控件（UIView的子类）
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SHeaderHome2 *sHeader = [[[NSBundle mainBundle] loadNibNamed:@"SHeaderHome2" owner:nil options:nil] lastObject];
    sHeader.lab.text = [NSString stringWithFormat:@"sectionHeader%ld", section];
    [sHeader.btn addTarget:self action:@selector(addInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    return sHeader;
}

//设置分区footer的视图，可以为它添加图片或者其他控件（UIView的子类）
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}



#pragma mark - 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{//索引内容的目录
    return sectionArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{//点击索引中的index位置，跳转到等于返回值的section
    if (index == 2) {
        return 1;
    }
    return 1;
}


/*
 3）tableview的属性和方法
 
 属性
 
 @property(nonatomic, readwrite, retain) UIView *backgroundView __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_2);
 // the background view will be automatically resized to track the size of the table view.  this will be placed as a subview of the table view behind all cells and headers/footers.  default may be non-nil for some devices.
 //设置tableview的背景
 
 @property(nonatomic) UITableViewCellSeparatorStyle separatorStyle;
 // default is UITableViewCellSeparatorStyleSingleLine
 //设置分割线的类型
 @property(nonatomic,retain) UIColor               *separatorColor;
 // default is the standard separator gray
 //设置分割线的颜色
 
 @property(nonatomic,retain) UIView *tableHeaderView;
 // accessory view for above row content. default is nil. not to be confused with section header
 //定制tableview的 header
 @property(nonatomic,retain) UIView *tableFooterView;                            // accessory view below content. default is nil. not to be confused with section footer
 //定制tableview的 footer
 
 @property(nonatomic,getter=isEditing) BOOL editing;
 // default is NO. setting is not animated.
 //设置tableview可编辑状态
 - (void)setEditing:(BOOL)editing animated:(BOOL)animated;
 
 方法
 
 - (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
 // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
 //重用已经创建的cell
 - (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
 - (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
 
 - (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
 //将 tableview 滚动到特定位置
 - (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
 
 
 2.疑惑，常见问题解决方法
 
 1）使 cell 不能被选中
 设置 UITableViewCell 的属性 selectionStyle 为 UITableViewCellSelectionStyleNone
 然后设置选中cell时什么也不做
 
 typedef enum {
 UITableViewCellSelectionStyleNone,
 UITableViewCellSelectionStyleBlue,
 UITableViewCellSelectionStyleGray
 } UITableViewCellSelectionStyle;
 
 2）设置tableview的背景颜色没有效果
 
 backgroundView属性对于某些设备默认时是存在的
 所以应如此设置背景颜色
 解决方法：
 [self.infoListTableView setBackgroundView:nil];
 [self.infoListTableView setBackgroundColor:[UIColor whiteColor]];
 
 //*/

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
