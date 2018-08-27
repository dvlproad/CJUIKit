//
//  CJLogWindow.m
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

static CJLogView __strong *_sharedInstance = nil;

+ (CJLogView *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (void)cleanUp {
    _sharedInstance = nil;
}

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
- (void)cj_appendObject:(id)appendObject toLogWindowName:(NSString *)logWindowName {
    NSString *appendingString = [self formattedStringFromObject:appendObject];
    
    dispatch_async(dispatch_get_main_queue(),^{
        [self cj_appendString:appendingString toLogWindowName:logWindowName];
    });
    
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
 *  将appendingData追加写入指定文件末尾(log文件统一存放在NSDocumentDirectory下的CJLog文件夹中)
 *
 *  @param appendingString  要追加写入的字符串
 *  @param logWindowName    追加的内容要写入的指定log窗口的标志名
 */
- (void)cj_appendString:(NSString *)appendingString toLogWindowName:(NSString *)logWindowName
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *documentPath = [paths objectAtIndex:0];
//
//    NSString *cjLogDirectoryPath = [documentPath stringByAppendingPathComponent:@"CJLog"];
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:cjLogDirectoryPath]) {//如果不存在，则建立这个文件夹
//        [fileManager createDirectoryAtPath:cjLogDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//
//    NSString *logFilePath = [cjLogDirectoryPath stringByAppendingPathComponent:logFileName];
//    if(![fileManager fileExistsAtPath:logFilePath]) {//如果不存在，则建立这个文件夹
//        [fileManager createFileAtPath:logFilePath contents:nil attributes:nil];
//    }
//
//    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
//    if(fileHandle == nil)
//    {
//        NSLog(@"Error: Open of file for writing failed");
//    }
//
//    //找到并定位到outFile的末尾位置(在此后追加文件)
//    [fileHandle seekToEndOfFile];
//
//    //读取inFile并且将其内容写到outFile中
//    NSMutableData *mutableData = [[NSMutableData alloc] init];
//
//    NSString *separateString = @"\n----------------------------------\n";
//    NSData *separateData = [separateString dataUsingEncoding:NSUTF8StringEncoding];
//    [mutableData appendData:separateData];
//
//    [mutableData appendData:appendingData];
//
//    [fileHandle writeData:mutableData];
//
//    //关闭读写文件
//    [fileHandle closeFile];

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


//+ (void)clear {
//    dispatch_async(dispatch_get_main_queue(),^{
//        [[self sharedInstance] clear];
//    });
//}

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
