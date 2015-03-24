//
//  WBPhotosInteractor.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPhotosInteractorIO.h"

@interface WBPhotosInteractor : NSObject <WBPhotosInteractorInput>

@property (nonatomic, strong) id<WBPhotosInteractorOutput> output;

@end
