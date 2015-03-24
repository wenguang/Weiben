//
//  WBPhotoTableCell.m
//  Weiben
//
//  Created by wenguang pan on 3/17/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBPhotoTableCell.h"
#import "UIImage+WBUtility.h"

@interface WBPhotoTableCell()
{
}

@end

@implementation WBPhotoTableCell

- (void)drawRect:(CGRect)rect
{
    [_displayItem.scaledImage drawInRect:rect];
    
    if (_displayItem.postItem.star)
    {
        [[UIImage imageNamed:@"fav.png"] drawInRect:CGRectMake(10, 10, 24, 24)];
    }
    
    if (_displayItem.postItem.place && ![_displayItem.postItem.place isEqualToString:@""])
    {
        UIImage *pinImage  = [UIImage imageNamed:@"pin-orange-32.png"];
        [pinImage drawInRect:CGRectMake(10, rect.size.height - 30, 20, 20)];
        UIFont *placeFont = [UIFont systemFontOfSize:12];
        UIColor *placeColor = [UIColor whiteColor];
        NSDictionary *placeAttribute = @{
                                         NSFontAttributeName:placeFont,
                                         NSForegroundColorAttributeName:placeColor
                                         };
        CGSize placeSize = [_displayItem.postItem.place sizeWithAttributes:placeAttribute];
        [_displayItem.postItem.place drawInRect:CGRectMake(30, rect.size.height - 25, placeSize.width, placeSize.height) withAttributes:placeAttribute];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateText = [dateFormatter stringFromDate:_displayItem.postItem.date];
    UIFont *dateTextFont = [UIFont systemFontOfSize:11];
    UIColor *dateTextColor = [UIColor whiteColor];
    NSDictionary *dateAttribute = @{
                                         NSFontAttributeName:dateTextFont,
                                         NSForegroundColorAttributeName:dateTextColor
                                         };
    CGSize dateTextSize = [dateText sizeWithAttributes:dateAttribute];
    [dateText drawInRect:CGRectMake(rect.size.width - dateTextSize.width - 10, 10, dateTextSize.width, dateTextSize.height) withAttributes:dateAttribute];
}

@end
