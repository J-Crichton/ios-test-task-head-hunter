//
//  Area.h
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "ModelObject.h"

@interface Area : ModelObject

@property (nonatomic, strong) NSNumber *areaId;
@property (nonatomic, strong) NSString *name;

+ (Area *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
