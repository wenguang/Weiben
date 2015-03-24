//
//  WBTimelineInteractor.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTimelineInteractorIO.h"

@interface WBTimelineInteractor : NSObject <WBTimelineInteractorInput>

@property (nonatomic, strong) id<WBTimelineInteractorOutput> output;

@end
