//
//  WBTimelineInteractorIO.h
//  Weiben
//
//  Created by wenguang pan on 12/15/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@protocol WBTimelineInteractorInput <NSObject>

- (void)findTimelinePosts;

@end

@protocol WBTimelineInteractorOutput <NSObject>

- (void)foundTimelinePosts:(NSArray *)posts;

@end
