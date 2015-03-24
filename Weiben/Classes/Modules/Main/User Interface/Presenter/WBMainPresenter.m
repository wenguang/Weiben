//
//  WBMainPresenter.m
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBMainPresenter.h"
#import "WBMainWireframe.h"
#import "WBStatisticsDisplayData.h"
#import "WBStatisticsDisplayItem.h"
#import "WBStatisticsItem.h"
#import "ObjectiveSugar.h"

@implementation WBMainPresenter

- (void)updateView
{
    [self.userInterface showHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.mainInteractor findPostStatistics];
    });
}

- (void)foundPostStatistics:(NSArray *)items
{
    WBStatisticsDisplayData *displayData = [self statisticsDisplayDataWithItems:items];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.userInterface showStatisticsDisplayData:displayData];
        [self.userInterface hideHUD];
    });
}

- (WBStatisticsDisplayData *)statisticsDisplayDataWithItems:(NSArray *)items
{
    NSMutableArray *stats = [NSMutableArray array];
    __block WBStatisticsDisplayItem *stat;
    __block WBStatisticsItem *item;
    [items each:^(id object) {
        
        item = (WBStatisticsItem *)object;
        stat = [WBStatisticsDisplayItem statisticsItemWithType:item.type count:item.postCount];
        [stats addObject:stat];
    }];
    
    return [WBStatisticsDisplayData statisticsDisplayDateWithItems:stats];
}

#pragma mark - wireframe

- (void)toPhotosView
{
    [self.mainWireframe showPhotosView];
}
/*
- (void)toTagsView
{
    [self.mainWireframe showTagsView];
}
 */
- (void)toTimelineView
{
    [self.mainWireframe showTimelineView];
}
- (void)toStarredView
{
    [self.mainWireframe showStarredView];
}
- (void)toSettingsView
{
    [self.mainWireframe showSettingsView];
}
- (void)toPostingView
{
    [self.mainWireframe showPostingView];
}
- (void)toPostingViewWithImage:(UIImage *)image
{
    [self.mainWireframe showPostingViewWithImage:image];
}

@end
