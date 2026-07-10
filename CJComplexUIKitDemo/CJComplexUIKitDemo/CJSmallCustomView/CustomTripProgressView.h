//
//  CustomTripProgressView.h
//  TXLaoXiang
//
//  Created by WolfCub on 15/11/24.
//  Copyright © 2015年 WolfCub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTripProgressView : UIView {
    
    CGRect myFrame;
    
    NSArray *titles;
    
}

@property (nonatomic, strong)NSMutableArray *arrayLabels;
@property (nonatomic, strong)NSMutableArray *arrayRadius;
@property (nonatomic, strong)NSMutableArray *arrayCenters;

-(id)initWithFrame:(CGRect)frame andTitles:(NSArray*)someTitles;

-(void)setSelectIndex:(NSInteger)index;

@end
