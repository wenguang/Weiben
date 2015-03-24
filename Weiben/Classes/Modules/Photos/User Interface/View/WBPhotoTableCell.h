//
//  WBPhotoTableCell.h
//  Weiben
//
//  Created by wenguang pan on 3/17/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBSwipeTableCell.h"
#import "WBPostItem.h"
#import "WBPhotoDisplayItem.h"

@interface WBPhotoTableCell : WBSwipeTableCell

@property (nonatomic, strong) WBPhotoDisplayItem *displayItem;

@end
