//
//  WBPhotoDisplayItem.m
//  Weiben
//
//  Created by wenguang pan on 3/24/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBPhotoDisplayItem.h"
#import "WBPostItem.h"
#import "UIImage+WBUtility.h"

@implementation WBPhotoDisplayItem

+ (instancetype)itemWithPostItem:(WBPostItem *)postItem scaleSize:(CGSize)scaleSize
{
    WBPhotoDisplayItem *item = [[WBPhotoDisplayItem alloc] init];
    item.postItem = postItem;
    if (postItem.image)
    {
        item.scaledImage = [postItem.image imageByScalingAndCroppingForSize:scaleSize];
    }
    return item;
}

@end
