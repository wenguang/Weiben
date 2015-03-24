//
//  WBDataManager.m
//  Weiben
//
//  Created by wenguang pan on 12/8/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBDataManager.h"
#import "ObjectiveRecord.h"
#import "ObjectiveSugar.h"

@implementation WBDataManager

#pragma mark - manager

+ (id)manager;
{
    return [[WBDataManager alloc] init];
}

#pragma mark - Create

- (BOOL)createPost:(WBPost *)post
{
    WBManagedPost *managedPost = [WBManagedPost create];
    managedPost.identifier = post.identifier;
    managedPost.text = post.text;
    managedPost.star = [NSNumber numberWithBool:post.star];
    managedPost.date = post.date;
    managedPost.latitude = [NSNumber numberWithDouble:post.location.coordinate.latitude];
    managedPost.longitude = [NSNumber numberWithDouble:post.location.coordinate.longitude];
    managedPost.place = post.place;
    managedPost.image = post.imageData;
    return [managedPost save];
}

- (BOOL)createTag:(WBTag *)tag
{
    WBManagedTag *managedTag = [WBManagedTag create];
    managedTag.identifier = tag.identifier;
    managedTag.name = tag.name;
    return [managedTag save];
}

#pragma mark - update

- (void)updatePost:(WBPost *)post
{
    WBManagedPost *managedPost = [WBManagedPost where:@"identifier == %@", post.identifier].firstObject;
    
    // you are trying to put nil in the dictionary (which is not allowed)
    /*
    NSDictionary *dictionary = @{
                                 @"text" : post.text,
                                 @"image" : post.imageData,
                                 @"star" : [NSNumber numberWithBool:post.star],
                                 @"latitude" : [NSNumber numberWithDouble:post.location.coordinate.latitude],
                                 @"longitude" : [NSNumber numberWithDouble:post.location.coordinate.longitude],
                                 @"place" : post.place
                                 };
    [managedPost update:dictionary];*/
    
    managedPost.text = post.text;
    managedPost.image = post.imageData;
    managedPost.star = [NSNumber numberWithBool:post.star];
    managedPost.place = post.place;
    managedPost.latitude = [NSNumber numberWithDouble:post.location.coordinate.latitude];
    managedPost.longitude = [NSNumber numberWithDouble:post.location.coordinate.longitude];
    
    [managedPost save];
}

#pragma mark - Post Count

- (NSUInteger)allPostsCount
{
    return [WBManagedPost count];
}

- (NSUInteger)postsCountWithPicture
{
    return [WBManagedPost countWhere:@"image != nil"];
}

- (NSUInteger)postsCountByStarred
{
    return [WBManagedPost countWhere:@"star == YES"];
}

#pragma mark - Get Post

- (NSArray *)allPosts
{
    NSMutableArray *posts = [NSMutableArray array];
    //[[WBManagedPost allWithOrder:@"date DESC"] each:^(id object) {
    [[WBManagedPost all] each:^(id object) {
        
        [posts addObject:[self getPostWithManagedPost:(WBManagedPost *)object]];
    }];
    return posts;
}

- (NSArray *)postsWithPicture
{
    NSMutableArray *posts = [NSMutableArray array];
    //[[WBManagedPost where:@"image != nil" order:@"date DESC"] each:^(id object) {
    [[WBManagedPost where:@"image != nil"] each:^(id object) {
        
        [posts addObject:[self getPostWithManagedPost:(WBManagedPost *)object]];
    }];
    return posts;
}

- (NSArray *)postsHasTag
{
    NSMutableArray *posts = [NSMutableArray array];
    [[WBManagedPost where:@"tags != nil" order:@"date DESC"] each:^(id object) {
        
        [posts addObject:[self getPostWithManagedPost:(WBManagedPost *)object]];
    }];
    return posts;
}

- (NSArray *)postsByStarrd
{
    NSMutableArray *posts = [NSMutableArray array];
    //[[WBManagedPost where:@"star == YES" order:@"date DESC"] each:^(id object) {
    [[WBManagedPost where:@"star == YES"] each:^(id object) {
        
        [posts addObject:[self getPostWithManagedPost:(WBManagedPost *)object]];
    }];
    return posts;
}

- (NSArray *)postsWithTag:(NSString *)tag
{
    NSMutableArray *posts = [NSMutableArray array];
    [[WBManagedPost where:@"todo" order:@"date DESC"] each:^(id object) {
        
        [posts addObject:[self getPostWithManagedPost:(WBManagedPost *)object]];
    }];
    return posts;
}

- (WBPost *)getPostWithIdentifier:(NSString *)identifier
{
    WBPost *post;
    post = [self getPostWithManagedPost:[WBManagedPost where:@"identifier == %@", identifier].firstObject];
    return post;
}

#pragma mark - Delete

- (void)deletePost:(NSString *)identifier
{
    WBManagedPost *managedPost = [WBManagedPost where:@"identifier == %@", identifier].firstObject;
    [managedPost delete];
    [managedPost save];
}

#pragma mark - Get Tag

- (NSArray *)allTags
{
    NSMutableArray *tags = [NSMutableArray array];
    [[WBManagedTag allWithOrder:@"name ASC"] each:^(id object) {
        
        [tags addObject:[self getTagWithManagedTag:(WBManagedTag *)object]];
    }];
    return tags;
}

- (WBTag *)getTagWithIdentifier:(NSString *)identifier
{
    WBTag *tag;
    tag = [self getTagWithManagedTag:[WBManagedTag where:@"identifier == %@", identifier].firstObject];
    return tag;
}

#pragma mark - Private
     
- (WBPost *)getPostWithManagedPost:(WBManagedPost *)managedPost
{
    if (!managedPost) return nil;
    
    WBPost *post;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[managedPost.latitude doubleValue] longitude:[managedPost.longitude doubleValue]];
    post = [WBPost postWithText:managedPost.text imageData:managedPost.image date:managedPost.date star:[managedPost.star boolValue] location:location place:managedPost.place tags:[managedPost.tags allObjects] identifier:managedPost.identifier];
    return post;
}

- (WBTag *)getTagWithManagedTag:(WBManagedTag *)managedTag
{
    if (!managedTag) return nil;
    
    WBTag *tag;
    tag = [WBTag tagWithName:managedTag.name identifier:managedTag.identifier];
    return tag;
}

@end
