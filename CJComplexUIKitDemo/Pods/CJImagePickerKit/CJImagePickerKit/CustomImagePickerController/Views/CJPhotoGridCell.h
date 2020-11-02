//
//  CJPhotoGridCell.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#import "CJAlumbImageModel.h"

@interface CJPhotoGridCell : UIView {
    
}
@property (nonatomic, strong) NSIndexPath *indexPath;   /**< 位置 */
@property (nonatomic, assign) BOOL selected;            /**< 当前PhotoGridCell是否被选中 */
@property (nonatomic, strong) CJAlumbImageModel *imageItem;

@property (nonatomic, copy) void (^imageButtonTapBlock)(void); /**< 图片的点击操作 */
@property (nonatomic, copy) void (^checkButtonTapBlock)(void); /**< 选择框的点击操作 */


@end
