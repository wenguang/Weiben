//
//  WBDetailWireframe.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBDetailWireframe.h"
#import "WBDetailViewController.h"
#import "WBDetailPresenter.h"

#import "WBUtility.h"

static NSString *detailViewControllerID = @"WBDetailViewController";

@interface WBDetailWireframe()

@property (nonatomic, strong) WBDetailViewController *detailViewController;

@end

@implementation WBDetailWireframe

- (void)showDetailViewFromViewController:(UIViewController *)fromViewController
{
    if (self.detailViewController == nil)
    {
        self.detailViewController = [self instantiateViewController];
        self.detailViewController.eventHandler = self.detailPresenter;
        self.detailPresenter.userInterface = self.detailViewController;
    }
    [fromViewController.navigationController pushViewController:self.detailViewController animated:YES];
}
- (void)showPostingView
{
    
}
- (void)dismissDetailView
{
    
}

#pragma mark - Private

- (WBDetailViewController *)instantiateViewController
{
    return (WBDetailViewController *)[WBUtility instantiateViewControllerWithStoryboardName:@"Main" viewControllerID:detailViewControllerID];
}

@end
