//
//  iOSICEServer.m
//  iosrtcua
//
//  Created by Reeonce on 6/7/16.
//

#import "iOSICEServer.h"

static NSString const *kiOSICEServerUsernameKey = @"username";
static NSString const *kiOSICEServerPasswordKey = @"password";
static NSString const *kiOSICEServerUrlKey = @"url";
static NSString const *kiOSICEServerCredentialKey = @"credential";

@implementation iOSICEServer

- (nonnull instancetype)initWithURI:(nonnull NSURL *)URI username:(nullable NSString *)username password:(nullable NSString *)password type:(iOSICEServerType)type {
    self = [super init];
    if (self) {
        _URI = URI;
        _username = username;
        _password = password;
        _type = type;
    }
    return self;
}

+ (nullable instancetype)ICEServerWithDict:(nonnull NSDictionary *)dictionary {
    NSString *urlString = dictionary[kiOSICEServerUrlKey];
    if (!urlString || urlString == (NSString *)[NSNull null]) {
        return nil;
    }
    
    NSArray *components = [urlString componentsSeparatedByString:@":"];
    if (components.count < 2) {
        return nil;
    }
    
    iOSICEServerType serverType = iOSICEUnknownServer;
    NSURL *url = nil;
    NSString *typeString = [components[0] lowercaseString];
    
    
    NSString *host = [urlString componentsSeparatedByString:@"?"].firstObject;
    if ([typeString isEqualToString:@"stun"]) {
        serverType = iOSICESTUNServer;
        url = [NSURL URLWithString:[host substringFromIndex:@"stun:".length]];
    } else if ([typeString isEqualToString:@"turn"]) {
        serverType = iOSICETURNServer;
        url = [NSURL URLWithString:[host substringFromIndex:@"turn:".length]];
    }
    
    if (serverType == iOSICEUnknownServer || !url) {
        return nil;
    }
    
    NSString *username = dictionary[kiOSICEServerUsernameKey];
    if (username == (NSString *)[NSNull null]) {
        username = nil;
    }
    NSString *credential = dictionary[kiOSICEServerCredentialKey];
    if (credential == (NSString *)[NSNull null]) {
        credential = nil;
    }
    return [[iOSICEServer alloc] initWithURI:url username:username password:credential type:serverType];
}

@end
