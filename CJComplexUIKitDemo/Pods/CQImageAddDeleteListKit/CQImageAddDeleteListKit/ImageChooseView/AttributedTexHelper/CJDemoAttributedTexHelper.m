//
//  CJDemoAttributedTexHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoAttributedTexHelper.h"
#import <CJBaseUIKit/UIColor+CJHex.h>
#import <CJBaseHelper/NSObjectCJHelper.h>

@interface CJDemoAttributedTexHelper () {
    
}

@end



@implementation CJDemoAttributedTexHelper

NSAttributedString *cjdemo_attributedText(CGFloat headIndent, NSString * _Nonnull prefixText, NSString *_Nullable suffixText) {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.firstLineHeadIndent = headIndent;
    
    UIFont *prefixTextFont = [UIFont systemFontOfSize:15.0];
    UIColor *prefixTextColor = CJColorFromHexString(@"#333333");
    NSDictionary *prefixAttributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                       NSFontAttributeName:           prefixTextFont,
                                       NSForegroundColorAttributeName:prefixTextColor
                                       };
    NSMutableAttributedString *prefixAttributedText = [[NSMutableAttributedString alloc] initWithString:prefixText attributes:prefixAttributes];
    
    
    
    NSMutableAttributedString *totalAttributedText = [[NSMutableAttributedString alloc] init];
    totalAttributedText = prefixAttributedText;
    
    if (!isEmptyObjectCJHelper(suffixText)) {
        UIFont *suffixTextFont = [UIFont systemFontOfSize:12.0];
        UIColor *suffixTextColor = CJColorFromHexString(@"#FF4500");
        NSDictionary *suffixAttributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                           NSFontAttributeName:           suffixTextFont,
                                           NSForegroundColorAttributeName:suffixTextColor
                                           };
        NSMutableAttributedString *suffixAttributedText = [[NSMutableAttributedString alloc] initWithString:suffixText attributes:suffixAttributes];
        
        [totalAttributedText appendAttributedString:suffixAttributedText];
    }
    
    return totalAttributedText;
}


@end
