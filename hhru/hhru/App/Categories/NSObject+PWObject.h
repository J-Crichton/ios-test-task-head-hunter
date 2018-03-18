
#import <Foundation/Foundation.h>


@interface NSObject (PWObject)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (void)performBlockOnSecond:(void (^)(void))block;

@end
