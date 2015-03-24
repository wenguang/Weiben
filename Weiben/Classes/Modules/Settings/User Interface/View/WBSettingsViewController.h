//
//  WBSettingsViewController.h
//  Weiben
//
//  Created by wenguang pan on 12/14/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBSettingsViewInterface.h"
#import "WBSettingsModuleInterface.h"

@interface WBSettingsViewController : UIViewController <WBSettingsViewInterface>

@property (nonatomic, strong) id<WBSettingsModuleInterface> eventHandler;

@end
