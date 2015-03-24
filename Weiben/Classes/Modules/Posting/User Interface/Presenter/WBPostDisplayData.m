//
//  WBPostDisplayData.m
//  Weiben
//
//  Created by wenguang pan on 1/25/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBPostDisplayData.h"

@implementation WBPostDisplayData

+ (instancetype)postDisplayDataWith:(NSString *)text image:(UIImage *)image date:(NSDate *)date star:(BOOL)star place:(NSString *)place identifier:(NSString *)identifier
{
    WBPostDisplayData *displayData = [[WBPostDisplayData alloc] init];
    displayData.identifier = identifier;
    displayData.text = text;
    displayData.image = image;
    displayData.date = date;
    displayData.star = star;
    displayData.place = place;
    return displayData;
}

@end
