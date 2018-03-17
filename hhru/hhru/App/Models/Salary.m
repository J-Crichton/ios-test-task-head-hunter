//
//  Salary.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "Salary.h"

@implementation Salary

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

@end
