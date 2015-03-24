//
//  WBPhotosPresenter.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPhotosInteractorIO.h"
#import "WBPhotosModuleInterface.h"
#import "WBPhotosViewInterface.h"

@class WBPhotosWireframe;

@interface WBPhotosPresenter : NSObject <WBPhotosModuleInterface, WBPhotosInteractorOutput>

@property (nonatomic, strong) id<WBPhotosInteractorInput> photosInteractor;
@property (nonatomic, strong) id<WBPhotosViewInterface> userInterface;
@property (nonatomic, strong) WBPhotosWireframe *photosWireframe;

@end
