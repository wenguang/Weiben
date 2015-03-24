//
//  WBMainWireframe.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBMainPresenter.h"
#import "WBMainWireframe.h"
#import "WBMainViewController.h"

#import "WBPhotosWireframe.h"
#import "WBTagsWireframe.h"
#import "WBTimelineWireframe.h"
#import "WBStarredWireframe.h"
#import "WBPostingWireframe.h"
#import "WBSettingsWireframe.h"

#import "WBUtility.h"

static NSString *mainViewControllerID = @"WBMainViewController";

@interface WBMainWireframe()

@property (nonatomic, strong) WBMainViewController *mainViewController;

@end

@implementation WBMainWireframe

- (void)showMainViewFromWindow:(UIWindow *)fromWindow
{
    UINavigationController *rootNavigationController = (UINavigationController *)[fromWindow rootViewController];
    if (self.mainViewController == nil)
    {
        self.mainViewController = [self instantiateViewController];
        self.mainViewController.eventHandler = self.mainPresenter;
        self.mainPresenter.userInterface = self.mainViewController;
    }
    rootNavigationController.viewControllers = @[self.mainViewController];
}
- (void)showMainViewFromViewController:(UIViewController *)fromViewController
{
    
}
- (void)showPhotosView
{
    [self.photosWireframe showPhotosViewFromViewController:self.mainViewController];
}
- (void)showTagsView
{
    [self.tagsWireframe showTagsViewFromViewController:self.mainViewController];
}
- (void)showTimelineView
{
    [self.timelineWireframe showTimelineViewFromViewController:self.mainViewController];
}
- (void)showStarredView
{
    [self.starredWireframe showStarredViewFromViewController:self.mainViewController];
}
- (void)showPostingView
{
    [self.postingWireframe showPostingViewWithMode:WBPostViewModeEditing postID:nil fromViewController:self.mainViewController];
}
- (void)showPostingViewWithImage:(UIImage *)image
{
    [self.postingWireframe showPostingViewWithImage:image fromViewController:self.mainViewController];
}
- (void)showSettingsView
{
    [self.settingsWireframe showSettingsViewFromViewController:self.mainViewController];
}

#pragma mark - Private

- (WBMainViewController *)instantiateViewController
{
    return (WBMainViewController *)[WBUtility instantiateViewControllerWithStoryboardName:@"Main" viewControllerID:mainViewControllerID];
}

@end
