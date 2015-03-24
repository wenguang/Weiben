//
//  WBTimelineWireframe.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTimelineWireframe.h"
#import "WBTimelineViewController.h"
#import "WBTimelinePresenter.h"

#import "WBPostingWireframe.h"
#import "WBDetailWireframe.h"

#import "WBUtility.h"

static NSString *timelineViewControllerID = @"WBTimelineViewController";

@interface WBTimelineWireframe()

@property (nonatomic, strong) WBTimelineViewController *timelineViewController;

@end

@implementation WBTimelineWireframe

- (void)showTimelineViewFromViewController:(UIViewController *)fromViewController
{
    if (self.timelineViewController == nil)
    {
        self.timelineViewController = [self instantiateViewController];
        self.timelineViewController.eventHandler = self.timelinePresenter;
        self.timelinePresenter.userInterface = self.timelineViewController;
    }
    [fromViewController.navigationController pushViewController:self.timelineViewController animated:YES];
}
- (void)showPostingView
{
    [self.posingWireframe showPostingViewWithMode:WBPostViewModeEditing postID:nil fromViewController:self.timelineViewController];
}
- (void)showDetailView:(NSString *)postID
{
    [self.posingWireframe showPostingViewWithPostID:postID fromViewController:self.timelineViewController];
}
- (void)dismissTimelineView
{
    
}

#pragma mark - Private

- (WBTimelineViewController *)instantiateViewController
{
    return (WBTimelineViewController *)[WBUtility instantiateViewControllerWithStoryboardName:@"Main" viewControllerID:timelineViewControllerID];
}

@end
