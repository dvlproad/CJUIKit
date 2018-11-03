//
//  CvDemo_Complex.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CvDemo_Complex : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>{
    NSMutableArray *lists;
}
@property(nonatomic, strong) IBOutlet UICollectionView *cv;

@end
