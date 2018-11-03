//
//  AttributedStringViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzne on 2017/7/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AttributedStringViewController.h"
#import "UIColor+CJHex.h"

@interface AttributedStringViewController ()

@end

@implementation AttributedStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *string = @"NSParagraphStyleAttributeName 段落的风格";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    /*
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
    paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    paragraphStyle.headIndent = 20;//整体缩进(首行除外)
    paragraphStyle.tailIndent = 20;//
    paragraphStyle.minimumLineHeight = 10;//最低行高
    paragraphStyle.maximumLineHeight = 20;//最大行高
    paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
    paragraphStyle.paragraphSpacingBefore = 22.0f;//段首行空白空间 //Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph.
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;//从左到右的书写方向（一共➡️三种）
    paragraphStyle.lineHeightMultiple = 15; //Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height.
    paragraphStyle.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1
    */
    
    NSDictionary *attributes = @{NSFontAttributeName:           font,
                                 NSForegroundColorAttributeName:[UIColor whiteColor],
                                 NSBackgroundColorAttributeName:[UIColor cjColorWithHexString:@"fe5000"],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    NSRange range = [string rangeOfString:@"NSParagraphStyleAttributeName"];
    [attributedString addAttributes:attributes range:range];
    
    self.textView1.attributedText = attributedString;
    
    [self setBorderForYYLabel];
}

- (IBAction)buttonAction:(id)sender {
    [self setBorderForYYLabel];
}

- (void)setBorderForYYLabel {
    
    NSMutableAttributedString *allAttributedString = [NSMutableAttributedString new];
    
    {
        NSString *string = @"名牌服饰：1000元\n0.8折";
        NSRange normalRange = [string rangeOfString:@"名牌服饰：1000元"];
        NSRange redRange = [string rangeOfString:@"0.8折"];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString yy_setFont:[UIFont boldSystemFontOfSize:18] range:normalRange];
        [attributedString yy_setColor:[UIColor lightGrayColor] range:normalRange];
        [attributedString yy_setFont:[UIFont boldSystemFontOfSize:12] range:redRange];
        [attributedString yy_setColor:[UIColor redColor] range:redRange];
        
        YYTextBorder *redBorder = [YYTextBorder new];
        redBorder.fillColor = [UIColor greenColor];
        
        redBorder.cornerRadius = 30;
        redBorder.strokeWidth = 5;
        redBorder.strokeColor = [UIColor yellowColor];
        
        redBorder.insets = UIEdgeInsetsMake(0, -10, 0, -10);
        redBorder.lineStyle = YYTextLineStyleSingle;
        [attributedString yy_setTextBackgroundBorder:redBorder range:redRange]; //正确
        //[attributedString yy_setTextBorder:redBorder range:redRange]; //错误
        
        YYTextBorder *highlightBorder = redBorder.copy;
        highlightBorder.strokeWidth = 0;
        highlightBorder.strokeColor = attributedString.yy_color;
        highlightBorder.fillColor = attributedString.yy_color;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor whiteColor]];
        [highlight setBackgroundBorder:highlightBorder];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        };
        //[one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
        [attributedString yy_setTextHighlight:highlight range:redRange];
        
        [allAttributedString appendAttributedString:attributedString];
        //[allAttributedString appendAttributedString:[self padding]];
    }
    
    self.textView2.attributedText = allAttributedString;
    
    self.sytemLabel.attributedText = allAttributedString;
    
#pragma mark - 注意:对于YYLabel的textAlignment的设置必须在attributedText之后，否则无效，即否则会变成默认的NSTextAlignmentLeft
    //self.yyLabel.textAlignment = NSTextAlignmentCenter;  //错误，写在attributedText设置之前是无效的
    self.yyLabel.attributedText = allAttributedString;
    self.yyLabel.textAlignment = NSTextAlignmentCenter;  //注意:对于YYLabel的textAlignment的设置必须在attributedText之后，否则无效，即否则会变成默认的NSTextAlignmentLeft
    self.yyLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    self.yyLabel.numberOfLines = 0;
}



- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.yy_font = [UIFont systemFontOfSize:4];
    return pad;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
