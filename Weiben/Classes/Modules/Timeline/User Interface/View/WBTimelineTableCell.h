//
//  WBTimelineTableCell.h
//  Weiben
//
//  Created by wenguang pan on 2/23/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBSwipeTableCell.h"
#import "WBTimelineDisplayItem.h"

@interface WBTimelineTableCell : WBSwipeTableCell

@property (nonatomic, strong) WBTimelineDisplayItem *displayItem;

@end
