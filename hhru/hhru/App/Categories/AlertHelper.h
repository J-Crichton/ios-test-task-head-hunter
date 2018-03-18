//
//  AlertHelper.h
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AlertHelper : NSObject

+ (void)showInController:(id)controller title:(NSString *)title;
+ (void)showInController:(id)controller message:(NSString *)message;
+ (void)showInController:(id)controller title:(NSString *)title message:(NSString *)message;

@end
