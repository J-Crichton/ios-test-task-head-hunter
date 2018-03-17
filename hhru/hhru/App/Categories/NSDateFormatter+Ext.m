//
//  NSDateFormatter+Ext.m
//  BAF
//

#import "NSDateFormatter+Ext.h"

@implementation NSDateFormatter (Ext)

+ (NSDateFormatter *)sharedDateFormatter {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return df;
}

@end
