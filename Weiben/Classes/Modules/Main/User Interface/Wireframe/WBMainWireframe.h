//
//  WBMainWireframe.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@class WBMainPresenter;
@class WBPhotosWireframe;
@class WBTagsWireframe;
@class WBTimelineWireframe;
@class WBPostingWireframe;
@class WBSettingsWireframe;
@class WBStarredWireframe;

@interface WBMainWireframe : NSObject

@property (nonatomic, strong) WBMainPresenter *mainPresenter;
@property (nonatomic, strong) WBPhotosWireframe *photosWireframe;
@property (nonatomic, strong) WBTagsWireframe *tagsWireframe;
@property (nonatomic, strong) WBTimelineWireframe *timelineWireframe;
@property (nonatomic, strong) WBStarredWireframe *starredWireframe;
@property (nonatomic, strong) WBPostingWireframe *postingWireframe;
@property (nonatomic, strong) WBSettingsWireframe *settingsWireframe;

- (void)showMainViewFromWindow:(UIWindow *)fromWindow;
- (void)showMainViewFromViewController:(UIViewController *)fromViewController;
- (void)showPhotosView;
- (void)showTagsView;
- (void)showTimelineView;
- (void)showStarredView;
- (void)showPostingView;
- (void)showPostingViewWithImage:(UIImage *)image;
- (void)showSettingsView;

@end
