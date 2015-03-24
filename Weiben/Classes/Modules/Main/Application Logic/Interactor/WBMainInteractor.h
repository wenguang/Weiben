//
//  WBMainInteractor.h
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBMainInteractorIO.h"

@interface WBMainInteractor : NSObject <WBMainInteractorInput>

@property (nonatomic, strong) id<WBMainInteractorOutput> output;

@end
