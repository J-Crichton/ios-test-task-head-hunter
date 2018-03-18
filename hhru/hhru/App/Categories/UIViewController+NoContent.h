//
// Created by Narikbi on 11/25/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kNoContentContainerTag 404

@interface UIViewController (NoContent)

- (UIView *)showNoContentMessage:(NSString *)message;
- (UIView *)showNoContentMessage:(NSString *)message icon:(UIImage *)iconImage;
- (UIView *)showNoContentMessage:(NSString *)message withButton:(NSString *)buttonTitle selector:(SEL)_selector;
- (UIView *)showNoContentMessage:(NSString *)message icon:(UIImage *)iconImage withButton:(NSString *)buttonTitle selector:(SEL)_selector;
- (UIView *)showNoContentMessage:(NSString *)message icon:(UIImage *)iconImage withButton:(NSString *)buttonTitle selector:(SEL)_selector topOffset:(CGFloat)topOffset;

- (void)removeNoContentMessageIfExists;

- (UIView *)showNoContentMessage:(NSString *)message topOffset:(CGFloat)topOffset;

@end
