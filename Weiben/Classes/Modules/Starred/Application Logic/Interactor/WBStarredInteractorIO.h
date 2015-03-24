//
//  WBStarredInteractorIO.h
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@protocol WBStarredInteractorInput <NSObject>

- (void)findStarPosts;
- (void)removePost:(NSString *)identifier;

@end

@protocol WBStarredInteractorOutput <NSObject>

- (void)foundStarPosts:(NSArray *)posts;
//- (void)postRemoved:(NSString *)removedIdentifier;

@end
