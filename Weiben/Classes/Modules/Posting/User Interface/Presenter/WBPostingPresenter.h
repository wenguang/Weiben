//
//  WBWritingPresenter.h
//  Weiben
//
//  Created by wenguang pan on 11/30/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostingModuleInterface.h"
#import "WBPostingInteractorIO.h"
#import "WBPostingViewInterface.h"

@class WBPostingWireframe;

@interface WBPostingPresenter : NSObject <WBPostingModuleInterface, WBPostingInteractorOutput>

@property (nonatomic, strong) id<WBPostingInteractorInput> postingInteractor;
@property (nonatomic, strong) id<WBPostingViewInterface> userInterface;
@property (nonatomic, strong) WBPostingWireframe *postingWireframe;

@end
