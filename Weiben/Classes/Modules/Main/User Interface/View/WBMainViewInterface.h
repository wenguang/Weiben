
//
//  WBMainViewInterface.h
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBStatisticsDisplayData.h"

@protocol WBMainViewInterface <NSObject>

- (void)showStatisticsDisplayData:(WBStatisticsDisplayData *)data;
- (void)reload;

- (void)showHUD;
- (void)hideHUD;

- (void)setBarItemsEnabled:(BOOL)enabled;

@end
