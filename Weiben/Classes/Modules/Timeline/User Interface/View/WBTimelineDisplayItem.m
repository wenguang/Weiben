//
//  WBTimelineDisplayItem.m
//  Weiben
//
//  Created by wenguang pan on 3/11/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBTimelineDisplayItem.h"
#import "WBPostItem.h"
#import "UIImage+WBUtility.h"

@implementation WBTimelineDisplayItem

+ (instancetype)timelineDisplayItem:(WBPostItem *)postItem timelineInterval:(WBTimelineInterval)timelineInterval intervalHead:(BOOL)intervalHead
{
    WBTimelineDisplayItem *item = [[WBTimelineDisplayItem alloc] init];
    item.postItem = postItem;
    item.timelineInterval = timelineInterval;
    item.intervalHead = intervalHead;
    
    if (postItem.image)
    {
        item.scaledImage = [postItem.image imageByScalingAndCroppingForSize:CGSizeMake(72, 72)];
    }
    return item;
}

@end
