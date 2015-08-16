//
//  SMUser.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/5.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMUser.h"
#import "NSUserDefaults+SMUserDefaults.h"

@implementation SMUser

- (instancetype)initWithHttpResponseData:(id)data {
    self = [self init];
    if (self) {
        NSDictionary *dic = (NSDictionary *)data;
        _userName   = dic[@"userName"];
        _uid        = dic[@"uid"];
        _secret     = dic[@"secret"];
        _token      = dic[@"token"];
        _avatar     = dic[@"avatar"];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.secret forKey:@"secret"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.secret = [decoder decodeObjectForKey:@"secret"];
        self.token = [decoder decodeObjectForKey:@"token"];
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
    }
    return self;
}

- (void)saveToUserDefault {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:[NSUserDefaults smkeyUserSecretInfo]];
}

+ (SMUser *)userFromUserDefault {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSUserDefaults smkeyUserSecretInfo]];
    SMUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}
@end
