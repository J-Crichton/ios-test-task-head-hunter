//
//  Connection.h
//  AstanaKzPublicControl
//
//  Created by Narikbi on 6/4/13.
//  Copyright (c) 2013 Astana.kz. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "EmptyContentView.h"

extern NSString *const kConnectionReachabilityChanged;

@interface Connection : NSObject

+(void)setIsReachable:(BOOL)isReachable;
+(BOOL)isReachable;
+(BOOL)isNotReachable;
+(BOOL)isReachableM;

+(BOOL)isReachabilityReachable;

@end
