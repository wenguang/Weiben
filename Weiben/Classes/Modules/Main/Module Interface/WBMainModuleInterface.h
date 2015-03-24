//
//  WBMainModuleInterface.h
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@protocol WBMainModuleInterface <NSObject>

- (void)updateView;

- (void)toPhotosView;
//- (void)toTagsView;
- (void)toTimelineView;
- (void)toStarredView;
- (void)toSettingsView;
- (void)toPostingView;
- (void)toPostingViewWithImage:(UIImage *)image;

@end
