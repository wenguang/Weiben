//
//  WBStarredTableCell.m
//  Weiben
//
//  Created by wenguang pan on 3/18/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredTableCell.h"

@implementation WBStarredTableCell

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"star2.png"] drawInRect:CGRectMake(rect.size.width - 24 - 5, 5, 24, 24)];
    
    if (_displayItem.scaledImage)
    {
        [_displayItem.scaledImage drawInRect:CGRectMake(5, 5, rect.size.height - 10, rect.size.height - 10)];
    }
    
    if (_displayItem.postItem.text && ![_displayItem.postItem.text isEqualToString:@""])
    {
        UIFont *textFont = [UIFont systemFontOfSize:13];
        UIColor *textColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.0];
        NSDictionary *textAttribute = @{
                                        NSFontAttributeName:textFont,
                                        NSForegroundColorAttributeName:textColor
                                        };
        CGFloat textX = _displayItem.postItem.image ? 70 + 15 : 15;
        [_displayItem.postItem.text drawInRect:CGRectMake(textX, 15, rect.size.width - textX - 30, 55) withAttributes:textAttribute];
    }
    if (_displayItem.postItem.place && ![_displayItem.postItem.place isEqualToString:@""])
    {
        UIImage *pinImage  = [UIImage imageNamed:@"pin-orange-16.png"];
        CGFloat pinX = _displayItem.postItem.image ? 70 + 10 : 10;
        [pinImage drawInRect:CGRectMake(pinX, 65, 12, 12)];
        UIFont *placeFont = [UIFont systemFontOfSize:9];
        UIColor *placeColor = [UIColor grayColor];
        NSDictionary *placeAttribute = @{
                                         NSFontAttributeName:placeFont,
                                         NSForegroundColorAttributeName:placeColor
                                         };
        CGSize placeSize = [_displayItem.postItem.place sizeWithAttributes:placeAttribute];
        [_displayItem.postItem.place drawInRect:CGRectMake(pinX + 12, 65, placeSize.width, placeSize.height) withAttributes:placeAttribute];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateText = [dateFormatter stringFromDate:_displayItem.postItem.date];
    UIFont *dateTextFont = [UIFont systemFontOfSize:9];
    UIColor *dateTextColor = [UIColor grayColor];
    NSDictionary *dateAttribute = @{
                                    NSFontAttributeName:dateTextFont,
                                    NSForegroundColorAttributeName:dateTextColor
                                    };
    CGSize dateTextSize = [dateText sizeWithAttributes:dateAttribute];
    [dateText drawInRect:CGRectMake(rect.size.width - dateTextSize.width - 40, 5, dateTextSize.width, dateTextSize.height) withAttributes:dateAttribute];
}

@end
