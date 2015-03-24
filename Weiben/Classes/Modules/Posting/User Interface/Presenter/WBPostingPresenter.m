//
//  WBWritingPresenter.m
//  Weiben
//
//  Created by wenguang pan on 11/30/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostingPresenter.h"
#import "WBPostingInteractor.h"
#import "WBPostDisplayData.h"
#import "WBPostingWireframe.h"
#import "WBUtility.h"

@implementation WBPostingPresenter

#pragma mark - WBPostingModuleInterface

- (void)requestPostWithIdentifier:(NSString *)identifier
{
    [self.userInterface setBarItemsEnabled:NO];
    [self.userInterface showHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.postingInteractor findPostWithIdentifier:identifier];
    });
}

- (void)foundPost:(WBPostItem *)postItem
{
    WBPostDisplayData *displayData = [WBPostDisplayData postDisplayDataWith:postItem.text image:postItem.image date:postItem.date star:postItem.star place:postItem.place identifier:postItem.identifier];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.userInterface showDisplayData:displayData];
        [self.userInterface hideHUD];
        [self.userInterface setBarItemsEnabled:YES];
    });
}

- (void)savePostWithText:(NSString *)text tags:(NSArray *)tags image:(UIImage *)image star:(BOOL)star location:(CLLocation *)location place:(NSString *)place
{
    [self.userInterface setBarItemsEnabled:NO];
    [self.userInterface showHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.postingInteractor newPostWithText:text tags:tags image:image star:star location:location place:place];
    });
}

- (void)itemForNewPost:(WBPostItem *)postItem
{
    [[NSNotificationCenter defaultCenter] postNotificationName:[WBUtility postChangedNotification] object:self userInfo:@{[WBUtility postChangedAction]:[WBUtility postChangedActionAdd], [WBUtility postChangedItem]:postItem}];
    
    WBPostDisplayData *newDisplayData = [WBPostDisplayData postDisplayDataWith:postItem.text image:postItem.image date:postItem.date star:postItem.star place:postItem.place identifier:postItem.identifier];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.userInterface showDisplayData:newDisplayData];
        [self.userInterface hideHUD];
        [self.userInterface setBarItemsEnabled:YES];
    });
}

- (void)updatePost:(WBPostDisplayData *)displayData
{
    [self.userInterface setBarItemsEnabled:NO];
    [self.userInterface showHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        WBPostItem *postItem = [WBPostItem postItemWithText:displayData.text image:displayData.image date:displayData.date star:displayData.star location:displayData.location place:displayData.place tags:nil identifier:displayData.identifier];
        [self.postingInteractor updatePost:postItem];
    });
}

- (void)postUpdated:(WBPostItem *)postItem
{
    [[NSNotificationCenter defaultCenter] postNotificationName:[WBUtility postChangedNotification] object:self userInfo:@{[WBUtility postChangedAction]:[WBUtility postChangedActionUpdate], [WBUtility postChangedItem]:postItem}];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.userInterface showDisplayData:nil];
        [self.userInterface hideHUD];
        [self.userInterface setBarItemsEnabled:YES];
    });
}

- (void)cancelPost
{
    [self.postingWireframe dismissPostingView];
}

- (void)deletePost:(NSString *)postID
{
    [self.userInterface setBarItemsEnabled:NO];
    [self.userInterface showHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.postingInteractor deletePost:postID];
    });
}

- (void)postDeleted:(NSString *)deletedPostID
{
    [[NSNotificationCenter defaultCenter] postNotificationName:[WBUtility postChangedNotification] object:self userInfo:@{[WBUtility postChangedAction]:[WBUtility postChangedActionDelete], [WBUtility postDeletedItemID]:deletedPostID}];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.userInterface hideHUD];
        [self.userInterface setBarItemsEnabled:YES];
        [self.userInterface currentPostDeleted];
    });
}

@end
