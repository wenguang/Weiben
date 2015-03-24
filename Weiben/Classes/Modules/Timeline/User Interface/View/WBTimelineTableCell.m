//
//  WBTimelineTableCell.m
//  Weiben
//
//  Created by wenguang pan on 2/23/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

#import "WBTimelineTableCell.h"
#import "WBPostItem.h"

@implementation WBTimelineTableCell

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (_displayItem.intervalHead)
    {
        NSString *intervalHeadText;
        UIImage *leftCircleImage;
        if (_displayItem.timelineInterval == WBTimelineIntervalInOneDay)
        {
            intervalHeadText = @"一天以内";
            leftCircleImage = [UIImage imageNamed:@"circle-red-24.png"];
        }
        else if (_displayItem.timelineInterval == WBTimelineIntervalInOneWeek)
        {
            intervalHeadText = @"一周以内";
            leftCircleImage = [UIImage imageNamed:@"circle-orange-24.png"];
        }
        else if (_displayItem.timelineInterval == WBTimelineIntervalInOneMonth)
        {
            intervalHeadText = @"一月以内";
            leftCircleImage = [UIImage imageNamed:@"circle-green-24.png"];
        }
        else
        {
            intervalHeadText = @"一月以前";
            leftCircleImage = [UIImage imageNamed:@"circle-blue-24.png"];
        }
        
        CGRect leftCircleRect = CGRectMake(10, 12, 20, 20);
        [leftCircleImage drawInRect:leftCircleRect];
        
        UIFont *intervalHeadTextFont = [UIFont systemFontOfSize:18];
        UIColor *intervalHeadTextColor = [UIColor blackColor];
        NSDictionary *attribute = @{
                                    NSFontAttributeName:intervalHeadTextFont,
                                    NSForegroundColorAttributeName:intervalHeadTextColor
                                    };
        CGSize intervalHeadTextSize = [intervalHeadText sizeWithAttributes:attribute];
        [intervalHeadText drawInRect:CGRectMake(50, (rect.size.height - intervalHeadTextSize.height) / 2, intervalHeadTextSize.width, intervalHeadTextSize.height) withAttributes:attribute];
    }
    else
    {
        UIImage *leftCircleImage;
        if (_displayItem.timelineInterval == WBTimelineIntervalInOneDay)
        {
            leftCircleImage = [UIImage imageNamed:@"circle-red-16.png"];
        }
        else if (_displayItem.timelineInterval == WBTimelineIntervalInOneWeek)
        {
            leftCircleImage = [UIImage imageNamed:@"circle-orange-16.png"];
        }
        else if (_displayItem.timelineInterval == WBTimelineIntervalInOneMonth)
        {
            leftCircleImage = [UIImage imageNamed:@"circle-green-16.png"];
        }
        else
        {
            leftCircleImage = [UIImage imageNamed:@"circle-blue-16.png"];
        }
        [leftCircleImage drawInRect:CGRectMake(16, 26, 8, 8)];
        
        if (_displayItem.scaledImage)
        {
            CGSize imageSize = CGSizeMake(46, 46);
            [_displayItem.scaledImage drawInRect:CGRectMake(rect.size.width - imageSize.width - 6, (rect.size.height - imageSize.height) / 2, imageSize.width, imageSize.height)];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateText = [dateFormatter stringFromDate:_displayItem.postItem.date];
        NSString *yearMonthText = [dateText substringToIndex:7];
        UIFont *yearMonthFont = [UIFont systemFontOfSize:12];
        UIColor *yearMonthColor = [UIColor blackColor];
        NSDictionary *yearMonthAttribute = @{
                                             NSFontAttributeName:yearMonthFont,
                                             NSForegroundColorAttributeName:yearMonthColor
                                             };
        CGSize yearMonthTextSize = [yearMonthText sizeWithAttributes:yearMonthAttribute];
        [yearMonthText drawInRect:CGRectMake(35, 2, yearMonthTextSize.width, yearMonthTextSize.height) withAttributes:yearMonthAttribute];
        NSString *dayText = [dateText substringFromIndex:8];
        UIFont *dayFont = [UIFont boldSystemFontOfSize:23];
        UIColor *dayColor = _displayItem.postItem.star ? [UIColor colorWithRed:0.99 green:0.67 blue:0.0 alpha:1.0] : [UIColor colorWithRed:0.41 green:0.41 blue:0.41 alpha:1.0];
        NSDictionary *dayAttribute = @{
                                    NSFontAttributeName:dayFont,
                                    NSForegroundColorAttributeName:dayColor
                                    };
        CGSize dayTextSize = [dayText sizeWithAttributes:dayAttribute];
        [dayText drawInRect:CGRectMake(35, 2 + yearMonthTextSize.height, dayTextSize.width, dayTextSize.height) withAttributes:dayAttribute];
        
        if (_displayItem.postItem.place && ![_displayItem.postItem.place isEqualToString:@""])
        {
            UIImage *pinImage  = [UIImage imageNamed:@"pin-orange-16.png"];
            [pinImage drawInRect:CGRectMake(35, 2 + yearMonthTextSize.height + dayTextSize.height, 12, 12)];
            UIFont *placeFont = [UIFont systemFontOfSize:9];
            UIColor *placeColor = [UIColor blackColor];
            NSDictionary *placeAttribute = @{
                                             NSFontAttributeName:placeFont,
                                             NSForegroundColorAttributeName:placeColor
                                             };
            CGSize placeSize = [_displayItem.postItem.place sizeWithAttributes:placeAttribute];
            [_displayItem.postItem.place drawInRect:CGRectMake(35 + 12, 2 + yearMonthTextSize.height + dayTextSize.height, placeSize.width, placeSize.height) withAttributes:placeAttribute];
        }
        
        if (_displayItem.postItem.text && ![_displayItem.postItem.text isEqualToString:@""])
        {
            UIFont *textFont = [UIFont systemFontOfSize:16];
            UIColor *textColor = [UIColor blackColor];
            NSDictionary *textAttribute = @{
                                            NSFontAttributeName:textFont,
                                            NSForegroundColorAttributeName:textColor
                                            };
            [_displayItem.postItem.text drawInRect:CGRectMake(35 + yearMonthTextSize.width + 5, 2 + yearMonthTextSize.height, rect.size.width - (35 + yearMonthTextSize.width + 5) - 46 - 6, dayTextSize.height) withAttributes:textAttribute];
        }
    }
}

@end
