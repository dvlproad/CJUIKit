//
//  NSError+CQTSErrorString.m
//  CQDemoKit
//
//  Created by qian on 2025/2/5.
//

#import "NSError+CQTSErrorString.h"

@implementation NSError (CQTSErrorString)

- (NSString *)cqtsErrorString {
    NSInteger code = self.code;
    NSString *domain = self.domain;
    NSString *description = self.localizedDescription;
    
    return [NSString stringWithFormat:@"Error Code: %ld, Domain: %@, Description: %@", (long)code, domain, description];
}

@end
