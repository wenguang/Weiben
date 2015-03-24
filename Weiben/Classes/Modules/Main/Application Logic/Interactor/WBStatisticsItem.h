//
//  WBStatisticsItem.h
//  Weiben
//
//  Created by wenguang pan on 1/7/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

typedef NS_ENUM(NSInteger, WBStatisticType)
{
    WBStatisticTypePhoto,
    WBStatisticTypeTimeline,
    WBStatisticTypeStar
};

@interface WBStatisticsItem : NSObject

@property (nonatomic, readonly, assign) WBStatisticType type;
@property (nonatomic, readonly, assign) NSUInteger postCount;

- (instancetype)initWithType:(WBStatisticType)type postCount:(NSUInteger)postCount;

@end
