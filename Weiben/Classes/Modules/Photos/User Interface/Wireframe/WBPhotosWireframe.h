//
//  WBPhotosWireframe.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@class WBPhotosPresenter;
@class WBPostingWireframe;
@class WBDetailWireframe;

@interface WBPhotosWireframe : NSObject

@property (nonatomic, strong) WBPhotosPresenter *photosPresenter;
@property (nonatomic, strong) WBPostingWireframe *postingWireframe;
@property (nonatomic, strong) WBDetailWireframe *detailWireframe;

- (void)showPhotosViewFromViewController:(UIViewController *)fromViewController;
- (void)showPostingView;
- (void)showPostingViewWithImage:(UIImage *)image;
- (void)showDetailView:(NSString *)postID;
- (void)dismissPhotosView;

@end
