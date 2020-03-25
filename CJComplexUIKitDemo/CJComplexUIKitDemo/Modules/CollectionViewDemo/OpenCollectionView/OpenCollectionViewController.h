//
//  OpenCollectionViewController.h
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSOpenCollectionView.h"

@interface OpenCollectionViewController : UIViewController {
    
}

@property (nonatomic, strong) TSOpenCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;

@end
