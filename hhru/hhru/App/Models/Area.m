//
//  Area.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "Area.h"

@implementation Area

- (instancetype)initWithAreaId:(NSNumber *)areaId name:(NSString *)name
{
    self = [super init];
    if (self) {
        _areaId = areaId;
        _name = name;
    }
    return self;
}

+ (Area *)instanceFromDictionary:(NSDictionary *)aDictionary {
    
    Area *instance = [[Area alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
    
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    objectData = aDictionary;
    
    self.areaId = [self numberValueForKey:@"id"];
    self.name = [self stringValueForKey:@"name"];
    
    objectData = nil;
}

@end
