//
//  WBStarredInteractor.m
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredInteractor.h"
#import "WBPost.h"
#import "WBPostItem.h"
#import "WBDataManager.h"
#import "WBUtility.h"
#import "NSArray+WBUtility.h"

@interface WBStarredInteractor()

@property (nonatomic, strong) WBDataManager *dataManager;

@end

@implementation WBStarredInteractor

- (id)init
{
    if (self = [super init])
    {
        _dataManager = [WBDataManager manager];
    }
    return self;
}


- (void)findStarPosts
{
    NSArray *posts = [[self.dataManager postsByStarrd] reverse];
    NSMutableArray *postItems = [NSMutableArray array];
    __block WBPostItem *postItem;
    __block WBPost *post;
    [posts each:^(id object) {
        post = (WBPost *)object;
        postItem = [WBUtility getItemWithPost:post];
        [postItems addObject:postItem];
    }];
    [self.output foundStarPosts:postItems];
}

- (void)removePost:(NSString *)identifier
{
    [self.dataManager deletePost:identifier];
    //[self.output postRemoved:identifier];
}

@end
