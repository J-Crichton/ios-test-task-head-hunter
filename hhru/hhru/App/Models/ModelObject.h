//
//  ModelObject.h
//  Myth
//
//  Created by Narikbi on 11/13/12.
//
//

#import <Foundation/Foundation.h>

@interface ModelObject : NSObject {
    NSDictionary *objectData;
}

-(BOOL)isValid:(id)value;

-(id)idValueForKey:(NSString *)key;
-(NSString *)stringValueForKey:(NSString *)key;
-(NSNumber *)numberValueForKey:(NSString *)key;
-(NSDate *)dateValueForKey:(NSString *)key dateFormat:(NSString *)dateFormat;
-(BOOL)boolValueForKey:(NSString *)key;
-(NSInteger)integerValueForKey:(NSString *)key;
-(float)floatValueForKey:(NSString *)key;
-(NSArray *)arrayValueForKey:(NSString *)key;
-(id)dictionaryValueForKey:(NSString *)key;

-(id)idValueFrom:(id)object forKey:(NSString *)key;
-(NSString *)stringValueFrom:(id)object forKey:(NSString *)key;
-(NSNumber *)numberValueFrom:(id)object forKey:(NSString *)key;
-(NSDate *)dateValueFrom:(id)object forKey:(NSString *)key dateFormat:(NSString *)dateFormat;
-(NSInteger)integerValueFrom:(id)object forKey:(NSString *)key;
-(float)floatValueFrom:(id)object forKey:(NSString *)key;
-(BOOL)boolValueFrom:(id)object forKey:(NSString *)key;
-(NSArray *)arrayValueFrom:(id)object forKey:(NSString *)key;

-(void)traceParams;

@end
