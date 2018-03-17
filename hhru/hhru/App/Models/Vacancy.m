//
//  Vacancy.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "Vacancy.h"

@implementation Vacancy

+ (Vacancy *)instanceFromDictionary:(NSDictionary *)aDictionary {
    
    Vacancy *instance = [[Vacancy alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
    
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    objectData = aDictionary;
    
    self.name = [self stringValueForKey:@"name"];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    self.publishedAt = [formatter dateFromString:[self stringValueForKey:@"published_at"]];
    
    if ([self isValid:[objectData objectForKey:@"salary"]]) {
        NSDictionary *salary = [objectData objectForKey:@"salary"];
        self.salary = [Salary instanceFromDictionary:salary];
    }

    if ([self isValid:[objectData objectForKey:@"area"]]) {
        NSDictionary *area = [objectData objectForKey:@"area"];
        self.area = [Area instanceFromDictionary:area];
    }

    if ([self isValid:[objectData objectForKey:@"employer"]]) {
        NSDictionary *employer = [objectData objectForKey:@"employer"];
        self.employer = [Employer instanceFromDictionary:employer];
    }
    
    objectData = nil;
}



- (NSString *)formattedSalaryArea {
    
    NSString *str = @"";
    
    if (self.salary != nil) {
        str = [str stringByAppendingString:[self.salary formattedRange]];
    }
    
    if (self.area) {
        if (str.length) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"・%@", self.area.name]];
        } else {
            str = [str stringByAppendingString:self.area.name];
        }
    }
    
    return str;
}


@end














