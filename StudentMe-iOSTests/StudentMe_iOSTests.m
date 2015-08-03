//
//  StudentMe_iOSTests.m
//  StudentMe-iOSTests
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSURL+SMURL.h"
#import "TestMock.h"
#import "SMTopicListFilter.h"

#import "SMHttpDataManager.h"


@interface StudentMe_iOSTests : XCTestCase

@end

@implementation StudentMe_iOSTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testUrlTools {
    NSString *login = [NSURL smLoginString];
    NSLog(@"user login url is %@", login);
}

- (void)testLogin {
    XCTestExpectation *expectation = [self expectationWithDescription:@"test login async handle"];
    [[[SMHttpDataManager sharedManager] LoginWithUsername:Seanchense password:Password] subscribeNext:^(id x) {
        NSLog(@"succ is %@", x);
    } error:^(NSError *error) {
        NSLog(@"err is %@", error);
    } completed:^{
        NSLog(@"completed");
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"testLogin fail err is %@", error);
        }
    }];
}

- (void)testForumlist {
    XCTestExpectation *expectation = [self expectationWithDescription:@"test testForumlist async handle"];
    [[[SMHttpDataManager sharedManager] forumlistWithFid:nil optionalType:nil] subscribeNext:^(id x) {
        NSLog(@"succ is %@", x);
    } error:^(NSError *error) {
        NSLog(@"err is %@", error);
    } completed:^{
        NSLog(@"completed");
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"testForumlist fail err is %@", error);
        }
    }];
}

- (void)testTopicList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"test testTopicList async handle"];
    SMTopicListFilter *filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterDeals];
    [[[SMHttpDataManager sharedManager] forumTopiclistWithFilter:filter] subscribeNext:^(id x) {
        NSLog(@"succ is %@", x);
    } error:^(NSError *error) {
        NSLog(@"err is %@", error);
    } completed:^{
        NSLog(@"completed");
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"testTopicList fail err is %@", error);
        }
    }];
}

@end
