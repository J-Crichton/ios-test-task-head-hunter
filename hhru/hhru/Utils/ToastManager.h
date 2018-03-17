//
//  ToastManager.h
//  BaiBazar
//
//  Created by Narikbi on 25.10.16.
//  Copyright © 2016 app.baibazar.kz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRToast.h"

typedef void(^tapBlock)();

@interface ToastManager : NSObject

+ (void)showPlainMessage:(NSString *)message tap:(tapBlock)tap;
+ (void)showError:(NSString *)message;
+ (void)showSuccess:(NSString *)message;

+ (void)showMessage:(NSString *)message color:(UIColor *)color tap:(tapBlock)tap;


@end
