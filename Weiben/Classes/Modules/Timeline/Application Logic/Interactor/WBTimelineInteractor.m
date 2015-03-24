//
//  WBTimelineInteractor.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTimelineInteractor.h"
#import "WBDataManager.h"
#import "WBPostItem.h"
#import "WBUtility.h"

@interface WBTimelineInteractor()
{
    WBDataManager *_dataManager;
}

@end

@implementation WBTimelineInteractor

- (id)init
{
    if (self = [super init])
    {
        _dataManager = [WBDataManager manager];
    }
    return self;
}

- (void)findTimelinePosts
{
    NSArray *posts = [_dataManager allPosts];
    
    NSMutableArray *postItems = [NSMutableArray array];
    __block WBPostItem *postItem;
    __block WBPost *post;
    [posts each:^(id object) {
        post = object;
        postItem = [WBUtility getItemWithPost:post];
        [postItems addObject:postItem];
    }];
    [self.output foundTimelinePosts:postItems];
}

@end
