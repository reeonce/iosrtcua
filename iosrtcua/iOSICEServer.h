//
//  iOSICEServer.h
//  iosrtcua
//
//  Created by Reeonce on 6/7/16.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, iOSICEServerType) {
    iOSICESTUNServer,
    iOSICETURNServer,
    iOSICEUnknownServer,
};

@interface iOSICEServer : NSObject

@property (nonnull, nonatomic, strong, readonly) NSURL *URI;

@property (nullable, nonatomic, copy, readonly) NSString* username;

@property (nullable, nonatomic, copy, readonly) NSString* password;

@property (nonatomic, assign, readonly) iOSICEServerType type;


// Initializer for RTCICEServer taking uri, username, and password.
- (nonnull id)initWithURI:(nonnull NSURL *)URI
         username:(nullable NSString *)username
         password:(nullable NSString *)password
         type:(iOSICEServerType)type;

- (nullable id)init __attribute__((unavailable("init is not a supported initializer for this class.")));

+ (nullable instancetype)ICEServerWithDict:(nonnull NSDictionary *)dictionary;


@end
