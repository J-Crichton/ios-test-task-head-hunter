

#import "NSString+Ext.h"
#import "NSDateFormatter+Ext.h"
#import "NSNumberFormatter+Ext.h"

@implementation NSString (Ext)

+ (NSString *)randomString
{
    return [NSString stringWithFormat:@"%c%c%c%c%c%c",
            (char)(65 + (arc4random() % 25)),
            (char)(48 + (arc4random() % 9)),
            (char)(65 + (arc4random() % 25)),
            (char)(48 + (arc4random() % 9)),
            (char)(65 + (arc4random() % 25)),
            (char)(65 + (arc4random() % 25))];
}

-(NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(BOOL)isNumeric {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    return [alphaNums isSupersetOfSet:inStringSet];
}

- (BOOL)isPreciseNumeric {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber* number = [numberFormatter numberFromString:self];
    return number != nil;
}

+(NSString *)formattedNumberText:(NSString *)numberStr
{
    NSNumberFormatter *f = [NSNumberFormatter enUS];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *numberValue = [f numberFromString:numberStr];

    NSNumberFormatter* nf = [NSNumberFormatter enUS];
    [nf setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [nf setNumberStyle: NSNumberFormatterDecimalStyle];
    [nf setMaximumFractionDigits:2];
    [nf setMinimumFractionDigits:2];
    [nf setGroupingSeparator:@" "];

    numberStr = [nf stringFromNumber:numberValue];
    return numberStr;
}

-(NSString *)uppercaseFirstLetter {
    if(self.length == 0) return @"";
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] capitalizedString]];
}

- (NSDate *)dateWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *dateFromString = [dateFormatter dateFromString:self];
    return dateFromString;
}

- (BOOL)isEmpty {
    return [self trim].length == 0;
}

- (BOOL)isNotEmpty {
    return ![self isEmpty];
}

- (NSString *)phoneNumberPresentation {
    return [NSString stringWithFormat:@"+7%@", self];
}

- (NSString *)phoneNumberValidForCall
{
    NSString *number = [self stringByReplacingOccurrencesOfString:@"(" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@")" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return number;
}

+ (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];

    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;

    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;

            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }

        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }

    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (NSString *)componentAtIndex:(NSUInteger)index separator:(NSString *)separator {
    NSArray *array = [self componentsSeparatedByString:separator];
    return index < array.count ? array[index] : @"";
}

- (NSString *)or:(NSString *)orString
{
    if(![self isEmpty]) return self;
    if(!orString) orString = @"";
    return orString;
}

- (BOOL)hasSubstring:(NSString *)substring {
    return [self rangeOfString:substring].location != NSNotFound;
}

- (NSString *)ifEmpty:(NSString *)text {
    return [self isNotEmpty] ? self : text;
}


-(NSString *)stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}


@end
