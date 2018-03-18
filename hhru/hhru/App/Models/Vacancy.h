//
//  Vacancy.h
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "ModelObject.h"
#import "Area.h"
#import "Salary.h"
#import "Employer.h"

@interface Vacancy : ModelObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate   *publishedAt;

@property (nonatomic, strong) Area *area;
@property (nonatomic, strong) Salary *salary;
@property (nonatomic, strong) Employer *employer;

- (instancetype)initWithName:(NSString *)name
                 publishedAt:(NSDate *)publishedAt
                      salary:(Salary *)salary
                        area:(Area *)area
                    employer:(Employer *)employer;

+ (Vacancy *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSString *)formattedSalaryArea;


@end
