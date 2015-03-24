//
//  WBStarredViewInterface.h
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@protocol WBStarredViewInterface <NSObject>

- (void)showPosts:(NSArray *)posts;

- (void)showHUD;
- (void)hideHUD;

@end
