//
//  iOSRTCManagerTests.m
//  iosrtcua
//
//  Created by Reeonce on 6/2/16.
//  Copyright © 2016 turingcat. All rights reserved.
//

#import <XCTest/XCTest.h>
//#import <Foundation/Foundation.h>
#import "iosrtcua/iOSRTCManager.h"

@interface iOSRTCManagerTests : XCTestCase

@end

@implementation iOSRTCManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParseCameraSDP {
    NSString *const cameraSDP = @"v=0\r\no=- 1464884363881669 1464884363881669 IN IP6 ::\r\ns=Media Presentation\r\ne=NONE\r\nb=AS:5100\r\nt=0 0\r\na=control:rtsp:\/\/172.16.46.182:554\/Streaming\/Channels\/102\/?transportmode=unicast&profile=Profile_2\r\nm=video 0 RTP\/AVP 96\r\nc=IN IP6 ::\r\nb=AS:5000\r\na=recvonly\r\na=control:rtsp:\/\/172.16.46.182:554\/Streaming\/Channels\/102\/trackID=1?transportmode=unicast&profile=Profile_2\r\na=rtpmap:96 H264\/90000\r\na=fmtp:96 profile-level-id=420029; packetization-mode=1; sprop-parameter-sets=Z00AFJWoWCWhAAAHCAABX5AE,aO48gA==\r\nm=audio 0 RTP\/AVP 0\r\nc=IN IP6 ::\r\nb=AS:50\r\na=recvonly\r\na=control:rtsp:\/\/172.16.46.182:554\/Streaming\/Channels\/102\/trackID=2?transportmode=unicast&profile=Profile_2\r\na=rtpmap:0 PCMU\/8000\r\na=Media_header:MEDIAINFO=494D4B48010100000400010010710110401F000000FA000000000000000000000000000000000000;\r\na=appversion:1.0\r\n";
    
    NSString *const turnServer = @"112.74.128.218";
    [iOSRTCManager.sharedManager setupWithStunServer:turnServer turnServer:turnServer turnUserName:nil turnPassword:nil];
    
    NSString *updatedCameraSDP = [iOSRTCManager.sharedManager parseCameraSDP:cameraSDP];
    
    XCTAssertNotEqual([updatedCameraSDP rangeOfString:@"m=audio 7971"].location, NSNotFound);
    XCTAssertNotEqual([updatedCameraSDP rangeOfString:@"m=video 7973"].location, NSNotFound);
}

@end
