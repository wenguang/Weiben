//
//  WBStarredWireframe.h
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@class WBStarredPresenter;
@class WBPostingWireframe;

@interface WBStarredWireframe : NSObject

@property (nonatomic, strong) WBStarredPresenter *starredPresenter;
@property (nonatomic, strong) WBPostingWireframe *postingWireframe;

- (void)showStarredViewFromViewController:(UIViewController *)fromViewController;
- (void)showPostingView;
- (void)showDetailView:(NSString *)postID;


@end
