//
//  CJPhotoBrowser.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJPhotoModel.h"
#import "CJPhotoToolbar.h"

@protocol CJPhotoBrowserDelegate;
typedef void (^DeleteCallback)(BOOL success);
typedef void (^PSentCallback)(BOOL success);
typedef void (^CurrentNumSentCallback)(NSNumber *currentNum);



/**
 *  自定义的“图片浏览器CJPhotoBrowser”
 */
@interface CJPhotoBrowser : UIViewController <UIScrollViewDelegate> {
    
}
// 代理
@property (nonatomic, weak) id<CJPhotoBrowserDelegate> delegate;
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@property (nonatomic, copy) CJPhotoToolbarCallback callback;
@property (nonatomic, copy) void(^backAction)(void);
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) NSInteger selectedNum;
@property (nonatomic,assign)  BOOL isDelete;
@property (nonatomic, copy) PSentCallback psentCallBack;
@property (nonatomic, copy) CurrentNumSentCallback currentNumCallback;

// 显示
- (void)show;
-(void)backACT;
-(void)deleteP:(NSInteger)index andPhotos:(NSArray *)photos;
@end

@protocol CJPhotoBrowserDelegate <NSObject>
@optional
// 切换到某一页图片
- (void)photoBrowser:(CJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;
@end
