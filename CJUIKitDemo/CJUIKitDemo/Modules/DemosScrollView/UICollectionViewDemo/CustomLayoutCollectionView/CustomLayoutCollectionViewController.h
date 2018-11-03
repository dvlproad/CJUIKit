//
//  CustomLayoutCollectionViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/4/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLayoutCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    BOOL isSelected;
}
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
