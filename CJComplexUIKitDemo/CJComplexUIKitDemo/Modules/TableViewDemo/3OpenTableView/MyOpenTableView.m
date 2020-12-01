//
//  MyOpenTableView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/21.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MyOpenTableView.h" //只需采用CJTableViewHeaderFooterView和CQDMSectionDataModel即可实现


@implementation CJOpenTableViewSetting



@end




@interface MyOpenTableView ()

@property (nonatomic, copy) NSString *headerIdentifier;
@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) CJTableViewHeaderBlock configureHeaderBlock;
@property (nonatomic, copy) CJTableViewCellBlock configureCellBlock;
@property (nonatomic, copy) CJTableViewDidSelectCellBlock didSelectRowBlock;

@end



@implementation MyOpenTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self commonInit];
    }
    return self;
}


/**
 *  tableView默认的初始化函数
 */
- (void)commonInit {
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    self.dataSource = self;
    self.delegate = self;
}


/** 完整的描述请参见文件头部 */
- (void)configureHeaderBlock:(CJTableViewHeaderBlock)aHeaderBlock
          configureCellBlock:(CJTableViewCellBlock)aCellBlock
           didSelectRowBlock:(CJTableViewCellBlock)aDidSelectRowBlock
{
    _configureCellBlock = aCellBlock;
    _configureHeaderBlock = aHeaderBlock;
    _didSelectRowBlock = aDidSelectRowBlock;
}

//reigster
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    [super registerNib:nib forCellReuseIdentifier:identifier];
    _cellIdentifier = identifier;
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [super registerClass:cellClass forCellReuseIdentifier:identifier];
    _cellIdentifier = identifier;
}

- (void)registerNib:(UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
    [super registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    _headerIdentifier = identifier;
}

- (void)registerClass:(Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
    [super registerClass:aClass forHeaderFooterViewReuseIdentifier:identifier];
    _headerIdentifier = identifier;
}






#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionModels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionModels objectAtIndex:section];
    NSInteger rowCount = [sectionDataModel.values count];
    
    return sectionDataModel.isSelected ? rowCount : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.setting.headerHeight) {
        return self.setting.headerHeight;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CJTableViewHeaderFooterView *header = (CJTableViewHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerIdentifier];
    header.belongToSection = section;
    
    __weak typeof(self)weakSelf = self;
    [header setTapHandle:^(NSInteger section) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf tapHeaderAtSection:section];
        }
    }];
    
    if (self.configureHeaderBlock) {
        self.configureHeaderBlock(header, section);
    }
    
    
    return header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath);
    }
    
    return cell;
}

#pragma mark - TableViewHeaderDelegate
/**
 *  点击了第几个Header
 *
 *  @param section section
 */
- (void)tapHeaderAtSection:(NSInteger)section {
    CQDMSectionDataModel *secctionModel = [self.sectionModels objectAtIndex:section];
    secctionModel.selected = !secctionModel.isSelected;
    
    [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(tableView, indexPath);
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
