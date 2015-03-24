//
//  WBPhotosWireframe.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPhotosWireframe.h"
#import "WBPhotosViewController.h"
#import "WBPhotosPresenter.h"

#import "WBPostingWireframe.h"
#import "WBDetailWireframe.h"

#import "WBUtility.h"


static NSString *photosViewControllerID = @"WBPhotosViewController";

@interface WBPhotosWireframe()

@property (nonatomic, strong) WBPhotosViewController *photosViewController;

@end

@implementation WBPhotosWireframe

- (void)showPhotosViewFromViewController:(UIViewController *)fromViewController
{
    if (self.photosViewController == nil)
    {
        self.photosViewController = [self instantiateViewController];
        self.photosViewController.eventHandler = self.photosPresenter;
        self.photosPresenter.userInterface = self.photosViewController;
    }

    UINavigationController *navigationController = fromViewController.navigationController;
    [navigationController pushViewController:self.photosViewController animated:YES];
}
- (void)showPostingView
{
    //[self.postingWireframe showPostingViewFromViewController:self.photosViewController];
}
- (void)showPostingViewWithImage:(UIImage *)image
{
    [self.postingWireframe showPostingViewWithImage:image fromViewController:self.photosViewController];
}
- (void)showDetailView:(NSString *)postID
{
    [self.postingWireframe showPostingViewWithPostID:postID fromViewController:self.photosViewController];
}
- (void)dismissPhotosView
{
    
}

#pragma mark - Private

- (WBPhotosViewController *)instantiateViewController
{
    return (WBPhotosViewController *)[WBUtility instantiateViewControllerWithStoryboardName:@"Main" viewControllerID:photosViewControllerID];
}

@end
