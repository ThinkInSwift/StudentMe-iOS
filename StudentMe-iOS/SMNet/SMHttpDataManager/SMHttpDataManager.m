//
//  SMHttpDataManager.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMHttpDataManager.h"
#import "SMValidation.h"

#import <CommonCrypto/CommonDigest.h>


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
                parameters:[self configureTokenAndSecretWithDic:[filter convertObjectToDict]]
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

- (RACSignal *)forumPostlistWithTopicId:(NSString *)topicId page:(NSString *)page {
    NSDictionary *dict = [self configureTokenAndSecretWithDic:@{@"topicId" : topicId,
                                                                @"page" : page,
                                                                @"authorId" : @"0",//只看该作者
                                                                @"order" : @"0",//排列顺序
                                                                @"pageSize" : @"20"}];
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.manager POST:[NSURL smForumPostlistString] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"forumPostlistWithTopicId succ response is %@", responseObject);
            if ([SMValidation isNeedLoginWithResp:responseObject]) {
                NSError *err = [[NSError alloc] initWithDomain:@"forumTopiclistWithFilter"
                                                          code:SMRespErrCodeNeedLogin
                                                      userInfo:@{
                                                                 @"info":[SMErr errMessage:SMRespErrCodeNeedLogin]
                                                                 }];
                [subscriber sendError:err];
            } else {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        
        
        return [RACDisposable disposableWithBlock:^{
            //
        }];
    }];
}

- (RACSignal *)forumTopicAdminWithFilter:(SMTopicCreateFilter *)filter {
    NSDictionary *dict = [self configureBaseParamsWithDict:[filter dict]];
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.manager POST:[NSURL smForumTopicAdminString] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"forumTopicAdminWithFilter succ response is %@", responseObject);
            if ([SMValidation isNeedLoginWithResp:responseObject]) {
                NSError *err = [[NSError alloc] initWithDomain:@"forumTopiclistWithFilter"
                                                          code:SMRespErrCodeNeedLogin
                                                      userInfo:@{
                                                                 @"info":[SMErr errMessage:SMRespErrCodeNeedLogin]
                                                                 }];
                [subscriber sendError:err];
            } else {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            //
        }];
    }];
}

#pragma mark - private methods

//dict to jsonData
- (NSData *)dictToJsonData:(NSDictionary *)dict {
    NSError* err;
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    return data;
}

- (NSDictionary *)configureBaseParamsWithDict:(NSDictionary *)dict {
    NSMutableDictionary *mutableDict = [dict mutableCopy];
    [mutableDict setObject:[self appHash] forKey:@"apphash"];
    return [self configureTokenAndSecretWithDic: [mutableDict copy]];
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

- (NSString *)appHash {
    static NSString *authKey = @"appbyme_key";
    double time = [[NSDate date] timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%f", time/1000.0];
    NSString *timeStrSub = [timeStr substringWithRange:NSMakeRange(0, 5)];
    NSString *timeWithAuth = [timeStrSub stringByAppendingString:authKey];
    NSString *md5Str = [self md5:timeWithAuth];
    NSString *hash = [md5Str substringWithRange:NSMakeRange(8, 8)];
    return hash;
}


- (NSString *)md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
