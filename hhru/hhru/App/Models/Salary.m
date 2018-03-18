//
//  Salary.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "Salary.h"

@implementation Salary

- (instancetype)initWithFrom:(NSNumber *)from to:(NSNumber *)to gross:(BOOL)gross currency:(NSString *)currency {
    self = [super init];
    if (self) {
        _from = from;
        _to = to;
        _gross = gross;
        _currency = currency;
    }
    return self;
}


+ (Salary *)instanceFromDictionary:(NSDictionary *)aDictionary {
    
    Salary *instance = [[Salary alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
    
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    objectData = aDictionary;
    
    self.from     = [self numberValueForKey:@"from"];
    self.to       = [self numberValueForKey:@"to"];
    self.gross    = [self boolValueForKey:@"gross"];
    self.currency = [self stringValueForKey:@"currency"];
    
    objectData = nil;
}

- (NSString *)formattedRange {
    
    NSString *str = @"";
    if (self.from.integerValue > 0) {
        if (self.to.integerValue == 0) {
            str = [str stringByAppendingString:@"от "];
        }
        str = [str stringByAppendingString:self.from.stringValue];
    }
    
    if (self.to.integerValue > 0) {
        if (self.from.integerValue > 0) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@" - %@", self.to.stringValue]];
        } else {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"до %@", self.to.stringValue]];
        }
    }
    
    str = [str stringByAppendingString:@" "];
    str = [str stringByAppendingString:[self currencySymbol]];
//    str = [str stringByAppendingString:@" "];

    return str;
}

- (NSString *)currencySymbol {
    
    NSString *symbol = @"₽";
    
    if ([self.currency isEqualToString:@"AZN"]) {
        symbol = @"₼";
    } else if ([self.currency isEqualToString:@"BYR"]) {
        symbol = @"Br";
    } else if ([self.currency isEqualToString:@"EUR"]) {
        symbol = @"€";
    } else if ([self.currency isEqualToString:@"GEL"]) {
        symbol = @"ლ";
    } else if ([self.currency isEqualToString:@"KGS"]) {
        symbol = @"с";
    } else if ([self.currency isEqualToString:@"KZT"]) {
        symbol = @"₸";
    } else if ([self.currency isEqualToString:@"USD"]) {
        symbol = @"$";
    }
    
    return symbol;
}


@end
