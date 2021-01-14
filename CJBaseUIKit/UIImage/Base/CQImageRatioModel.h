//
//  CQImageRatioModel.h
//  BiaoliApp
//
//  Created by qian on 2021/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 要裁剪的边
typedef NS_ENUM(NSUInteger, CQTrimmedEdge) {
    CQTrimmedEdgeNone,          /**< 不用裁剪 */
    CQTrimmedEdgeWidth,         /**< 裁剪宽（宽太宽，宽高比超过最大比例，裁剪宽） */
    CQTrimmedEdgeHeight,        /**< 裁剪高（高太高，宽高比小于最小比例，裁剪高） */
};

@interface CQImageRatioModel : NSObject {
    
}
@property (nonatomic, assign) CGFloat hopeNewRatio;         /**< 裁剪后最后的希望比例 */
@property (nonatomic, assign) CQTrimmedEdge trimmedEdge;    /**< 要裁剪的边 */
@property (nonatomic, assign) CGFloat newWidth;             /**< 裁剪后的宽（宽高可能有一个变，一个不变） */
@property (nonatomic, assign) CGFloat newHeight;            /**< 裁剪后的高（宽高可能有一个变，一个不变） */

@end

NS_ASSUME_NONNULL_END
