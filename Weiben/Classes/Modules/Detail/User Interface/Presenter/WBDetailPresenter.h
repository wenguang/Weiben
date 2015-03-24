//
//  WBDetailPresenter.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBDetailModuleInterface.h"
#import "WBDetailViewInterface.h"
#import "WBDetailInteractorIO.h"

@class WBDetailWireframe;

@interface WBDetailPresenter : NSObject <WBDetailModuleInterface, WBDetailInteractorOutput>

@property (nonatomic, strong) id<WBDetailInteractorInput> detailInteractor;
@property (nonatomic, strong) id<WBDetailViewInterface> userInterface;
@property (nonatomic, strong) WBDetailWireframe *detailWireframe;

@end
