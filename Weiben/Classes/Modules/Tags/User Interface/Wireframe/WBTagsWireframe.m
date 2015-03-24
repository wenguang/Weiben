//
//  WBTagsWireframe.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTagsWireframe.h"
#import "WBTagsViewController.h"
#import "WBTagsPresenter.h"

#import "WBPostingWireframe.h"
#import "WBDetailWireframe.h"

#import "WBUtility.h"

static NSString *tagsViewControllerID = @"WBTagsViewController";

@interface WBTagsWireframe()

@property (nonatomic, strong) WBTagsViewController *tagsViewController;

@end

@implementation WBTagsWireframe

- (void)showTagsViewFromViewController:(UIViewController *)fromViewController
{
    if (self.tagsViewController == nil)
    {
        self.tagsViewController = [self instantiateViewController];
        self.tagsViewController.eventHandler = self.tagsPresenter;
        self.tagsPresenter.userInterface = self.tagsViewController;
    }
    [fromViewController.navigationController pushViewController:self.tagsViewController animated:YES];
}
- (void)showPostingView
{
    //[self.postingWireframe showPostingViewFromViewController:self.tagsViewController];
}
- (void)showDetailView
{
    [self.detailWireframe showDetailViewFromViewController:self.tagsViewController];
}
- (void)dismissTagsView
{
    
}

#pragma mark - Private

- (WBTagsViewController *)instantiateViewController
{
    return (WBTagsViewController *)[WBUtility instantiateViewControllerWithStoryboardName:@"Main" viewControllerID:tagsViewControllerID];
}

@end
