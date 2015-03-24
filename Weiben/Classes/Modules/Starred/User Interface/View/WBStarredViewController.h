//
//  WBStarredViewController.h
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredViewInterface.h"
#import "WBStarredModuleInterface.h"
#import "MGSwipeTableCell.h"

@interface WBStarredViewController : UIViewController <WBStarredViewInterface, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate>

@property (nonatomic, strong) id<WBStarredModuleInterface> eventHandler;

@end
