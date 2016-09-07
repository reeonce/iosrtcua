//
//  iOSRTCManager.h
//  iosrtcua
//
//  Created by Reeonce on 5/25/16.
//

#import <Foundation/Foundation.h>

@protocol iOSRTCManagerDelegate <NSObject>

- (void)managerCreateComplete;
- (void)managerCreateFailed;
- (void)managerNegotiateComplete;
- (void)managerNegotiateFailed;

@end

@interface iOSRTCManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic) id<iOSRTCManagerDelegate> delegate;

- (void)setupWithStunServer:(NSString *)stunServer turnServer:(NSString *)turnServer turnUserName:(NSString *)userName turnPassword:(NSString *)password;

- (NSString *)getLocalSDP;

- (void)inputRemoteSDP:(NSString *)remoteSDP;

- (NSString *)parseCameraSDP:(NSString *)cameraSDP;

- (void)negotiate;

- (void)stop;

@end
