//
//  ToastManager.h
//  
//

#import <Foundation/Foundation.h>
#import "CRToast.h"

typedef void(^tapBlock)(void);

@interface ToastManager : NSObject

+ (void)showPlainMessage:(NSString *)message tap:(tapBlock)tap;
+ (void)showError:(NSString *)message;
+ (void)showSuccess:(NSString *)message;

+ (void)showMessage:(NSString *)message color:(UIColor *)color tap:(tapBlock)tap;


@end
