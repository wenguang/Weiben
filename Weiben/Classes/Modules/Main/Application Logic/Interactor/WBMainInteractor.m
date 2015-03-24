//
//  WBMainInteractor.m
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBMainInteractor.h"
#import "WBDataManager.h"
#import "WBStatisticsItem.h"

@interface WBMainInteractor()

@property (nonatomic, strong) WBDataManager *dataManager;

@end

@implementation WBMainInteractor

- (id)init
{
    if (self = [super init])
    {
        _dataManager = [WBDataManager manager];
    }
    return self;
}

- (void)findPostStatistics
{
    NSUInteger postCount = [self.dataManager allPostsCount];
    NSUInteger countWithPicture = [self.dataManager postsCountWithPicture];
    NSUInteger countByStarred = [self.dataManager postsCountByStarred];
    WBStatisticsItem *allStat = [[WBStatisticsItem alloc] initWithType:WBStatisticTypeTimeline postCount:postCount];
    WBStatisticsItem *photoStat = [[WBStatisticsItem alloc] initWithType:WBStatisticTypePhoto postCount:countWithPicture];
    WBStatisticsItem *starStat = [[WBStatisticsItem alloc] initWithType:WBStatisticTypeStar postCount:countByStarred];
    NSArray *array = [NSArray arrayWithObjects:allStat, photoStat, starStat, nil];
    [self.output foundPostStatistics:array];
}

@end
