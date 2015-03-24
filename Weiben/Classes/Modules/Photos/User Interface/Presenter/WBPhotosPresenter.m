//
//  WBPhotosPresenter.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPhotosPresenter.h"
#import "WBPhotosWireframe.h"
#import "WBPhotoDisplayItem.h"
#import "NSArray+WBUtility.h"

@implementation WBPhotosPresenter

- (void)updateView
{
    [self.userInterface showHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.photosInteractor findPhotoPosts];
    });
}

- (void)foundPhotoPosts:(NSArray *)posts
{
    CGFloat scaleWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize scaleSize = CGSizeMake(scaleWidth, 250);
    NSMutableArray *displayArray = [NSMutableArray array];
    WBPhotoDisplayItem *displayItem;
    for (WBPostItem *item in posts) {
        
        displayItem = [WBPhotoDisplayItem itemWithPostItem:item scaleSize:scaleSize];
        [displayArray addObject:displayItem];
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.userInterface showPosts:displayArray];
        [self.userInterface hideHUD];
    });
}

#pragma mark - Wireframe

- (void)toPostingView
{
    [self.photosWireframe showPostingView];
}

- (void)toPostingViewWithImage:(UIImage *)image
{
    [self.photosWireframe showPostingViewWithImage:image];
}

- (void)toDetailView:(NSString *)postID
{
    [self.photosWireframe showDetailView:postID];
}

@end
