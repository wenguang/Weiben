//
//  WBTimelineViewController.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTimelineViewInterface.h"
#import "WBTimelineModuleInterface.h"

@interface WBTimelineViewController : UIViewController <WBTimelineViewInterface, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) id<WBTimelineModuleInterface> eventHandler;

@end
