//
//  WBMainBackgroundView.m
//  Weiben
//
//  Created by wenguang pan on 3/18/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBMainBackgroundView.h"

@implementation WBMainBackgroundView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSString *name = @"W E I B E N";
    NSString *enName = @"记 录 精 彩";
    UIFont *font = [UIFont boldSystemFontOfSize:24];
    UIColor *color = [UIColor colorWithWhite:1.0 alpha:0.3];
    NSDictionary *attribute = @{
                                    NSFontAttributeName:font,
                                    NSForegroundColorAttributeName:color
                                    };
    CGSize nameSize = [name sizeWithAttributes:attribute];
    [name drawInRect:CGRectMake((rect.size.width - nameSize.width) / 2, _upX + (_upBlankHeight - nameSize.height) / 2, nameSize.width, nameSize.height) withAttributes:attribute];
    
    font = [UIFont boldSystemFontOfSize:32];
    attribute = @{
                  NSFontAttributeName:font,
                  NSForegroundColorAttributeName:color
                  };
    CGSize enNameSize = [enName sizeWithAttributes:attribute];
    [enName drawInRect:CGRectMake((rect.size.width - enNameSize.width) / 2, (rect.size.height - _downBlankHeight) + (_downBlankHeight - enNameSize.height) / 2, enNameSize.width, enNameSize.height) withAttributes:attribute];
}

@end
