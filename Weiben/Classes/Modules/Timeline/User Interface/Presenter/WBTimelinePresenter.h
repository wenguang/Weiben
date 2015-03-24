//
//  WBTimelinePresenter.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTimelineInteractorIO.h"
#import "WBTimelineModuleInterface.h"
#import "WBTimelineViewInterface.h"

@class WBTimelineWireframe;

@interface WBTimelinePresenter : NSObject <WBTimelineModuleInterface, WBTimelineInteractorOutput>

@property (nonatomic, strong) id<WBTimelineInteractorInput> timelineInteractor;
@property (nonatomic, strong) id<WBTimelineViewInterface> userInterface;
@property (nonatomic, strong) WBTimelineWireframe *timelineWireframe;

@end
