//
// Created by Narikbi on 11/25/14.
//

#import "UIViewController+NoContent.h"
#import "PureLayout.h"
#import "UIView+ConcisePureLayout.h"
#import "Chameleon.h"

@implementation UIViewController (NoContent)

#pragma mark -
#pragma mark No content message

- (UIView *)showNoContentMessage:(NSString *)message {
    return [self showNoContentMessage:message withButton:nil selector:nil];
}

- (UIView *)showNoContentMessage:(NSString *)message icon:(UIImage *)iconImage {
    return [self showNoContentMessage:message icon:iconImage withButton:nil selector:nil];
}

- (UIView *)showNoContentMessage:(NSString *)message withButton:(NSString *)buttonTitle selector:(SEL)_selector {
    return [self showNoContentMessage:message icon:nil withButton:buttonTitle selector:_selector];
}

- (UIView *)showNoContentMessage:(NSString *)message topOffset:(CGFloat)topOffset {
    return [self showNoContentMessage:message icon:nil withButton:nil selector:nil topOffset:topOffset];
}

- (UIView *)showNoContentMessage:(NSString *)message icon:(UIImage *)iconImage withButton:(NSString *)buttonTitle selector:(SEL)_selector {
    return [self showNoContentMessage:message icon:iconImage withButton:buttonTitle selector:_selector topOffset:0];
}

- (UIView *)showNoContentMessage:(NSString *)message icon:(UIImage *)iconImage withButton:(NSString *)buttonTitle selector:(SEL)_selector
                       topOffset:(CGFloat)topOffset {
    
    [self removeNoContentMessageIfExists];

    UIView *container = [UIView newAutoLayoutView];
    container.tag = kNoContentContainerTag;
    [self.view addSubview:container];
    [container autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
    [container aa_centerHorizontal];
    
    if (topOffset>0) {
        [container aa_superviewTop:topOffset];
    } else {
        [container aa_centerVertical];
    }

    // If icon exists
    UIImageView *iconView;
    if (iconImage) {
        iconView = [[UIImageView alloc] initWithImage:iconImage];
        [container addSubview:iconView];
        [iconView aa_superviewTop:10];
        [iconView aa_centerHorizontal];
    }
    
    UILabel *messageLabel = [UILabel newAutoLayoutView];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.textColor = [UIColor darkGrayColor];
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [container addSubview:messageLabel];
    [messageLabel aa_setWidth:260];
    
    // pin messageLabel to iconView if exits one
    if (iconImage) {
        [messageLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:iconView withOffset:20];
    } else {
        [messageLabel aa_superviewTop:10];
    }
    
    [messageLabel aa_centerHorizontal];
    messageLabel.text = message;

    UIView *lastView = messageLabel;
    
    if(buttonTitle && _selector) {
        UIButton *button = [UIButton newAutoLayoutView];
        [button setTitleColor:[UIColor flatBlueColor] forState:UIControlStateNormal];
        [button addTarget:self action:_selector forControlEvents:UIControlEventTouchUpInside];
        [button aa_setWidth:150];
        [button aa_setHeight:40];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [container addSubview:button];
        [button aa_pinUnderView:messageLabel offset:20];
        [button aa_centerHorizontal];
        
        lastView = button;
    }

    [lastView aa_superviewBottom:10];

    return container;
}


- (void)removeNoContentMessageIfExists {
    id container = [self.view viewWithTag:kNoContentContainerTag];
    if(container) {
        [container removeFromSuperview];
    }
}

@end
