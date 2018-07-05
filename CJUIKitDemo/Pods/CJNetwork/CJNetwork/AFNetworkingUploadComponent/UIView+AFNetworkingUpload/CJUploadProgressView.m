//
//  CJUploadProgressView.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/8/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUploadProgressView.h"

@interface CJUploadProgressView () {
    
}
@property (nonatomic, strong) UILabel *cjUploadProgressLabel;
@property (nonatomic, strong) UIView *cjUploadProgressMaskView; /**< 标记剩下多少没处理(即没上传) */
@property (nonatomic, strong) NSLayoutConstraint *cjUploadProgressMaskViewHeightConstraint;

@end

@implementation CJUploadProgressView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
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

- (void)commonInit {
    UIView *parentView = self;
    
    self.cjUploadProgressMaskView = [[UIView alloc] initWithFrame:CGRectZero];
    self.cjUploadProgressMaskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    //self.cjUploadProgressMaskView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reUpload:)];
    [self.cjUploadProgressMaskView addGestureRecognizer:tapGR];
    self.cjUploadProgressMaskView.userInteractionEnabled = YES; //根据上传状态设置是否可以点击
    [parentView addSubview:self.cjUploadProgressMaskView];
    
    self.cjUploadProgressMaskView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjUploadProgressMaskView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjUploadProgressMaskView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjUploadProgressMaskView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    
    self.cjUploadProgressMaskViewHeightConstraint =
    [NSLayoutConstraint constraintWithItem:self.cjUploadProgressMaskView
                                 attribute:NSLayoutAttributeHeight   //height
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:parentView
                                 attribute:NSLayoutAttributeHeight
                                multiplier:0
                                  constant:0];
    [parentView addConstraint:self.cjUploadProgressMaskViewHeightConstraint];
    
    
    self.cjUploadProgressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //self.cjUploadProgressLabel.backgroundColor = [UIColor cyanColor];
    //self.cjUploadProgressLabel.text = [NSString stringWithFormat:@"0%%"];
    self.cjUploadProgressLabel.numberOfLines = 0;
    self.cjUploadProgressLabel.textColor = [UIColor whiteColor];
    self.cjUploadProgressLabel.textAlignment = NSTextAlignmentCenter;
    self.cjUploadProgressLabel.font = [UIFont systemFontOfSize:15];
    [self cj_makeView:parentView addSubView:self.cjUploadProgressLabel withEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    //    [parentView bringSubviewToFront:self.cjDeleteButton]; //把cjDeleteButton移动最前
}

/** 完整的描述请参见文件头部 */
- (void)updateProgressText:(NSString *)progressText progressVaule:(CGFloat)progressValue {
    self.cjUploadProgressLabel.text = progressText;
    [self updateUploadProgressMaskViewWithProgressVaule:progressValue];
}

///**
// *  根据上传请求的时刻信息来更新视图
// *
// *  @param upload 传请求的时刻信息
// */
//- (void)updateProgressViewByUploadInfo:(CJUploadMomentInfo *)upload {
//    self.cjUploadProgressLabel.text = upload.uploadStatePromptText;
//    [self updateUploadProgressMaskViewWithProgressVaule:upload.progressValue];
//    
//    if (upload.uploadState == CJUploadMomentStateSuccess ||
//        upload.uploadState == CJUploadMomentStateUploading) {
//        self.cjUploadProgressMaskView.userInteractionEnabled = NO;
//    } else {
//        self.cjUploadProgressMaskView.userInteractionEnabled = YES;
//    }
//}

/**
 *  更新上传状态的进度
 *
 *  @param progressValue    该上传状态的进度值[0-100]
 */
- (void)updateUploadProgressMaskViewWithProgressVaule:(CGFloat)progressValue {
    //progressValue等于100不代表成功
    CGFloat remainProgressValue = (100.0-progressValue)/100.0;
    
    UIView *parentView = self;
    
    [parentView removeConstraint:self.cjUploadProgressMaskViewHeightConstraint];
    self.cjUploadProgressMaskViewHeightConstraint =
    [NSLayoutConstraint constraintWithItem:self.cjUploadProgressMaskView
                                 attribute:NSLayoutAttributeHeight   //height
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:parentView
                                 attribute:NSLayoutAttributeHeight
                                multiplier:remainProgressValue
                                  constant:0];
    [parentView addConstraint:self.cjUploadProgressMaskViewHeightConstraint];
    
    [UIView animateWithDuration:0.09f animations:^{
        [self setNeedsLayout];
    }];
}


/** 重新上传 */
- (void)reUpload:(UITapGestureRecognizer *)tapGR {
    self.cjUploadProgressMaskView.hidden = NO;
    self.cjUploadProgressLabel.hidden = NO;
    [self.cjUploadProgressMaskView removeGestureRecognizer:tapGR];
    if (self.cjReUploadHandle) {
        self.cjReUploadHandle(self);
    }
}


#pragma mark - addSubView
- (void)cj_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}


@end
