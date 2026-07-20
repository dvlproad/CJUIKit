//
//  CQHorizontalTabBar.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQHorizontalTabBar.h"
#import <Masonry/Masonry.h>

static NSString * const tabCellIdentifier = @"CQHorizontalTabBarCell";

@interface CQHorizontalTabBar () <UICollectionViewDataSource, UICollectionViewDelegate> {
    
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) void (^tabSelectedBlock)(NSInteger index);

@end

@implementation CQHorizontalTabBar

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
              tabSelectedBlock:(void(^)(NSInteger index))tabSelectedBlock {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _titles = titles;
        _tabSelectedBlock = tabSelectedBlock;
        _selectedIndex = 0;
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithTitles:nil tabSelectedBlock:nil];
}

- (void)setupViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(80, 44);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:tabCellIdentifier];
    [self addSubview:self.collectionView];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    [self.collectionView reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self.collectionView reloadData];
}

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tabCellIdentifier forIndexPath:indexPath];

    UILabel *label = [cell.contentView viewWithTag:99];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
        label.tag = 99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:label];
    }

    label.text = self.titles[indexPath.row];
    label.textColor = (indexPath.row == self.selectedIndex) ? [UIColor whiteColor] : [UIColor darkGrayColor];
    cell.backgroundColor = (indexPath.row == self.selectedIndex) ? [UIColor colorWithRed:0.3 green:0.5 blue:0.9 alpha:1] : [UIColor clearColor];
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectedIndex) return;

    if (self.tabSelectedBlock) {
        self.tabSelectedBlock(indexPath.row);
    }
}

@end
