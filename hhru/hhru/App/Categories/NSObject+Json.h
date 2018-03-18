

#import <Foundation/Foundation.h>

@interface NSObject (Json)

- (id)JSONValue;
- (NSString *)JSONRepresentation;
- (NSString *)JSONRepresentationPretyPrinted:(BOOL)pretyPrinted;

- (id)parseFromJsonFile:(NSString *)jsonFileName;

@end
