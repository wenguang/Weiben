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
        [_displayItem.scaledImage drawInRect:CGRectMake(7, 7, rect.size.height - 14, rect.size.height - 14)];
    }
    
    if (_displayItem.postItem.text && ![_displayItem.postItem.text isEqualToString:@""])
    {
        UIFont *textFont = [UIFont systemFontOfSize:16];
        UIColor *textColor = [UIColor blackColor];
        NSDictionary *textAttribute = @{
                                        NSFontAttributeName:textFont,
                                        NSForegroundColorAttributeName:textColor
                                        };
        CGFloat textX = _displayItem.postItem.image ? 66 + 10 : 10;
        [_displayItem.postItem.text drawInRect:CGRectMake(textX, 25, rect.size.width - textX - 25, 30) withAttributes:textAttribute];
    }
    if (_displayItem.postItem.place && ![_displayItem.postItem.place isEqualToString:@""])
    {
        UIImage *pinImage  = [UIImage imageNamed:@"pin-orange-16.png"];
        CGFloat pinX = _displayItem.postItem.image ? 66 + 10 : 10;
        [pinImage drawInRect:CGRectMake(pinX, 65, 12, 12)];
        UIFont *placeFont = [UIFont systemFontOfSize:9];
        UIColor *placeColor = [UIColor blackColor];
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
    UIColor *dateTextColor = [UIColor blackColor];
    NSDictionary *dateAttribute = @{
                                    NSFontAttributeName:dateTextFont,
                                    NSForegroundColorAttributeName:dateTextColor
                                    };
    CGSize dateTextSize = [dateText sizeWithAttributes:dateAttribute];
    [dateText drawInRect:CGRectMake(rect.size.width - dateTextSize.width - 40, 5, dateTextSize.width, dateTextSize.height) withAttributes:dateAttribute];
}

@end
