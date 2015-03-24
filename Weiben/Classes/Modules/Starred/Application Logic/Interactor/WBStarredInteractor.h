//
//  WBStarredInteractor.h
//  Weiben
//
//  Created by wenguang pan on 1/29/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBStarredInteractorIO.h"

@interface WBStarredInteractor : NSObject <WBStarredInteractorInput>

@property (nonatomic, strong) id<WBStarredInteractorOutput> output;

@end
