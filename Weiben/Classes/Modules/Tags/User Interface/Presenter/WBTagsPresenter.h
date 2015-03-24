//
//  WBTagsPresenter.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTagsInteractorIO.h"
#import "WBTagsModuleInterface.h"
#import "WBTagsViewInterface.h"

@class WBTagsWireframe;

@interface WBTagsPresenter : NSObject <WBTagsModuleInterface, WBTagsInteractorOutput>

@property (nonatomic, strong) id<WBTagsInteractorInput> tagsInteractor;
@property (nonatomic, strong) id<WBTagsViewInterface> userInterface;
@property (nonatomic, strong) WBTagsWireframe *tagsWireframe;

@end
