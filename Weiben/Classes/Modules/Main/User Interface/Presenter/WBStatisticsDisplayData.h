//
//  WBStatisticsDisplayData.h
//  Weiben
//
//  Created by wenguang pan on 1/7/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@interface WBStatisticsDisplayData : NSObject

@property (nonatomic, readonly, copy) NSArray *items;

+ (instancetype)statisticsDisplayDateWithItems:(NSArray *)items;

@end
