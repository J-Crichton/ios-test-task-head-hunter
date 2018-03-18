//
//  Employer.h
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "ModelObject.h"

@interface Employer : ModelObject

@property (nonatomic, strong) NSNumber *empoyerId;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *name;

+ (Employer *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (instancetype)initWithEmpoyerId:(NSNumber *)empoyerId logo:(NSString *)logo name:(NSString *)name;


@end
