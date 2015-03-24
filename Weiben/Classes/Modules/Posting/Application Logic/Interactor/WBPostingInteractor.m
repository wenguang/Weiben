//
//  WBWritingInteractor.m
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostingInteractor.h"
#import "WBDataManager.h"
#import "WBPostItem.h"
#import "WBPost.h"

@interface WBPostingInteractor()

@property (nonatomic, strong) WBDataManager *dataManager;

@end

@implementation WBPostingInteractor

- (id)init
{
    if (self = [super init])
    {
        _dataManager = [WBDataManager manager];
    }
    return self;
}

#pragma mark - WBPostingInteractorInput

- (void)findPostWithIdentifier:(NSString *)identifier
{
    WBPost *post = [self.dataManager getPostWithIdentifier:identifier];
    WBPostItem *postItem;
    UIImage *image = [[UIImage alloc] initWithData:post.imageData];
    postItem = [WBPostItem postItemWithText:post.text image:image date:post.date star:post.star location:post.location place:post.place tags:nil identifier:post.identifier];
    [self.output foundPost:postItem];
}

- (void)newPostWithText:(NSString *)text tags:(NSArray *)tags image:(UIImage *)image star:(BOOL)star location:(CLLocation *)location place:(NSString *)place
{
    NSDate *now = [NSDate date];
    NSString *uuidString = [[NSUUID UUID] UUIDString];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.0);
    
    WBPost *post = [WBPost postWithText:text imageData:imageData date:now star:star location:location place:place tags:tags identifier:uuidString];
    
    if ([self.dataManager createPost:post])
    {
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        WBPostItem *postItem = [WBPostItem postItemWithText:text image:image date:now star:star location:location place:place tags:nil identifier:uuidString];
        [self.output itemForNewPost:postItem];
    }
    else
    {
        [self.output itemForNewPost:nil];
    }
}

- (void)updatePost:(WBPostItem *)postItem
{
    NSData *imageData = UIImageJPEGRepresentation(postItem.image, 0.0);
    WBPost *post = [WBPost postWithText:postItem.text imageData:imageData date:postItem.date star:postItem.star location:postItem.location place:postItem.place tags:nil identifier:postItem.identifier];
    
    [self.dataManager updatePost:post];
    [self.output postUpdated:postItem];
}

- (void)deletePost:(NSString *)postID
{
    [self.dataManager deletePost:postID];
    [self.output postDeleted:postID];
}

@end
