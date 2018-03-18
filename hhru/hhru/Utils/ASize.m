//
//  ASize.m
//

#import "ASize.h"
#import <UIKit/UIKit.h>

@implementation ASize

+(float)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}
+(float)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}
+(float)screenHeightWithoutStatusBar {
    return [self screenHeight] - 20;
}
+(float)screenHeightWithoutStatusBarAndTabBar {
    return [self screenHeightWithoutStatusBar] - 49;
}
+(float)screenHeightWithoutStatusBarAndNavigationBar {
    return [self screenHeightWithoutStatusBar] - 44;
}
+(float)screenHeightWithoutStatusBarAndNavigationBarAndTabBar {
    return [self screenHeightWithoutStatusBarAndTabBar] - 49;
}
+(float)screenHeightWithoutNavigationBar {
    return [self screenHeight] - 44;
}

+ (CGFloat)screenWidthSidePadding:(CGFloat)padding {
    return [self screenWidth] - 2 * padding;
}

+ (CGFloat)screenWidthPercent:(CGFloat)percent {
    return (CGFloat) ([self screenWidth] * (percent * 0.01));
}

+ (CGFloat)screenMiddleX {
    return (CGFloat) ([self screenWidth] * 0.5);
}

@end
