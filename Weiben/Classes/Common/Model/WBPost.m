//
//  WBPostItem.m
//  Weiben
//
//  Created by wenguang pan on 12/3/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPost.h"

@implementation WBPost

+ (instancetype)postWithText:(NSString *)text imageData:(NSData *)imageData date:(NSDate *)date star:(BOOL)star location:(CLLocation *)location place:(NSString *)place tags:(NSMutableArray *)tags identifier:(NSString *)identifier
{
    WBPost *post = [[WBPost alloc] init];
    post.text = text;
    post.imageData = imageData;
    post.date = date;
    post.star = star;
    post.location = location;
    post.place = place;
    post.tags = tags;
    post.identifier = identifier;
    return post;
}

@end
