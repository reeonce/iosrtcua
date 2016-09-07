//
//  TCICEServerTests.m
//  iosrtcua
//
//  Created by Reeonce on 6/7/16.
//  Copyright © 2016 turingcat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TCICEServer.h"

@interface TCICEServerTests : XCTestCase

@end

@implementation TCICEServerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    NSError *jsonError;
    NSData *objectData = [@"{\"iceServers\":[{\"url\":\"stun:stun.l.google.com:19302\"},{\"url\":\"turn:192.158.29.39:3478?transport=udp\",\"credential\":\"JZEOEt2V3Qb0y27GRntt2u2PAYA=\",\"username\":\"28224511:1379330808\"},{\"url\":\"turn:192.158.29.39?transport=tcp\",\"credential\":null,\"username\":\"28224511:1379330808\"}]}" dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    NSArray *iceDictArray = json[@"iceServers"];
    
    XCTAssertTrue(iceDictArray && iceDictArray != (NSArray *)[NSNull null]);
    
    NSMutableArray <TCICEServer *>*iceServers = [[NSMutableArray alloc] init];
    for (NSDictionary *iceDict in iceDictArray) {
        [iceServers addObject:[TCICEServer ICEServerWithDict:iceDict]];
    }
    
    XCTAssertTrue(iceServers.count == 3);
    XCTAssertEqualObjects(iceServers[0].URI.absoluteString, @"stun.l.google.com:19302");
    XCTAssertEqual(iceServers[0].type, TCICESTUNServer);
    XCTAssertEqual(iceServers[0].username, nil);
    XCTAssertEqual(iceServers[0].password, nil);
    
    XCTAssertEqualObjects(iceServers[1].URI.absoluteString, @"192.158.29.39:3478");
    XCTAssertEqual(iceServers[1].type, TCICETURNServer);
    XCTAssertEqualObjects(iceServers[1].username, @"28224511:1379330808");
    XCTAssertEqualObjects(iceServers[1].password, @"JZEOEt2V3Qb0y27GRntt2u2PAYA=");
    
    XCTAssertEqualObjects(iceServers[2].URI.absoluteString, @"192.158.29.39");
    XCTAssertEqual(iceServers[2].password, nil);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
