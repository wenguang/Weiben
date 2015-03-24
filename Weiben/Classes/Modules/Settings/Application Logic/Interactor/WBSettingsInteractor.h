//
//  WBSettingsInteractor.h
//  Weiben
//
//  Created by wenguang pan on 12/14/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBSettingsInteractorIO.h"

@interface WBSettingsInteractor : NSObject <WBSettingsInteractorInput>

@property (nonatomic, strong) id<WBSettingsInteractorOutput> output;

@end
