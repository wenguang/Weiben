//
//  WBStarredPresenter.h
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredModuleInterface.h"
#import "WBStarredViewInterface.h"
#import "WBStarredInteractorIO.h"
#import "WBStarredWireframe.h"

@interface WBStarredPresenter : NSObject <WBStarredModuleInterface, WBStarredInteractorOutput>

@property (nonatomic, strong) id<WBStarredViewInterface> userInterface;
@property (nonatomic, strong) id<WBStarredInteractorInput> starredInteractor;
@property (nonatomic, strong) WBStarredWireframe *starredWireframe;

@end
