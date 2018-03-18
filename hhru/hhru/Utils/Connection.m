//
//  Connection.m
//

#import "UIView+ConcisePureLayout.h"
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
    if(!b) [SVProgressHUD showImage:[UIImage imageNamed:@"no_connection.png"] status:NSLocalizedString(@"No Internet connection", nil)];
    return b;
}

+(BOOL)isReachabilityReachable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    return internetStatus != NotReachable;
}

@end
