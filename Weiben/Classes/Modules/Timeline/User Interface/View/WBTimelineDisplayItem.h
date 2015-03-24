//
//  WBTimelineDisplayItem.h
//  Weiben
//
//  Created by wenguang pan on 3/11/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

typedef NS_ENUM(NSInteger, WBTimelineInterval)
{
    WBTimelineIntervalInOneDay,
    WBTimelineIntervalInOneWeek,
    WBTimelineIntervalInOneMonth,
    WBTimelineIntervalAncient
};

@class WBPostItem;

@interface WBTimelineDisplayItem : NSObject

@property (nonatomic, strong) WBPostItem *postItem;
@property (nonatomic, assign) WBTimelineInterval timelineInterval;
@property (nonatomic, assign) BOOL intervalHead;
@property (nonatomic, assign) BOOL intervalTail;

@property (nonatomic, strong) UIImage *scaledImage;

+ (instancetype)timelineDisplayItem:(WBPostItem *)postItem timelineInterval:(WBTimelineInterval)timelineInterval intervalHead:(BOOL)intervalHead;

@end
