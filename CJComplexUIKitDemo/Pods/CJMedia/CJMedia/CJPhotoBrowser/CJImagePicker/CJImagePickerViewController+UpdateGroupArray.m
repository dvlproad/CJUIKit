//
//  CJImagePickerViewController+UpdateGroupArray.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJImagePickerViewController+UpdateGroupArray.h"

@implementation CJImagePickerViewController (UpdateGroupArray)

- (void)obtainGroupArray:(NSNotification *)notification
{
    
    self.assetsGroup = notification.object;
    [self obtainData];
}

- (void)obtainData
{
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    else
        [self.assets removeAllObjects];
    
    [self.sectionDataModels removeAllObjects];
    AlumbSectionDataModel *sectionDataModel = [[AlumbSectionDataModel alloc] init];
    [self.sectionDataModels addObject:sectionDataModel];
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
        if (asset)
        {
            [self.assets addObject:asset];
            if ([[asset valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto]) {
                
                NSString *url=[NSString stringWithFormat:@"%@",asset.defaultRepresentation.url];//图片的url
                AlumbImageModel * item = [[AlumbImageModel alloc] init];
                item.url = url;
                item.type = 1;
                [((AlumbSectionDataModel *)self.sectionDataModels[0]).values insertObject:item atIndex:0];
            }
            
        }
        else if (self.assets.count > 0)
        {
            [self hcRefreshViewDidDataUpdated];
        }
    };
    
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}

@end
