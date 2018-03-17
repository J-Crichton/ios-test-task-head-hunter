//
//  Connection.m
//  AstanaKzPublicControl
//
//  Created by Narikbi on 6/4/13.
//  Copyright (c) 2013 Astana.kz. All rights reserved.
//

#import "UIView+ConcisePureLayout.h"
#import <ChameleonFramework/UIColor+Chameleon.h>
#import "Reachability.h"
#import "Connection.h"
#import "SVProgressHUD.h"

NSString *const kConnectionReachabilityChanged = @"connectionReachabilityChanged";

static BOOL _isReachable;

@implementation Connection

+(void)setIsReachable:(BOOL)isReachable {
    _isReachable = isReachable;
}

+(BOOL)isReachable {
    return [self isReachabilityReachable];
}

+(BOOL)isNotReachable {
    return ![self isReachabilityReachable];
}

+(BOOL)isReachableM {
    BOOL b = [self isReachable];
//    if(!b) [UIHelper showMessage:NSLocalizedString(@"Нет соединения с интернетом", nil)];
    if(!b) [SVProgressHUD showImage:[UIImage imageNamed:@"no_connection.png"] status:NSLocalizedString(@"No Internet connection", nil)];
    return b;
}

+(BOOL)isReachabilityReachable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    return internetStatus != NotReachable;
}

@end
