//
//  WBTimelineModuleInterface.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@protocol WBTimelineModuleInterface <NSObject>

- (void)toPostingView;
- (void)toDetailView:(NSString *)postID;

- (void)updateView;

@end
