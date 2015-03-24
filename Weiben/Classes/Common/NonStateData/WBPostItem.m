//
//  WBPostItem.m
//  Weiben
//
//  Created by wenguang pan on 1/5/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBPostItem.h"

@implementation WBPostItem

+ (instancetype)postItemWithText:(NSString *)text image:(UIImage *)image date:(NSDate *)date star:(BOOL)star location:(CLLocation *)location place:(NSString *)place tags:(NSMutableArray *)tags identifier:(NSString *)identifier
{
    WBPostItem *postItem = [[WBPostItem alloc] init];
    postItem.text = text;
    postItem.image = image;
    postItem.date = date;
    postItem.star = star;
    postItem.location = location;
    postItem.place = place;
    postItem.tags = tags;
    postItem.identifier = identifier;
    return postItem;
}

@end
