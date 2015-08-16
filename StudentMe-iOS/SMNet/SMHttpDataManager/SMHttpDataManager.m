//
//  SMHttpDataManager.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMHttpDataManager.h"
#import "SMValidation.h"


@implementation SMHttpDataManager
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureSessionManager];
    }
    
    return self;
}

- (void)configureSessionManager {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html"]];
    
}


+ (instancetype)sharedManager {
    static SMHttpDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SMHttpDataManager alloc] init];
    });
    return sharedManager;
}

- (RACSignal *)LoginWithUsername:(NSString *)username password:(NSString *)password {
    
    NSDictionary *data = @{@"type":@"login",
                           @"username":username,
                           @"password":password,
                           @"code":@"",
                           @"isValidation":@"1",
                           @"mobile":@""};
    
    
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.manager POST:[NSURL smLoginString] parameters:data
                   success:^(NSURLSessionDataTask *task, id responseObject) {
                       if ([SMValidation isFailLoginWithResp:responseObject]) {
                           [subscriber sendError:[SMErr errWithErrCode:SMRespErrCodeLoginPwdNotRight]];
                       } else {
                           self.user = [[SMUser alloc] initWithHttpResponseData:responseObject];
                           [self.user saveToUserDefault];
                           [subscriber sendNext:responseObject];
                           [subscriber sendCompleted];
                       }
                       
        }
                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                       [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            //
        }];
    }] replayLazily];
}

#pragma mark - post methods

- (RACSignal *)forumlistWithFid:(NSString *)fid optionalType:(NSString *)type {
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
    fid, @"fid",
    type, @"type", nil];
    
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.manager POST:[NSURL smForumlistString] parameters:nil
                   success:^(NSURLSessionDataTask *task, id responseObject) {
                       [subscriber sendNext:responseObject];
                       [subscriber sendCompleted];
        }
                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                       [subscriber sendError:error];
                   }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }] replayLazily];
    
    
    
}


- (RACSignal *)forumTopiclistWithFilter:(SMTopicListFilter *)filter {
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.manager POST:[NSURL smForumTopiclistString]
                parameters:[self configureTokenAndSecretWithDic:[filter convertObjectToDict:filter]]
                   success:^(NSURLSessionDataTask *task, id responseObject) {
                       if ([SMValidation isNeedLoginWithResp:responseObject]) {
                           NSError *err = [[NSError alloc] initWithDomain:@"forumTopiclistWithFilter"
                                                                     code:SMRespErrCodeNeedLogin
                                                                 userInfo:@{
                                                                            @"info":[SMErr errMessage:SMRespErrCodeNeedLogin]
                                                                           }];
                           [subscriber sendError:err];
                       } else {
                           [subscriber sendNext:responseObject[@"list"]];
                           [subscriber sendCompleted];
                       }
                       
        }
                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                       [subscriber sendError:error];
                   }];
        
        return [RACDisposable disposableWithBlock:^{
            //
        }];
    }] replayLazily];
}


#pragma mark - private methods

//dict to jsonData
- (NSData *)dictToJsonData:(NSDictionary *)dict {
    NSError* err;
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    return data;
}

//加入 secret 和 token

- (NSDictionary *)configureTokenAndSecretWithDic:(NSDictionary *)dict {
    NSMutableDictionary *mutableDic = [dict mutableCopy];
    if (!self.user || !self.user.token) {
        self.user = [SMUser userFromUserDefault];
    }
    if (self.user.token || self.user.secret) {
        [mutableDic setObject:self.user.token forKey:@"accessToken"];
        [mutableDic setObject:self.user.secret forKey:@"accessSecret"];
    }
    
    
    return [mutableDic copy];
}

//生成 request
- (NSMutableURLRequest *)getRequest:(NSString*)method body:(NSData *)data strUrl:(NSString *)strUrl{
    
    NSURL *url = [NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    return request;
    
}



@end
