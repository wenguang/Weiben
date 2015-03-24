//
//  UIView+WBUtility.m
//  Weiben
//
//  Created by wenguang pan on 1/31/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "UIView+WBUtility.h"

@implementation UIView (WBUtility)

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
