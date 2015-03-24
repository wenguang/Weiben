//
//  WBDataManager.h
//  Weiben
//
//  Created by wenguang pan on 12/8/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "Store.h"
#import "Model.h"

@interface WBDataManager : NSObject

+ (id)manager;

#pragma mark - Create

- (BOOL)createPost:(WBPost *)post;
- (BOOL)createTag:(WBTag *)tag;

#pragma mark - Update

- (void)updatePost:(WBPost *)post;

#pragma mark - Get Post

- (NSArray *)allPosts;
- (NSArray *)postsWithPicture;
- (NSArray *)postsHasTag;
- (NSArray *)postsByStarrd;
- (NSArray *)postsWithTag:(NSString *)tag;
- (WBPost *)getPostWithIdentifier:(NSString *)identifier;

#pragma mark - Post Count

- (NSUInteger)allPostsCount;
- (NSUInteger)postsCountWithPicture;
- (NSUInteger)postsCountByStarred;

#pragma mark - Delete

- (void)deletePost:(NSString *)identifier;

#pragma mark - Get Tag

- (NSArray *)allTags;
- (WBTag *)getTagWithIdentifier:(NSString *)identifier;

@end
