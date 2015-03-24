//
//  WBSettingsWireframe.h
//  Weiben
//
//  Created by wenguang pan on 12/14/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@class WBSettingsPresenter;

@interface WBSettingsWireframe : NSObject

@property (nonatomic, strong) WBSettingsPresenter *settingsPresenter;

- (void)showSettingsViewFromViewController:(UIViewController *)fromViewController;
- (void)dismissSettingsView;

@end
