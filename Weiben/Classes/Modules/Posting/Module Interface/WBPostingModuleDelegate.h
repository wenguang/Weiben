//
//  WBWritingModuleDelegate.h
//  Weiben
//
//  Created by wenguang pan on 11/30/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@protocol WBPostingModuleDelegate <NSObject>

- (void)didSavePosting;
- (void)didCancelPosting;

@end
