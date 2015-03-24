//
//  WBSettingsPresenter.h
//  Weiben
//
//  Created by wenguang pan on 12/14/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBSettingsModuleInterface.h"
#import "WBSettingsViewInterface.h"
#import "WBSettingsInteractorIO.h"

@class WBSettingsWireframe;

@interface WBSettingsPresenter : NSObject <WBSettingsModuleInterface, WBSettingsInteractorOutput>

@property (nonatomic, strong) id<WBSettingsInteractorInput> settingsInteractor;
@property (nonatomic, strong) id<WBSettingsViewInterface> userInterface;
@property (nonatomic, strong) WBSettingsWireframe *settingsWireframe;

@end
