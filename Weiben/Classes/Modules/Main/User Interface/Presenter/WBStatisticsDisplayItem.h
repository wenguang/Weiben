//
//  WBStatisticsDisplayItem.h
//  Weiben
//
//  Created by wenguang pan on 1/7/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStatisticsItem.h"

@interface WBStatisticsDisplayItem : NSObject

@property (nonatomic, readonly, assign) WBStatisticType type;
@property (nonatomic, readonly, assign) NSUInteger postCount;

+ (instancetype)statisticsItemWithType:(WBStatisticType)type count:(NSUInteger)count;

@end
