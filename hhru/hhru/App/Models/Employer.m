//
//  Employer.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "Employer.h"

@implementation Employer

- (instancetype)initWithEmpoyerId:(NSNumber *)empoyerId logo:(NSString *)logo name:(NSString *)name {
    self = [super init];
    if (self) {
        _empoyerId = empoyerId;
        _logo = logo;
        _name = name;
    }
    return self;
}

+ (Employer *)instanceFromDictionary:(NSDictionary *)aDictionary {
    
    Employer *instance = [[Employer alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
    
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    objectData = aDictionary;
    
    self.empoyerId = [self numberValueForKey:@"id"];
    self.name = [self stringValueForKey:@"name"];

    if ([self isValid:[objectData objectForKey:@"logo_urls"]]) {
        NSDictionary *urls = [objectData objectForKey:@"logo_urls"];
        self.logo = [urls objectForKey:@"240"];
    }
    
    objectData = nil;
}

@end
