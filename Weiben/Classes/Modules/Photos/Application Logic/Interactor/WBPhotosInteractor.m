//
//  WBPhotosInteractor.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPhotosInteractor.h"
#import "WBDataManager.h"
#import "WBPostItem.h"
#import "WBUtility.h"
#import "NSArray+WBUtility.h"

@interface WBPhotosInteractor()

@property (nonatomic, strong) WBDataManager *dataManager;

@end

@implementation WBPhotosInteractor

- (id)init
{
    if (self = [super init])
    {
        _dataManager = [WBDataManager manager];
    }
    return self;
}

- (void)findPhotoPosts
{
    NSArray *posts = [[self.dataManager postsWithPicture] reverse];
    
    NSMutableArray *postItems = [NSMutableArray array];
    __block WBPostItem *postItem;
    __block WBPost *post;
    [posts each:^(id object) {
        post = (WBPost *)object;
        postItem = [WBUtility getItemWithPost:post];
        [postItems addObject:postItem];
    }];
    [self.output foundPhotoPosts:postItems];
}

@end
