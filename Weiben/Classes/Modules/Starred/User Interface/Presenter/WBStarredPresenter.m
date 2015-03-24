//
//  WBStarredPresenter.m
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredPresenter.h"
#import "WBStarredDisplayItem.h"

@implementation WBStarredPresenter

- (void)updateView
{
    [self.userInterface showHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.starredInteractor findStarPosts];
    });
}

- (void)foundStarPosts:(NSArray *)posts
{
    NSMutableArray *displayArray = [NSMutableArray array];
    WBStarredDisplayItem *displayItem;
    for (WBPostItem *item in posts) {
        
        displayItem = [WBStarredDisplayItem itemWithPostItem:item scaleSize:CGSizeMake(66, 66)];
        [displayArray addObject:displayItem];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.userInterface showPosts:displayArray];
        [self.userInterface hideHUD];
    });
}

- (void)removePostItem:(NSString *)postID
{
    [self.starredInteractor removePost:postID];
}

#pragma mark - wireframe

- (void)toPostingView
{
    [self.starredWireframe showPostingView];
}

- (void)toDetailView:(NSString *)postID
{
    [self.starredWireframe showDetailView:postID];
}

@end
