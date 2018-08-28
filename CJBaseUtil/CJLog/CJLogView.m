//
//  CJLogViewWindow.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJLogView.h"
#import "CJLogModel.h"

@interface CJLogView () {
    
}
@property (nonatomic, weak) UITextView *textView;
@property (atomic, strong) NSMutableArray<CJLogModel *> *logs;

@end

@implementation CJLogView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.logs = [NSMutableArray array];
    }
    return self;
}


- (void)setupViews {
    // text view
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.font = [UIFont systemFontOfSize:12.0f];
    textView.backgroundColor = [UIColor clearColor];
    textView.scrollsToTop = NO; //设为NO，避免多个scrollView响应返回顶部的事件，系统就不知道到底要将那个scrollView返回顶部了，导致系统就不做任何操作。
    [self addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.textView = textView;
}

#pragma mark - Print & Clear
/* 完整的描述请参见文件头部 */
- (void)appendObject:(id)appendObject {
    NSString *appendingString = [self formattedStringFromObject:appendObject];
    [self appendString:appendingString];
}

//CJNetwork库中的CJNetworkLogUtil也有用到以下方法
- (NSString *)formattedStringFromObject:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        return object;
        
    } else if ([object isKindOfClass:[NSDictionary class]]) {
//        NSString *indentedString = [self fullFormattedStringFromDictionary:object];
//        return indentedString;
        
        NSString *JSONString = nil;
        if ([NSJSONSerialization isValidJSONObject:object]) {
            NSError *error;
            NSData *JSONData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
            JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        }
        return JSONString;
        
    } else if ([object isKindOfClass:[NSArray class]]) {
//        NSString *indentedString = [CJIndentedStringUtil easyFormattedStringFromArray:object];
//        return indentedString;
        
        NSString *JSONString = nil;
        if ([NSJSONSerialization isValidJSONObject:object]) {
            NSError *error;
            NSData *JSONData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
            JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        }
        return JSONString;
        
    } else {
        return nil;
    }
}


/**
 *  将appendingData追加写入视图
 *
 *  @param appendingString  要追加写入视图的字符串
 */
- (void)appendString:(NSString *)appendingString {
    if (appendingString.length == 0) {
        return;
    }
    
    @synchronized (self) {
        appendingString = [NSString stringWithFormat:@"%@\n", appendingString]; // add new line
        CJLogModel *logModel = [CJLogModel logWithString:appendingString];
        if (!logModel) {
            return;
        }
        
        [self.logs addObject:logModel];
        if (self.logs.count > 20) { //最多显示20条数据
            [self.logs removeObjectAtIndex:0];
        }
        
        // view
        [self refreshLogDisplay];
    }
}

/* 完整的描述请参见文件头部 */
- (void)clear {
    self.textView.text = @"";
    self.logs = [NSMutableArray array];
}

#pragma mark - Display
- (void)refreshLogDisplay {
    // attributed text
    NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
    
    double currentTimestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger count = self.logs.count;
    for (NSInteger i = 0; i < count; i++) {
        CJLogModel *logModel = [self.logs objectAtIndex:i];
        NSString *logString = logModel.logString;
        if (logString.length == 0) {
            return;
        }
        
        NSMutableAttributedString *currentLogAttributedString = [[NSMutableAttributedString alloc] initWithString:logString];
        
        //BOOL shouldHighlighted = i==count-1;
        BOOL shouldHighlighted = currentTimestamp - logModel.timestamp <= 0.1;
        UIColor *logColor = !shouldHighlighted ? [UIColor whiteColor] : [UIColor yellowColor]; // yellow if new, white if more than 0.1 second ago
        [currentLogAttributedString addAttribute:NSForegroundColorAttributeName value:logColor range:NSMakeRange(0, currentLogAttributedString.length)];
        
        [attributedString appendAttributedString:currentLogAttributedString];
    }
    
    self.textView.attributedText = attributedString;
    
    // scroll to bottom
    if(attributedString.length > 0) {
        NSRange bottom = NSMakeRange(attributedString.length - 1, 1);
        [self.textView scrollRangeToVisible:bottom];
    }
}

/*
TODO:
textview尾部追加文本
有两种实现方式，均可。

第一种：

NSRange range;
range = NSMakeRange ([[textView string] length], 0);

[textView replaceCharactersInRange: range withString: string];

或者第二种：

[[[textView textStorage] mutableString] appendString: string];
*/

@end
