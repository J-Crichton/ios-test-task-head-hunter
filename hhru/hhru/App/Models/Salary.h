//
//  Salary.h
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "ModelObject.h"

@interface Salary : ModelObject

@property (nonatomic, strong) NSNumber *from;
@property (nonatomic, strong) NSNumber *to;
@property (nonatomic, assign) BOOL      gross;
@property (nonatomic, strong) NSString *currency;

+ (Salary *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (instancetype)initWithFrom:(NSNumber *)from to:(NSNumber *)to gross:(BOOL)gross currency:(NSString *)currency;
- (NSString *)formattedRange;

@end
