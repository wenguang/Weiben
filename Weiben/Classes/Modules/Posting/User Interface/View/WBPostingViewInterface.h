//
//  WBWritingViewInterface.h
//  Weiben
//
//  Created by wenguang pan on 11/30/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostItem.h"

@class WBPostDisplayData;

@protocol WBPostingViewInterface <NSObject>

- (void)showDisplayData:(WBPostDisplayData *)displayData;
- (void)currentPostDeleted;

- (void)showHUD;
- (void)hideHUD;
- (void)setBarItemsEnabled:(BOOL)enabled;

- (void)switchToEditMode;
- (void)switchToDetailMode;

@end