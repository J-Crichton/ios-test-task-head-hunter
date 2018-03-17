//
//  LoadingFooterView.m
//  
//

#import "LoadingFooterView.h"
#import "ASize.h"
#import "FrameAccessor.h"

@implementation LoadingFooterView

+ (LoadingFooterView *)footerView {
    
    LoadingFooterView *view = [[NSBundle mainBundle] loadNibNamed:@"LoadingFooterView" owner:self options:nil].firstObject;
    view.width = [ASize screenWidth];
    view.height = 80;
    [view layoutIfNeeded];
    
    return view;
    
}



@end
