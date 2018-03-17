//
//  AlertHelper.h
//  Zenge
//
//  Created by Narikbi on 10/27/15.
//  Copyright (c) 2015 Zenge. All rights reserved.
//



@interface AlertHelper : NSObject

+ (void)showInController:(id)controller title:(NSString *)title;
+ (void)showInController:(id)controller message:(NSString *)message;
+ (void)showInController:(id)controller title:(NSString *)title message:(NSString *)message;

@end
