//
//  WBTimelineWireframe.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@class WBTimelinePresenter;
@class WBPostingWireframe;
@class WBDetailWireframe;

@interface WBTimelineWireframe : NSObject

@property (nonatomic, strong) WBTimelinePresenter *timelinePresenter;
@property (nonatomic, strong) WBPostingWireframe *posingWireframe;
@property (nonatomic, strong) WBDetailWireframe *detailWireframe;

- (void)showTimelineViewFromViewController:(UIViewController *)fromViewController;
- (void)showPostingView;
- (void)showDetailView:(NSString *)postID;
- (void)dismissTimelineView;

@end
