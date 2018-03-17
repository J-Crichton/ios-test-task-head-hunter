//
// Created by Narikbi on 4/9/14.
// Copyright (c) 2014 Crystal Spring LLC. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSObject (Json)

- (id)JSONValue;
- (NSString *)JSONRepresentation;
- (NSString *)JSONRepresentationPretyPrinted:(BOOL)pretyPrinted;

- (id)parseFromJsonFile:(NSString *)jsonFileName;

@end
