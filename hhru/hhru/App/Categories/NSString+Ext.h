//
//  NSString+Ext.h
//  Zenge
//
//  Created by Narikbi on 9/23/15.
//  Copyright © 2015 Zenge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

+ (NSString *)randomString;

- (NSString *)trim;
- (BOOL)isNumeric;
- (BOOL)isPreciseNumeric;
+ (NSString *)formattedNumberText:(NSString *)numberStr;
- (NSString *)uppercaseFirstLetter;
- (NSDate *)dateWithDateFormat:(NSString *)dateFormat;
- (BOOL)isEmpty;
- (BOOL)isNotEmpty;

- (NSString *)phoneNumberPresentation;
- (NSString *)phoneNumberValidForCall;

- (NSString *)stringByStrippingHTML;

+ (NSString *)base64String:(NSString *)str;

- (NSString *)componentAtIndex:(NSUInteger)index separator:(NSString *)separator;
- (NSString *)or:(NSString *)orString;

- (BOOL)hasSubstring:(NSString *)substring;

- (NSString *)ifEmpty:(NSString *)text;

@end
