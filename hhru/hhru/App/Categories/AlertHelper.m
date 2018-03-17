//
//  AlertHelper.m
//  Zenge
//
//  Created by Narikbi on 10/27/15.
//  Copyright (c) 2015 Zenge. All rights reserved.
//

#import "AlertHelper.h"

@implementation AlertHelper

+ (void)showInController:(id)controller title:(NSString *)title {
    [self showInController:controller title:title message:@""];
}

+ (void)showInController:(id)controller message:(NSString *)message {
    [self showInController:controller title:@"" message:message];
}

+ (void)showInController:(id)controller title:(NSString *)title message:(NSString *)message
{
    // If controller is not set or it's not subclass of UIViewController set to rootViewController.
    if(!controller || ![controller isKindOfClass:[UIViewController class]]) {
        id rootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        if(rootVC) {
            controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        } else return;
    }

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    // Ok button.
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:ok];

    if(controller) {
        [controller presentViewController:alertController animated:YES completion:^{

        }];
    }
}

@end
