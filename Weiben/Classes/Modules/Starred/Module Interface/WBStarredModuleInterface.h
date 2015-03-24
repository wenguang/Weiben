//
//  WBStarredModuleInterface.h
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@protocol WBStarredModuleInterface <NSObject>

- (void)updateView;
- (void)toPostingView;
- (void)toDetailView:(NSString *)postID;

- (void)removePostItem:(NSString *)postID;

@end
