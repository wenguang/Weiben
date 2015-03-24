//
//  WBStarredWireframe.m
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredWireframe.h"
#import "WBStarredViewController.h"
#import "WBStarredPresenter.h"
#import "WBPostingWireframe.h"
#import "WBUtility.h"

static NSString *starredViewControllerID = @"WBStarredViewController";

@interface WBStarredWireframe()

@property (nonatomic, strong) WBStarredViewController *starredViewController;

@end

@implementation WBStarredWireframe

- (void)showStarredViewFromViewController:(UIViewController *)fromViewController
{
    if (self.starredViewController == nil)
    {
        self.starredViewController = [self instantiateViewController];
        self.starredViewController.eventHandler = self.starredPresenter;
        self.starredPresenter.userInterface = self.starredViewController;
    }
    
    UINavigationController *navigationController = fromViewController.navigationController;
    [navigationController pushViewController:self.starredViewController animated:YES];
}

- (void)showPostingView
{
    [self.postingWireframe showPostingViewWithMode:WBPostViewModeEditing postID:nil fromViewController:self.starredViewController];
}

- (WBStarredViewController *)instantiateViewController
{
    return (WBStarredViewController *)[WBUtility instantiateViewControllerWithStoryboardName:@"Main" viewControllerID:starredViewControllerID];
}

- (void)showDetailView:(NSString *)postID
{
    [self.postingWireframe showPostingViewWithPostID:postID fromViewController:self.starredViewController];
}

@end
