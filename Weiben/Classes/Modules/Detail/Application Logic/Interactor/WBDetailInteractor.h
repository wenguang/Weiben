//
//  WBDetailInteractor.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBDetailInteractorIO.h"

@interface WBDetailInteractor : NSObject <WBDetailInteractorInput>

@property (nonatomic, strong) id<WBDetailInteractorOutput> output;

@end
