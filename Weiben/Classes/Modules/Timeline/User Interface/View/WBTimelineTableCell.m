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
        
        CGRect leftCircleRect = CGRectMake(10, (rect.size.height - 20) / 2, 20, 20);
        [leftCircleImage drawInRect:leftCircleRect];
        
        UIFont *intervalHeadTextFont = [UIFont boldSystemFontOfSize:18];
        UIColor *intervalHeadTextColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
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
        [leftCircleImage drawInRect:CGRectMake(16, (rect.size.height - 8) / 2, 8, 8)];
        
        if (_displayItem.scaledImage)
        {
            CGSize imageSize = CGSizeMake(72, 72);
            [_displayItem.scaledImage drawInRect:CGRectMake(rect.size.width - imageSize.width - 4, (rect.size.height - imageSize.height) / 2, imageSize.width, imageSize.height)];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateText = [dateFormatter stringFromDate:_displayItem.postItem.date];
        NSString *yearMonthText = [dateText substringToIndex:7];
        UIFont *yearMonthFont = [UIFont boldSystemFontOfSize:12];
        UIColor *yearMonthColor = [UIColor grayColor];
        NSDictionary *yearMonthAttribute = @{
                                             NSFontAttributeName:yearMonthFont,
                                             NSForegroundColorAttributeName:yearMonthColor
                                             };
        CGSize yearMonthTextSize = [yearMonthText sizeWithAttributes:yearMonthAttribute];
        [yearMonthText drawInRect:CGRectMake(30, 6, yearMonthTextSize.width, yearMonthTextSize.height) withAttributes:yearMonthAttribute];
        NSString *dayText = [dateText substringFromIndex:8];
        UIFont *dayFont = [UIFont boldSystemFontOfSize:34];
        UIColor *dayColor = _displayItem.postItem.star ? [UIColor colorWithRed:0.99 green:0.67 blue:0.0 alpha:1.0] : [UIColor colorWithRed:0.41 green:0.41 blue:0.41 alpha:1.0];
        NSDictionary *dayAttribute = @{
                                    NSFontAttributeName:dayFont,
                                    NSForegroundColorAttributeName:dayColor
                                    };
        CGSize dayTextSize = [dayText sizeWithAttributes:dayAttribute];
        [dayText drawInRect:CGRectMake(30, 6 + yearMonthTextSize.height, dayTextSize.width, dayTextSize.height) withAttributes:dayAttribute];
        
        if (_displayItem.postItem.place && ![_displayItem.postItem.place isEqualToString:@""])
        {
            UIImage *pinImage  = [UIImage imageNamed:@"pin-orange-16.png"];
            [pinImage drawInRect:CGRectMake(30, 6 + yearMonthTextSize.height + dayTextSize.height, 12, 12)];
            UIFont *placeFont = [UIFont systemFontOfSize:9];
            UIColor *placeColor = [UIColor colorWithRed:0.32 green:0.32 blue:0.32 alpha:0.95];
            NSDictionary *placeAttribute = @{
                                             NSFontAttributeName:placeFont,
                                             NSForegroundColorAttributeName:placeColor
                                             };
            CGSize placeSize = [_displayItem.postItem.place sizeWithAttributes:placeAttribute];
            [_displayItem.postItem.place drawInRect:CGRectMake(30 + 12, 6 + yearMonthTextSize.height + dayTextSize.height + 2, placeSize.width, placeSize.height) withAttributes:placeAttribute];
        }
        
        if (_displayItem.postItem.text && ![_displayItem.postItem.text isEqualToString:@""])
        {
            UIFont *textFont = [UIFont systemFontOfSize:13];
            UIColor *textColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.0];
            NSDictionary *textAttribute = @{
                                            NSFontAttributeName:textFont,
                                            NSForegroundColorAttributeName:textColor
                                            };
            [_displayItem.postItem.text drawInRect:CGRectMake(30 + yearMonthTextSize.width + 5, 6 + yearMonthTextSize.height, rect.size.width - (30 + yearMonthTextSize.width + 5) - 72 - 6, dayTextSize.height) withAttributes:textAttribute];
        }
    }
}

@end
