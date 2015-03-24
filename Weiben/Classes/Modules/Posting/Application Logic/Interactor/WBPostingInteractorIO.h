//
//  WBWritingInteractorIO.h
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPost.h"
#import "WBPostItem.h"

@protocol WBPostingInteractorInput <NSObject>

- (void)findPostWithIdentifier:(NSString *)identifier;

- (void)newPostWithText:(NSString *)text tags:(NSArray *)tags image:(UIImage *)image star:(BOOL)star location:(CLLocation *)location place:(NSString *)place;

- (void)updatePost:(WBPostItem *)postItem;
- (void)deletePost:(NSString *)postID;

@end

@protocol WBPostingInteractorOutput <NSObject>

- (void)foundPost:(WBPostItem *)postItem;
- (void)itemForNewPost:(WBPostItem *)postItem;
- (void)postUpdated:(WBPostItem *)postItem;
- (void)postDeleted:(NSString *)deletedPostID;

@end
