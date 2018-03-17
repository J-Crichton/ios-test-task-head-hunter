//
//  ModelObject.m
//  Myth
//
//  Created by Narikbi on 11/13/12.
//
//

#import "ModelObject.h"

@implementation ModelObject

-(id)idValueForKey:(NSString *)key {
    return [self idValueFrom:objectData forKey:key];
}

-(NSString *)stringValueForKey:(NSString *)key {
    return [self stringValueFrom:objectData forKey:key];
}

-(NSNumber *)numberValueForKey:(NSString *)key {
    return [self numberValueFrom:objectData forKey:key];
}

-(NSDate *)dateValueForKey:(NSString *)key dateFormat:(NSString *)dateFormat {
    return [self dateValueFrom:objectData forKey:key dateFormat:dateFormat];
}

-(NSInteger)integerValueForKey:(NSString *)key {
    return [self integerValueFrom:objectData forKey:key];
}

-(float)floatValueForKey:(NSString *)key {
    return [self floatValueFrom:objectData forKey:key];
}

-(BOOL)boolValueForKey:(NSString *)key {
    return [self boolValueFrom:objectData forKey:key];
}

-(NSArray *)arrayValueForKey:(NSString *)key {
    return [self arrayValueFrom:objectData forKey:key];
}

- (id)dictionaryValueForKey:(NSString *)key {
    id object = objectData[key];
    return object && [object isKindOfClass:[NSDictionary class]] ? object : nil;
}


#pragma mark -

-(id)idValueFrom:(id)object forKey:(NSString *)key {
    id value = [object objectForKey:key];
    return [self isValid:value]?value:@"";
}

-(NSString *)stringValueFrom:(id)object forKey:(NSString *)key {
    id value = [object objectForKey:key];
    return [self isValid:value]?[NSString stringWithFormat:@"%@", value]:@"";
}

-(NSNumber *)numberValueFrom:(id)object forKey:(NSString *)key {
    id value = [object objectForKey:key];
    return [self isValid:value] ? @([value doubleValue]) : @0;
}

-(NSDate *)dateValueFrom:(id)object forKey:(NSString *)key dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:dateFormat];
    NSDate *date = [df dateFromString:[object objectForKey:key]];
    return date;
}

-(NSInteger)integerValueFrom:(id)object forKey:(NSString *)key {
    id value = [object objectForKey:key];
    return [self isValid:value]?[value integerValue]:0;
}

-(float)floatValueFrom:(id)object forKey:(NSString *)key {
    id value = [object objectForKey:key];
    return [self isValid:value]?[value floatValue]:0;
}

-(BOOL)boolValueFrom:(id)object forKey:(NSString *)key {
    id value = [object objectForKey:key];
    return [self isValid:value]?[value boolValue]:NO;
}

-(NSArray *)arrayValueFrom:(id)object forKey:(NSString *)key {
    id value = [object objectForKey:key];
    return [self isValid:value]?value:@[];
}

#pragma mark -

-(BOOL)isValid:(id)value {
    return (value && ![value isEqual:[NSNull null]]);
}

#pragma mark -

-(void)traceParams {
    NSLog(@"Trance Params methods not implemented");
}

@end
