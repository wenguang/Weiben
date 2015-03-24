//
//  WBStarredDisplayItem.m
//  Weiben
//
//  Created by wenguang pan on 3/24/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredDisplayItem.h"
#import "UIImage+WBUtility.h"

@implementation WBStarredDisplayItem

+ (instancetype)itemWithPostItem:(WBPostItem *)postItem scaleSize:(CGSize)scaleSize
{
    WBStarredDisplayItem *item = [[WBStarredDisplayItem alloc] init];
    item.postItem = postItem;
    if (postItem.image)
    {
        item.scaledImage = [postItem.image imageByScalingAndCroppingForSize:scaleSize];
    }
    return item;
}

@end
