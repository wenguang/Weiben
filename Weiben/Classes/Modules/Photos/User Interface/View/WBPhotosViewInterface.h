//
//  WBPhotosViewInterface.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@protocol WBPhotosViewInterface <NSObject>

- (void)showPosts:(NSArray *)posts;
- (void)reload;

- (void)showHUD;
- (void)hideHUD;

@end
