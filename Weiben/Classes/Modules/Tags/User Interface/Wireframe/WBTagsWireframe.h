//
//  WBTagsWireframe.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@class WBTagsPresenter;
@class WBPostingWireframe;
@class WBDetailWireframe;

@interface WBTagsWireframe : NSObject

@property (nonatomic, strong) WBTagsPresenter *tagsPresenter;
@property (nonatomic, strong) WBPostingWireframe *postingWireframe;
@property (nonatomic, strong) WBDetailWireframe *detailWireframe;

- (void)showTagsViewFromViewController:(UIViewController *)fromViewController;
- (void)showPostingView;
- (void)showDetailView;
- (void)dismissTagsView;

@end
