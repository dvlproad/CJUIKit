//
//  MyOpenTableView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/21.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CJTableViewHeaderBlock)(id header, NSInteger section);
typedef void (^CJTableViewCellBlock)(id cell, NSIndexPath *indexPath);
typedef void (^CJTableViewDidSelectCellBlock)(id tableView, NSIndexPath *indexPath);





/**
 *  MyOpenTableView的设置
 */
@interface CJOpenTableViewSetting : NSObject {
    
}
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat cellHeight;

@end





@class MyOpenTableView;
@protocol CJOpenTableViewDelegate <NSObject>

/**
 *  点击Header事件
 *
 *  @param tableView    The table view object that is notifying you of the selection change.
 *  @param section      The section of the reusableView that was selected.
 */
- (void)cjOpenTableView:(MyOpenTableView *)tableView didSelectHeaderInSection:(NSInteger)section;

/**
 *  点击Item事件
 *
 *  @param tableView    The table view object that is notifying you of the selection change.
 *  @param indexPath    The index path of the cell that was selected.
 */
- (void)cjOpenTableView:(MyOpenTableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath;


@end




@protocol CJOpenTableViewDataSource <NSObject>
@required
/**
 *  指定section的个数
 *
 *  @param tableView    The table view requesting this information.
 *
 *  @return The number of sections in collectionView.
 */
- (NSInteger)cjOpenTableView_numberOfSectionsInTableView:(MyOpenTableView *)tableView;

/**
 *  指定section下对应的item的个数
 *
 *  @param tableView    The table view requesting this information.
 *  @param section      An index number identifying a section in collectionView. This index value is 0-based.
 *
 *  @return The number of rows in section.
 */
- (NSInteger)cjOpenTableView:(MyOpenTableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end


#import "CJTableViewHeaderFooterView.h"
#import "MySectionModel.h"
/**
 *  自定义的MyOpenTableView类
 */
@interface MyOpenTableView : UITableView <UITableViewDataSource, UITableViewDelegate> {
    
}
//@property (nonatomic, assign) id <CJOpenTableViewDataSource> openDataSource;
//@property (nonatomic, assign) id <CJOpenTableViewDelegate> openDelegate;

@property (nonatomic, strong) NSMutableArray<MySectionModel *> *sectionModels;
@property (nonatomic, strong) CJOpenTableViewSetting *setting;
/**
 *  对Header、Cell进行定制、以及点击Cell的block
 *
 *  @param aHeaderBlock         对Header进行定制的block
 *  @param aCellBlock           对cell进行定制的block
 *  @param aDidSelectRowBlock   对cell进行点击的block
 */
- (void)configureHeaderBlock:(CJTableViewHeaderBlock)aHeaderBlock
          configureCellBlock:(CJTableViewCellBlock)aCellBlock
           didSelectRowBlock:(CJTableViewDidSelectCellBlock)aDidSelectRowBlock;

@end
