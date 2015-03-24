//
//  WBBarItemImageView.m
//  Weiben
//
//  Created by wenguang pan on 2/15/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBBarItemImageView.h"

@implementation WBBarItemImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_target && _action)
    {
        [_target performSelector:_action];
    }
}

@end
