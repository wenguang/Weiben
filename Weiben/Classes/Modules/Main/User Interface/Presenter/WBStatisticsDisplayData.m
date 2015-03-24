//
//  WBStatisticsDisplayData.m
//  Weiben
//
//  Created by wenguang pan on 1/7/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStatisticsDisplayData.h"

@interface WBStatisticsDisplayData()

@property (nonatomic, copy) NSArray *items;

@end

@implementation WBStatisticsDisplayData

+ (instancetype)statisticsDisplayDateWithItems:(NSArray *)items
{
    WBStatisticsDisplayData *data = [[WBStatisticsDisplayData alloc] init];
    data.items = items;
    return data;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    if (![object isKindOfClass:[WBStatisticsDisplayData class]])
    {
        return NO;
    }
    return [self isEqualToStatisticsDisplayData:object];
}

- (BOOL)isEqualToStatisticsDisplayData:(WBStatisticsDisplayData *)data
{
    if (!data)
    {
        return NO;
    }
    
    return [self.items isEqualToArray:data.items];
}

- (NSUInteger)hash
{
    return [self.items hash];
}

@end
