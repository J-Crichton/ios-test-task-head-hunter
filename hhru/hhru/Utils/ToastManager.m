//
//  ToastManager.m
//  BaiBazar
//

#import "ToastManager.h"
#import "Chameleon.h"


@implementation ToastManager

+ (void)showPlainMessage:(NSString *)message tap:(tapBlock)tap {
    [self showMessage:message color:[UIColor flatPurpleColor] tap:tap];
}

+ (void)showError:(NSString *)message {
    [self showMessage:message color:[UIColor flatRedColor] tap:nil];
}

+ (void)showSuccess:(NSString *)message {
    [self showMessage:message color:[UIColor flatGreenColor] tap:nil];
}

+ (void)showMessage:(NSString *)message color:(UIColor *)color tap:(tapBlock)tap {
    
    NSMutableDictionary *options = [@{
                              kCRToastTextKey : message,
                              kCRToastFontKey : [UIFont systemFontOfSize:15],
                              kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastTimeIntervalKey : @(2.0),
                              kCRToastBackgroundColorKey : color,
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              } mutableCopy];
    
    options[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap automaticallyDismiss:YES block:^(CRToastInteractionType interactionType){
        if (interactionType == CRToastInteractionTypeTapOnce) {
            if (tap) tap();
        }
    }]];

    [CRToastManager showNotificationWithOptions:options
                                completionBlock:nil];
    
}

@end
