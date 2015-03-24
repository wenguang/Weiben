//
//  WBPostingWireframe.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostingViewController.h"

@class WBPostingPresenter;
@class WBDetailWireframe;

@interface WBPostingWireframe : NSObject

@property (nonatomic, strong) WBPostingPresenter *postingPresenter;
@property (nonatomic, strong) WBDetailWireframe *detailWireframe;

- (void)showPostingViewWithPostID:(NSString *)postID fromViewController:(UIViewController *)fromViewController;

- (void)showPostingViewWithImage:(UIImage *)image fromViewController:(UIViewController *)fromViewController;

- (void)showPostingViewWithMode:(WBPostViewMode)mode postID:(NSString *)postID fromViewController:(UIViewController *)fromViewController;

- (void)showDetailView;
- (void)dismissPostingView;

@end
