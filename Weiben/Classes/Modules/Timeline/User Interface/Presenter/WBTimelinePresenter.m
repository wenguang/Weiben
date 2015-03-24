//
//  WBTimelinePresenter.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTimelinePresenter.h"
#import "WBTimelineWireframe.h"
#import "WBPostItem.h"
#import "WBTimelineDisplayItem.h"

static const double oneDayInterval = 3600 * 24;
static const double oneWeekInterval = 3600 * 24 *7;
static const double oneMonthInterval = 3600 * 24 * 30;

@implementation WBTimelinePresenter

- (void)updateView
{
    [self.userInterface showHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.timelineInteractor findTimelinePosts];
    });
}

- (void)foundTimelinePosts:(NSArray *)posts
{
    NSArray *displayItems = [self displayArrayFromItemArray:posts];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.userInterface showDisplayData:displayItems];
        [self.userInterface hideHUD];
    });
}

- (NSArray *)displayArrayFromItemArray:(NSArray *)postItemArray
{
    NSMutableArray *displayArray = [NSMutableArray array];
    NSArray *headArray = [NSArray arrayWithObjects:
                          [WBTimelineDisplayItem timelineDisplayItem:nil timelineInterval:WBTimelineIntervalInOneDay intervalHead:YES],
                          [WBTimelineDisplayItem timelineDisplayItem:nil timelineInterval:WBTimelineIntervalInOneWeek intervalHead:YES],
                          [WBTimelineDisplayItem timelineDisplayItem:nil timelineInterval:WBTimelineIntervalInOneMonth intervalHead:YES],
                          [WBTimelineDisplayItem timelineDisplayItem:nil timelineInterval:WBTimelineIntervalAncient intervalHead:YES],
                          nil];
    NSMutableArray *inOneDayArray  = [NSMutableArray array];
    NSMutableArray *inOneWeekArray  = [NSMutableArray array];
    NSMutableArray *inOneMonthArray = [NSMutableArray array];
    NSMutableArray *ancientArray = [NSMutableArray array];
    NSTimeInterval interval;
    WBTimelineDisplayItem *displayItem;
    WBPostItem *postItem;
    
    for (int i = postItemArray.count - 1; i >= 0; i--) {
        
        postItem = postItemArray[i];
        
        interval = [postItem.date timeIntervalSinceNow] * -1;
        if (interval <= oneDayInterval)
        {
            displayItem = [WBTimelineDisplayItem timelineDisplayItem:postItem timelineInterval:WBTimelineIntervalInOneDay intervalHead:NO];
            [inOneDayArray addObject:displayItem];
        }
        else if (interval <= oneWeekInterval)
        {
            displayItem = [WBTimelineDisplayItem timelineDisplayItem:postItem timelineInterval:WBTimelineIntervalInOneWeek intervalHead:NO];
            [inOneWeekArray addObject:displayItem];
        }
        else if (interval <= oneMonthInterval)
        {
            displayItem = [WBTimelineDisplayItem timelineDisplayItem:postItem timelineInterval:WBTimelineIntervalInOneMonth intervalHead:NO];
            [inOneMonthArray addObject:displayItem];
        }
        else
        {
            displayItem = [WBTimelineDisplayItem timelineDisplayItem:postItem timelineInterval:WBTimelineIntervalAncient intervalHead:NO];
            [ancientArray addObject:displayItem];
        }
    }
    
    if (inOneDayArray.lastObject)
    {
        WBTimelineDisplayItem *lastItem = (WBTimelineDisplayItem *)inOneDayArray.lastObject;
        lastItem.intervalTail = YES;
    }
    if (inOneWeekArray.lastObject)
    {
        WBTimelineDisplayItem *lastItem = (WBTimelineDisplayItem *)inOneWeekArray.lastObject;
        lastItem.intervalTail = YES;
    }
    if (inOneMonthArray.lastObject)
    {
        WBTimelineDisplayItem *lastItem = (WBTimelineDisplayItem *)inOneMonthArray.lastObject;
        lastItem.intervalTail = YES;
    }
    if (ancientArray.lastObject)
    {
        WBTimelineDisplayItem *lastItem = (WBTimelineDisplayItem *)ancientArray.lastObject;
        lastItem.intervalTail = YES;
    }
    
    [displayArray addObject:[headArray objectAtIndex:0]];
    [displayArray addObjectsFromArray:inOneDayArray];
    [displayArray addObject:[headArray objectAtIndex:1]];
    [displayArray addObjectsFromArray:inOneWeekArray];
    [displayArray addObject:[headArray objectAtIndex:2]];
    [displayArray addObjectsFromArray:inOneMonthArray];
    [displayArray addObject:[headArray objectAtIndex:3]];
    [displayArray addObjectsFromArray:ancientArray];
    
    return displayArray;
}

#pragma mark - wireframe

- (void)toPostingView
{
    [self.timelineWireframe showPostingView];
}
- (void)toDetailView:(NSString *)postID
{
    [self.timelineWireframe showDetailView:postID];
}

@end
