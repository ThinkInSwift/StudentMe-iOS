//
//  SMHttpDataManager.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMHttpDataManager.h"

@implementation SMHttpDataManager
- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPRequestOperationManager alloc] init];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    
    return self;
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
        [self.manager POST:[NSURL smLoginString] parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFormData:[self dictToJsonData:data] name:@""];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
        [self.manager POST:[NSURL smForumlistString] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFormData:[self dictToJsonData:data] name:@""];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
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
