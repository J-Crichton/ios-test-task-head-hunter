//
//  NSNumberFormatter+Ext.m
//  BAF
//

#import "NSNumberFormatter+Ext.h"

@implementation NSNumberFormatter (Ext)

+ (NSNumberFormatter *)enUS {
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return nf;
}

@end
