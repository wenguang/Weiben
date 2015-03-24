//
//  WBDetailWireframe.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@class WBDetailPresenter;
@class WBPostingWireframe;

@interface WBDetailWireframe : NSObject

@property (nonatomic, strong) WBDetailPresenter *detailPresenter;
@property (nonatomic, strong) WBPostingWireframe *postingWireframe;

- (void)showDetailViewFromViewController:(UIViewController *)fromViewController;
- (void)showPostingView;
- (void)dismissDetailView;

@end
