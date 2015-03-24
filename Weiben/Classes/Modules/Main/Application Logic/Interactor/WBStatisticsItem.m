//
//  WBStatisticsItem.m
//  Weiben
//
//  Created by wenguang pan on 1/7/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStatisticsItem.h"

@implementation WBStatisticsItem

- (instancetype)initWithType:(WBStatisticType)type postCount:(NSUInteger)postCount
{
    if (self = [super init])
    {
        _type = type;
        _postCount = postCount;
    }
    return self;
}

@end
