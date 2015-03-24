//
//  WBMainPresenter.h
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBMainModuleInterface.h"
#import "WBMainInteractorIO.h"
#import "WBMainViewInterface.h"

@class WBMainWireframe;

@interface WBMainPresenter : NSObject <WBMainModuleInterface, WBMainInteractorOutput>

@property (nonatomic, strong) id<WBMainInteractorInput> mainInteractor;
@property (nonatomic, strong) id<WBMainViewInterface> userInterface;
@property (nonatomic, strong) WBMainWireframe *mainWireframe;

@end
