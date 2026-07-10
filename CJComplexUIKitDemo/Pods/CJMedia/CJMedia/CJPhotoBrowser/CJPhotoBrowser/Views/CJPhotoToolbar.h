//
//  CJPhotoToolbar.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef void (^CJPhotoToolbarCallback)(BOOL needRefresh);
typedef void (^CJSelectNumCallback)(NSInteger selectNum);

@interface CJPhotoToolbar : UIView {
    
}
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;

// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@property (nonatomic, strong) MBProgressHUD * hud;
@property (nonatomic, copy) CJPhotoToolbarCallback callback;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) NSInteger selectedNum;
@property (nonatomic, copy) CJSelectNumCallback selectNumCallBack;

@end




typedef void (^CJSentCallback)(BOOL sent);

@interface CJBottomToolbar : UIView {
    
}
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) NSNumber *sendNum;
@property (nonatomic, strong) UILabel *number;
@property (nonatomic, strong) NSString *numStr;
@property (nonatomic, copy) CJSentCallback sentCallBack;

@end







typedef void (^CJPhotoDeleteToolbarCallback)(NSNumber *currentNum);

@interface CJDeleteToolbar : UIView {
    
}
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@property (nonatomic, strong) MBProgressHUD * hud;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) NSInteger selectedNum;
@property (nonatomic, copy) CJPhotoDeleteToolbarCallback callback;
@property (nonatomic, copy) void(^backAction)(void);
@end
