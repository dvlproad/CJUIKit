//
//  CJRelatedPickerRichView.m
//  CJRelatedPickerRichViewDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJRelatedPickerRichView.h"

#define kTableViewTagBegin  1010

@implementation CJRelatedPickerRichView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

- (void)setComponentDataModels:(NSMutableArray<CJComponentDataModel *> *)componentDataModels {
    _componentDataModels = componentDataModels;
    
    NSInteger listNum = [componentDataModels count];
    componentCount = listNum;

    
    //修改tableview的frame
    CGFloat width = self.frame.size.width;
    if(width <= 0){
        NSLog(@"检查下是否忘记设置frame，而导致width为0");
    }
    int componentWidth = width/componentCount;
    
    //UIView *lastView = nil;
    for(int i = 0; i < componentCount; i++) {
        CGRect rect = CGRectMake(componentWidth*i, 0, componentWidth, self.frame.size.height);
        UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = kTableViewTagBegin+i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        
        /*
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:tableView
                                      attribute:NSLayoutAttributeTop    //top
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeTop
                                     multiplier:1
                                       constant:0]];
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:tableView
                                      attribute:NSLayoutAttributeBottom //bottom
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1
                                       constant:0]];
        
        if (lastView == nil) {
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:tableView
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self
                                          attribute:NSLayoutAttributeLeft   //left
                                         multiplier:1
                                           constant:0]];
        } else {
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:tableView
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:lastView
                                          attribute:NSLayoutAttributeRight   //left
                                         multiplier:1
                                           constant:0]];
        }
        */
        
    }
    
    [self updateTableViewsFromComponentIndex:0];
}

/** 完整的描述请参见文件头部 */
- (void)updateTableViewBackgroundColor:(UIColor *)color inComponent:(NSInteger)component {
    UITableView *tv = (UITableView *)[self viewWithTag:kTableViewTagBegin+component];
    [tv setBackgroundColor:color];
}


#pragma mark -- UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger component = tableView.tag - kTableViewTagBegin;
    CJComponentDataModel *sectionDataModel = self.componentDataModels[component];
    NSArray *componentDatas = sectionDataModel.values;
//    NSArray *componentDatas = nil;
//    if (component == 0) {
//        componentDatas = self.componentDataModels;
//    } else {
//        componentDatas = self.componentDataModels[0].members;
//    }
    
    return [componentDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    NSInteger component = tableView.tag - kTableViewTagBegin;
    CJComponentDataModel *sectionDataModel = self.componentDataModels[component];
    NSArray *componentDatas = sectionDataModel.values;
    
    CJDataModelSample *componentModelData = [componentDatas objectAtIndex:indexPath.row];
    NSString *text = componentModelData.text;
    BOOL isHaveNext = componentModelData.containValueCount > 0 ? YES : NO;
    
    cell.textLabel.text = text;
    if(isHaveNext){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}


#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger component = tableView.tag - kTableViewTagBegin;
    
    [self didSelectRow:indexPath.row inComponent:component];
    
    CJComponentDataModel *sectionDataModel = self.componentDataModels[component];
    NSArray *componentDatas = sectionDataModel.values;
    
    CJDataModelSample *componentModelData = [componentDatas objectAtIndex:indexPath.row];
    NSString *text = componentModelData.text;
    BOOL isHaveNext = componentModelData.containValueCount > 0 ? YES : NO;
    
    if(isHaveNext){ //如果有下个操作，则更新后续的列表，,如果有没有，也要更新。防止之前的数据残留。
        [self updateTableViewsFromComponentIndex:component+1];
        
    }else{
        if (component+1 <= componentCount-1) {
            [self updateTableViewsFromComponentIndex:component+1];
        }
        
        if([self.delegate respondsToSelector:@selector(cj_RelatedPickerRichView:didSelectText:)]){
            [self.delegate cj_RelatedPickerRichView:self didSelectText:text];
        }
    }
}


/**
 *  点击第component个列表中的row行，更新 selecteds_index 和 selecteds_titles。
 *
 *  @param row       列表点击的行
 *  @param component 第component个列表
 */
- (void)didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    NSMutableArray *selectedIndexs = [NSMutableArray arrayWithArray:self.dataGroupModel.selectedIndexs];
    NSMutableArray *selectedIndexs = [[NSMutableArray alloc] init];
    for (CJComponentDataModel *componentDataModel in self.componentDataModels) {
        NSString *indexString = [NSString stringWithFormat:@"%zd", componentDataModel.selectedIndex];
        [selectedIndexs addObject:indexString];
    }
    
    [selectedIndexs replaceObjectAtIndex:component withObject:[NSString stringWithFormat:@"%zd", row]];
    for (NSInteger i = component+1; i < componentCount; i++) {
        [selectedIndexs replaceObjectAtIndex:i withObject:@"0"];//注意:点击当前列表之后，后续的其他列表的selectedIndexs改为0
    }
    [CJComponentDataModelUtil updateSelectedIndexs:selectedIndexs inComponentDataModels:self.componentDataModels];
}


/**
 *  更新从第component个开始的每个列表tableView
 *
 *  @param componentIndexStart componentIndexStart
 */
- (void)updateTableViewsFromComponentIndex:(NSInteger)componentIndexStart {
    for(NSInteger  component= componentIndexStart; component < componentCount; component++) {
        UITableView *tableView = (UITableView *)[self viewWithTag:kTableViewTagBegin+component];
        [tableView reloadData];
        
        NSMutableArray *selectedIndexs = [[NSMutableArray alloc] init];
        for (CJComponentDataModel *componentDataModel in self.componentDataModels) {
            NSString *indexString = [NSString stringWithFormat:@"%zd", componentDataModel.selectedIndex];
            [selectedIndexs addObject:indexString];
        }
        NSString *selectedIndex = [selectedIndexs objectAtIndex:component];
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:[selectedIndex integerValue] inSection:0];
        [tableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
