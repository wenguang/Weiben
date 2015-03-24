//
//  WBStatisticsDisplayItem.m
//  Weiben
//
//  Created by wenguang pan on 1/7/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStatisticsDisplayItem.h"

@interface WBStatisticsDisplayItem()

@property (nonatomic, assign) WBStatisticType type;
@property (nonatomic, assign) NSUInteger postCount;

@end

@implementation WBStatisticsDisplayItem

+ (instancetype)statisticsItemWithType:(WBStatisticType)type count:(NSUInteger)count
{
    WBStatisticsDisplayItem *item = [[WBStatisticsDisplayItem alloc] init];
    item.type = type;
    item.postCount = count;
    return item;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    if ([object isKindOfClass:[WBStatisticsDisplayItem class]])
    {
        return NO;
    }
    return [self isEqualToStatisticsItem:object];
}

- (BOOL)isEqualToStatisticsItem:(WBStatisticsDisplayItem *)item
{
    if (!item)
    {
        return NO;
    }
    
    return self.type == item.type && self.postCount == item.postCount;
}

@end
