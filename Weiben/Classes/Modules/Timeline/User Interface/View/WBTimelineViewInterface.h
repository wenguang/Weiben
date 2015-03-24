//
//  WBTimelineViewInterface.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@protocol WBTimelineViewInterface <NSObject>

- (void)showDisplayData:(NSArray *)data;
- (void)reload;

- (void)showHUD;
- (void)hideHUD;

@end