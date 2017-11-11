//
//  IjinbuNetworkClient+LoginViewController.m
//  CommonAFNUtilDemo
//
//  Created by dvlproad on 2017/3/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "IjinbuNetworkClient+Login.h"
#import "NSString+MD5.h"

@implementation IjinbuNetworkClient (LoginViewController)

- (NSURLSessionDataTask *)requestijinbuLogin_name:(NSString *)name
                                             pasd:(NSString*)pasd
                                          success:(HPSuccess)success
                                          failure:(HPFailure)failure
{
    NSString *Url = @"ijinbu/app/teacherLogin/login";
    NSDictionary *params = @{@"userAccount":name, //测试:name:18020721201 pasd:123456
                             @"userPwd":    [pasd MD5],
                             @"loginType":  @(0)
                             };
    
    return [self postWithRelativeUrl:Url params:params success:^(IjinbuResponseModel *responseModel) {
        NSLog(@"ijinbu_login_responseModel = %@", responseModel);
        IjinbuUser *user = [MTLJSONAdapter modelOfClass:[IjinbuUser class] fromJSONDictionary:responseModel.result error:nil];
        IjinbuSession *session = [IjinbuSession current];
        session.user = user;
        
        
        if (success) {
            success(responseModel);
        }
    } failure:failure];
}

@end
