//
//  WBPostingWireframe.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostingWireframe.h"
#import "WBPostingViewController.h"
#import "WBPostingPresenter.h"

#import "WBUtility.h"
#import "WBPostingPresentationTransition.h"
#import "WBPostingDismissalTransition.h"

static NSString *postingViewControllerID = @"WBPostingViewController";

@interface WBPostingWireframe() <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) WBPostingViewController *postingViewController;

@end

@implementation WBPostingWireframe

- (void)showPostingViewWithPostID:(NSString *)postID fromViewController:(UIViewController *)fromViewController
{
    [self showPostingViewWithMode:WBPostViewModeDetail postID:postID fromViewController:fromViewController];
}

- (void)showPostingViewWithImage:(UIImage *)image fromViewController:(UIViewController *)fromViewController
{
    if (self.postingViewController == nil)
    {
        self.postingViewController = [self instantiateViewController];
        self.postingViewController.eventHandler = self.postingPresenter;
        self.postingPresenter.userInterface = self.postingViewController;
    }
    self.postingViewController.mode = WBPostViewModeEditing;
    [self.postingViewController preImage:image];
    
    [fromViewController.navigationController pushViewController:self.postingViewController animated:YES];
}

- (void)showPostingViewWithMode:(WBPostViewMode)mode postID:(NSString *)postID fromViewController:(UIViewController *)fromViewController
{
    if (self.postingViewController == nil)
    {
        self.postingViewController = [self instantiateViewController];
        self.postingViewController.eventHandler = self.postingPresenter;
        self.postingPresenter.userInterface = self.postingViewController;
    }
    self.postingViewController.mode = mode;
    self.postingViewController.postID = postID;
    
    [fromViewController.navigationController pushViewController:self.postingViewController animated:YES];
    return;
}
- (void)showDetailView
{
    
}
- (void)dismissPostingView
{
    [self.postingViewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIViewControllerTransitioningDelegate Methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[WBPostingDismissalTransition alloc] init];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [[WBPostingPresentationTransition alloc] init];
}

#pragma mark - Private

- (WBPostingViewController *)instantiateViewController
{
    return (WBPostingViewController *)[WBUtility instantiateViewControllerWithStoryboardName:@"Main" viewControllerID:postingViewControllerID];
}

@end
