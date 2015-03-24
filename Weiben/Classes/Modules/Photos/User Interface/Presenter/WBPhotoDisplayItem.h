//
//  WBPhotoDisplayItem.h
//  Weiben
//
//  Created by wenguang pan on 3/24/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@class WBPostItem;

@interface WBPhotoDisplayItem : NSObject

@property (nonatomic, strong) WBPostItem *postItem;
@property (nonatomic, strong) UIImage *scaledImage;

+ (instancetype)itemWithPostItem:(WBPostItem *)postItem scaleSize:(CGSize)scaleSize;

@end
