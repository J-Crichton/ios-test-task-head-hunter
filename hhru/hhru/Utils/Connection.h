//
//  Connection.h
//

#import <Foundation/Foundation.h>

extern NSString *const kConnectionReachabilityChanged;

@interface Connection : NSObject

+(void)setIsReachable:(BOOL)isReachable;
+(BOOL)isReachable;
+(BOOL)isNotReachable;
+(BOOL)isReachableM;

+(BOOL)isReachabilityReachable;

@end
