//
//  UncaughtExceptionHandler.m
//  UncaughtExceptions
//
//  Created by Matt Gallagher on 2010/05/25.
//  Copyright 2010 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "YunUncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>



NSString * const YunUncaughtExceptionHandlerSignalExceptionName = @"YunUncaughtExceptionHandlerSignalExceptionName";
NSString * const YunUncaughtExceptionHandlerSignalKey = @"YunUncaughtExceptionHandlerSignalKey";
NSString * const YunUncaughtExceptionHandlerAddressesKey = @"YunUncaughtExceptionHandlerAddressesKey";

volatile int32_t YunUncaughtExceptionCount = 0;
const int32_t YunUncaughtExceptionMaximum = 10;

const NSInteger YunUncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger YunUncaughtExceptionHandlerReportAddressCount = 5;

@implementation UncaughtExceptionHandler

+ (NSArray *)backtrace
{
	 void* callstack[128];
	 int frames = backtrace(callstack, 128);
	 char **strs = backtrace_symbols(callstack, frames);
	 
	 int i;
	 NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
	 for (
	 	i = YunUncaughtExceptionHandlerSkipAddressCount;
	 	i < YunUncaughtExceptionHandlerSkipAddressCount +
			YunUncaughtExceptionHandlerReportAddressCount;
		i++)
	 {
	 	[backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
	 }
	 free(strs);
	 
	 return backtrace;
}

//*
- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex
{
    
	if (anIndex == 0)
	{
		dismissed = YES;
	}
}
//*/

- (void)validateAndSaveCriticalApplicationData
{
	
}

//错误日志开始发送到服务器
- (void)handleException:(NSException *)exception
{
	[self validateAndSaveCriticalApplicationData];
	//*
    UIAlertView *alert =
        [[UIAlertView alloc]
            initWithTitle:NSLocalizedString(@"Unhandled exception", nil)
            message:[NSString stringWithFormat:NSLocalizedString(
                @"You can try to continue but the application may be unstable.\n\n"
                @"Debug details follow:\n%@\n%@", nil),
                [exception reason],
                [[exception userInfo] objectForKey:YunUncaughtExceptionHandlerAddressesKey]]
            delegate:self
            cancelButtonTitle:NSLocalizedString(@"Quit", nil)
            otherButtonTitles:NSLocalizedString(@"Continue", nil), nil];
    [alert show];
	//*/
    
    NSString *errorStr = [NSString stringWithFormat:NSLocalizedString(
                                                                      @"error info details follow:%@%@", nil),
                          [exception reason],
                          [[exception userInfo] objectForKey:YunUncaughtExceptionHandlerAddressesKey]]
    ;
    
   
    if(errorStr)
    {
        [self sendErrorMsg];
    }
    NSLog(@"error:%@",errorStr);

	CFRunLoopRef runLoop = CFRunLoopGetCurrent();
	CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
	
	while (!dismissed)
	{
		for (NSString *mode in (__bridge  NSArray *)allModes)
		{
			CFRunLoopRunInMode((__bridge CFStringRef)mode, 0.001, false);
		}
	}
	
	CFRelease(allModes);

	NSSetUncaughtExceptionHandler(NULL);
	signal(SIGABRT, SIG_DFL);
	signal(SIGILL, SIG_DFL);
	signal(SIGSEGV, SIG_DFL);
	signal(SIGFPE, SIG_DFL);
	signal(SIGBUS, SIG_DFL);
	signal(SIGPIPE, SIG_DFL);
	
	if ([[exception name] isEqual:YunUncaughtExceptionHandlerSignalExceptionName])
	{
		kill(getpid(), [[[exception userInfo] objectForKey:YunUncaughtExceptionHandlerSignalKey] intValue]);
	}
	else
	{
		[exception raise];
	}
    
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dismissed = YES;
    });
    */
}


-(void)sendErrorMsg
{
    
//    [fetchQueue setGLDelegate:self.gldelegate];
    
}


@end

void HandleException(NSException *exception)
{
	int32_t exceptionCount = OSAtomicIncrement32(&YunUncaughtExceptionCount);
	if (exceptionCount > YunUncaughtExceptionMaximum)
	{
		return;
	}
	
	NSArray *callStack = [UncaughtExceptionHandler backtrace];
	NSMutableDictionary *userInfo =
		[NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
	[userInfo
		setObject:callStack
		forKey:YunUncaughtExceptionHandlerAddressesKey];
	
	[[[UncaughtExceptionHandler alloc] init]
		performSelectorOnMainThread:@selector(handleException:)
		withObject:
			[NSException
				exceptionWithName:[exception name]
				reason:[exception reason]
				userInfo:userInfo]
		waitUntilDone:YES];
}

void SignalHandler(int signal)
{
	int32_t exceptionCount = OSAtomicIncrement32(&YunUncaughtExceptionCount);
	if (exceptionCount > YunUncaughtExceptionMaximum)
	{
		return;
	}
	
	NSMutableDictionary *userInfo =
		[NSMutableDictionary
			dictionaryWithObject:[NSNumber numberWithInt:signal]
			forKey:YunUncaughtExceptionHandlerSignalKey];

	NSArray *callStack = [UncaughtExceptionHandler backtrace];
	[userInfo
		setObject:callStack
		forKey:YunUncaughtExceptionHandlerAddressesKey];
	
	[[[UncaughtExceptionHandler alloc] init]
		performSelectorOnMainThread:@selector(handleException:)
		withObject:
			[NSException
				exceptionWithName:YunUncaughtExceptionHandlerSignalExceptionName
				reason:
					[NSString stringWithFormat:
						NSLocalizedString(@"Signal %d was raised.", nil),
						signal]
				userInfo:
					[NSDictionary
						dictionaryWithObject:[NSNumber numberWithInt:signal]
						forKey:YunUncaughtExceptionHandlerSignalKey]]
		waitUntilDone:YES];
}

//begain
void YunInstallUncaughtExceptionHandler(void)
{
	NSSetUncaughtExceptionHandler(&HandleException);
	signal(SIGABRT, SignalHandler);
	signal(SIGILL, SignalHandler);
	signal(SIGSEGV, SignalHandler);
	signal(SIGFPE, SignalHandler);
	signal(SIGBUS, SignalHandler);
//    signal(SIGPIPE, SignalHandler);
    signal(SIGPIPE, SIG_IGN);
}

