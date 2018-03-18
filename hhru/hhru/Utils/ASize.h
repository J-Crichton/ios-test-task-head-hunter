//
//  ASize.h
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ASize : NSObject

+(float)screenWidth;
+(float)screenHeight;
+(float)screenHeightWithoutStatusBar;
+(float)screenHeightWithoutStatusBarAndTabBar;
+(float)screenHeightWithoutStatusBarAndNavigationBar;
+(float)screenHeightWithoutStatusBarAndNavigationBarAndTabBar;
+(float)screenHeightWithoutNavigationBar;

+ (CGFloat)screenWidthSidePadding:(CGFloat)padding;
+ (CGFloat)screenWidthPercent:(CGFloat)percent;

+ (CGFloat)screenMiddleX;

@end
